import { NextRequest } from "next/server";
import { RowDataPacket } from "mysql2";
import { getPool } from "@/lib/db";
import { requireAuth } from "@/lib/auth";
import { corsJson, handleOptions } from "@/lib/cors";
import { withErrorHandling, jsonError } from "@/lib/http";

/**
 * Pulls everything that changed, gudep-wide, since the client's last
 * cursor — e.g. a pembina's pengesahan made on their device becomes
 * visible on a peserta's device next time it's online (PRD §6.5, user
 * story "pembina baru lihat pengajuan dari HP peserta" in reverse).
 *
 * Scoped by gudep rather than per-anggota: v1 is single-gudep (PRD §3),
 * and pembina/admin need visibility across all anggota anyway. The
 * client filters further locally.
 */
export async function GET(request: NextRequest) {
  return withErrorHandling(async () => {
    const auth = requireAuth(request);
    const since = request.nextUrl.searchParams.get("since");
    if (!since || Number.isNaN(Date.parse(since))) {
      return jsonError("Query param 'since' (ISO timestamp) wajib diisi.", 400);
    }

    const pool = getPool();
    const serverTime = new Date().toISOString();

    const [skuProgress] = await pool.query<RowDataPacket[]>(
      `SELECT sp.id, sp.anggota_id, sp.sku_item_id, sp.status, sp.updated_at
       FROM sku_progress sp
       JOIN anggota a ON a.id = sp.anggota_id
       JOIN pengguna pg ON pg.id = a.pengguna_id
       WHERE pg.gudep_id = ? AND sp.updated_at > ?`,
      [auth.gudepId, since],
    );

    const [skuEvents] = await pool.query<RowDataPacket[]>(
      `SELECT se.id, se.sku_progress_id, se.aktor_id, se.aksi, se.catatan, se.device_id, se.created_at
       FROM sku_event se
       JOIN sku_progress sp ON sp.id = se.sku_progress_id
       JOIN anggota a ON a.id = sp.anggota_id
       JOIN pengguna pg ON pg.id = a.pengguna_id
       WHERE pg.gudep_id = ? AND se.created_at > ?`,
      [auth.gudepId, since],
    );

    const [pelantikan] = await pool.query<RowDataPacket[]>(
      `SELECT p.id, p.anggota_id, p.jenis, p.referensi_label, p.tanggal, p.pembina_id, p.catatan, p.created_at
       FROM pelantikan p
       JOIN anggota a ON a.id = p.anggota_id
       JOIN pengguna pg ON pg.id = a.pengguna_id
       WHERE pg.gudep_id = ? AND p.created_at > ?`,
      [auth.gudepId, since],
    );

    const [anggota] = await pool.query<RowDataPacket[]>(
      `SELECT a.id, a.pengguna_id, a.nis, a.golongan, a.tingkat_saat_ini, a.regu_pasukan,
              pg.nama, pg.email, pg.role, pg.status
       FROM anggota a
       JOIN pengguna pg ON pg.id = a.pengguna_id
       WHERE pg.gudep_id = ? AND (a.updated_at > ? OR pg.updated_at > ?)`,
      [auth.gudepId, since, since],
    );

    return corsJson({ serverTime, skuProgress, skuEvents, pelantikan, anggota });
  });
}

export const OPTIONS = handleOptions;
