import { NextRequest } from "next/server";
import { RowDataPacket } from "mysql2";
import { getPool } from "@/lib/db";
import { requireAuth } from "@/lib/auth";
import { corsJson, handleOptions } from "@/lib/cors";
import { withErrorHandling } from "@/lib/http";

export async function GET(request: NextRequest) {
  return withErrorHandling(async () => {
    const auth = requireAuth(request);
    const pool = getPool();

    const [rows] = await pool.query<RowDataPacket[]>(
      "SELECT id, gudep_id, nama, email, no_hp, role, status FROM pengguna WHERE id = ? LIMIT 1",
      [auth.sub],
    );
    const pengguna = rows[0];
    if (!pengguna) {
      return corsJson({ error: "Pengguna tidak ditemukan." }, { status: 404 });
    }

    const [anggotaRows] = await pool.query<RowDataPacket[]>(
      "SELECT id, pengguna_id, nis, golongan, tingkat_saat_ini, regu_pasukan FROM anggota WHERE pengguna_id = ? LIMIT 1",
      [auth.sub],
    );

    return corsJson({ pengguna, anggota: anggotaRows[0] ?? null });
  });
}

export const OPTIONS = handleOptions;
