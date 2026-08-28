import { NextRequest } from "next/server";
import { z } from "zod";
import { PoolConnection } from "mysql2/promise";
import { getPool } from "@/lib/db";
import { requireAuth } from "@/lib/auth";
import { corsJson, handleOptions } from "@/lib/cors";
import { withErrorHandling } from "@/lib/http";

const itemSchema = z.object({
  id: z.string().min(1), // sync_queue item id (client-side outbox row id)
  entityType: z.enum(["sku_event", "skk_event", "pelantikan"]),
  entityId: z.string().min(1),
  aksi: z.string().min(1),
  payload: z.record(z.string(), z.unknown()),
});

const bodySchema = z.object({
  deviceId: z.string().min(1),
  items: z.array(itemSchema).min(1).max(200),
});

type Item = z.infer<typeof itemSchema>;

/**
 * Local outbox drain endpoint — mirrors `SyncDao.pending()` / `sync_queue`
 * on the Flutter client (PRD §6.1/§6.4/P0-7). Every item is applied
 * idempotently (safe to retry) and independently: one bad item in a batch
 * is rejected without failing the rest.
 *
 * Status on `sku_progress`/`skk_progress` is *always* recomputed from the
 * latest event by `created_at` after insert — never from "the event we
 * just received" — so out-of-order pushes from different devices still
 * converge on the correct derived status (PRD §6.3).
 */
export async function POST(request: NextRequest) {
  return withErrorHandling(async () => {
    const auth = requireAuth(request);
    const body = bodySchema.parse(await request.json());
    const pool = getPool();

    const accepted: string[] = [];
    const rejected: { id: string; reason: string }[] = [];

    for (const item of body.items) {
      const conn = await pool.getConnection();
      try {
        await conn.beginTransaction();
        await applyItem(conn, item, auth.sub, body.deviceId);
        await conn.commit();
        accepted.push(item.id);
      } catch (err) {
        await conn.rollback();
        rejected.push({
          id: item.id,
          reason: err instanceof Error ? err.message : "Unknown error",
        });
      } finally {
        conn.release();
      }
    }

    return corsJson({ accepted, rejected });
  });
}

async function applyItem(
  conn: PoolConnection,
  item: Item,
  requesterId: string,
  deviceId: string,
): Promise<void> {
  switch (item.entityType) {
    case "sku_event":
      await applyProgressEvent(conn, item, requesterId, {
        progressTable: "sku_progress",
        eventTable: "sku_event",
        itemFk: "sku_item_id",
      });
      break;
    case "skk_event":
      await applyProgressEvent(conn, item, requesterId, {
        progressTable: "skk_progress",
        eventTable: "skk_event",
        itemFk: "skk_item_id",
      });
      break;
    case "pelantikan":
      await applyPelantikan(conn, item, requesterId);
      break;
  }

  await conn.query(
    "INSERT INTO sync_log (device_id, pengguna_id, entity_type, entity_id, aksi, payload_json) VALUES (?, ?, ?, ?, ?, ?)",
    [deviceId, requesterId, item.entityType, item.entityId, item.aksi, JSON.stringify(item.payload)],
  );
}

interface ProgressTables {
  progressTable: "sku_progress" | "skk_progress";
  eventTable: "sku_event" | "skk_event";
  itemFk: "sku_item_id" | "skk_item_id";
}

const STATUS_BY_AKSI: Record<string, string> = {
  ajukan: "diajukan",
  sahkan: "disahkan",
  tolak: "ditolak",
  batal: "belum",
};

async function applyProgressEvent(
  conn: PoolConnection,
  item: Item,
  requesterId: string,
  tables: ProgressTables,
): Promise<void> {
  const p = item.payload as Record<string, unknown>;
  const progressIdField = tables.progressTable === "sku_progress" ? "sku_progress_id" : "skk_progress_id";
  const clientProgressId = str(p[progressIdField]);
  const anggotaId = str(p.anggota_id);
  const itemId = str(p[tables.itemFk]);
  const aktorId = str(p.aktor_id);
  const catatan = p.catatan == null ? null : str(p.catatan);

  if (!clientProgressId || !anggotaId || !itemId || !aktorId) {
    throw new Error(`Payload tidak lengkap untuk ${item.entityType}`);
  }
  if (aktorId !== requesterId) {
    throw new Error("aktor_id tidak sesuai dengan pengguna yang login");
  }
  if (!STATUS_BY_AKSI[item.aksi]) {
    throw new Error(`aksi tidak dikenal: ${item.aksi}`);
  }

  // Resolve the canonical progress row for (anggota, item) — if two
  // offline devices both created a progress row for the same pair with
  // different ids (rare), the one already in the DB wins; we don't
  // silently pick the newer client's id, per PRD §6.3 ("flag sebagai
  // conflict" — logged via sync_log for Admin Gudep to review).
  const [existing] = await conn.query(
    `SELECT id FROM ${tables.progressTable} WHERE anggota_id = ? AND ${tables.itemFk} = ? LIMIT 1`,
    [anggotaId, itemId],
  );
  const existingRows = existing as { id: string }[];
  let progressId = existingRows[0]?.id;

  if (!progressId) {
    await conn.query(
      `INSERT IGNORE INTO ${tables.progressTable} (id, anggota_id, ${tables.itemFk}, status) VALUES (?, ?, ?, 'belum')`,
      [clientProgressId, anggotaId, itemId],
    );
    progressId = clientProgressId;
  }

  await conn.query(
    `INSERT IGNORE INTO ${tables.eventTable} (id, ${progressIdField}, aktor_id, aksi, catatan, device_id) VALUES (?, ?, ?, ?, ?, ?)`,
    [item.entityId, progressId, aktorId, item.aksi, catatan, str(p.device_id) ?? null],
  );

  const [latest] = await conn.query(
    `SELECT aksi FROM ${tables.eventTable} WHERE ${progressIdField} = ? ORDER BY created_at DESC, id DESC LIMIT 1`,
    [progressId],
  );
  const latestRows = latest as { aksi: string }[];
  const latestStatus = STATUS_BY_AKSI[latestRows[0]?.aksi ?? item.aksi];

  await conn.query(
    `UPDATE ${tables.progressTable} SET status = ?, updated_at = NOW() WHERE id = ?`,
    [latestStatus, progressId],
  );
}

async function applyPelantikan(
  conn: PoolConnection,
  item: Item,
  requesterId: string,
): Promise<void> {
  const p = item.payload as Record<string, unknown>;
  const anggotaId = str(p.anggota_id);
  const jenis = str(p.jenis);
  const referensiLabel = str(p.referensi_label);
  const tanggal = str(p.tanggal);
  const pembinaId = str(p.pembina_id);
  const catatan = p.catatan == null ? null : str(p.catatan);

  if (!anggotaId || !jenis || !referensiLabel || !tanggal || !pembinaId) {
    throw new Error("Payload tidak lengkap untuk pelantikan");
  }
  if (pembinaId !== requesterId) {
    throw new Error("pembina_id tidak sesuai dengan pengguna yang login");
  }

  await conn.query(
    "INSERT IGNORE INTO pelantikan (id, anggota_id, jenis, referensi_label, tanggal, pembina_id, catatan) VALUES (?, ?, ?, ?, ?, ?, ?)",
    [item.entityId, anggotaId, jenis, referensiLabel, tanggal.slice(0, 10), pembinaId, catatan],
  );
}

function str(value: unknown): string | undefined {
  return typeof value === "string" ? value : undefined;
}

export const OPTIONS = handleOptions;
