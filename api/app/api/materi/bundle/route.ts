import { NextRequest } from "next/server";
import { RowDataPacket } from "mysql2";
import { getPool } from "@/lib/db";
import { requireAuth } from "@/lib/auth";
import { corsJson, handleOptions } from "@/lib/cors";
import { withErrorHandling } from "@/lib/http";

/**
 * Full materi content tree, fetched once and cached locally so it reads
 * fully offline afterwards (PRD §7.2 "mode baca offline penuh", P0-5).
 * `versi` on each unit lets the client know when a re-download is needed
 * (PRD §7.2 "Versioning konten") — the client just re-pulls the whole
 * bundle when it wants a refresh; the payload is small enough (text +
 * relations only, no binary media) that incremental sync isn't worth the
 * complexity for v1.
 */
export async function GET(request: NextRequest) {
  return withErrorHandling(async () => {
    requireAuth(request);
    const pool = getPool();

    const [kategori] = await pool.query<RowDataPacket[]>(
      "SELECT id, nama, urutan, ikon FROM materi_kategori ORDER BY urutan",
    );
    const [topik] = await pool.query<RowDataPacket[]>(
      "SELECT id, kategori_id, nama, urutan FROM materi_topik ORDER BY urutan",
    );
    const [unit] = await pool.query<RowDataPacket[]>(
      "SELECT id, topik_id, judul, konten_markdown, media_urls, versi, urutan FROM materi_unit ORDER BY urutan",
    );
    const [relasi] = await pool.query<RowDataPacket[]>(
      "SELECT id, materi_unit_id, sku_item_id, skk_item_id FROM materi_relasi",
    );
    const [skuItem] = await pool.query<RowDataPacket[]>(
      "SELECT id, golongan, tingkat, nomor_urut, deskripsi, kategori, aktif FROM sku_item WHERE aktif = TRUE ORDER BY golongan, tingkat, nomor_urut",
    );

    return corsJson({ kategori, topik, unit, relasi, skuItem });
  });
}

export const OPTIONS = handleOptions;
