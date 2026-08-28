import { NextRequest } from "next/server";
import { RowDataPacket } from "mysql2";
import { v4 as uuidv4 } from "uuid";
import { z } from "zod";
import { getPool } from "@/lib/db";
import { hashPassword, requireAuth, requireRole } from "@/lib/auth";
import { corsJson, handleOptions } from "@/lib/cors";
import { withErrorHandling } from "@/lib/http";

export async function GET(request: NextRequest) {
  return withErrorHandling(async () => {
    const auth = requireAuth(request);
    requireRole(auth, ["admin_gudep", "pembina", "pelatih_skk"]);

    const [rows] = await getPool().query<RowDataPacket[]>(
      `SELECT a.id, a.pengguna_id, a.nis, a.golongan, a.tingkat_saat_ini, a.regu_pasukan,
              pg.nama, pg.email, pg.status
       FROM anggota a
       JOIN pengguna pg ON pg.id = a.pengguna_id
       WHERE pg.gudep_id = ?
       ORDER BY pg.nama`,
      [auth.gudepId],
    );

    return corsJson({ anggota: rows });
  });
}

const createSchema = z.object({
  nama: z.string().min(1),
  email: z.string().email(),
  password: z.string().min(6),
  nis: z.string().optional(),
  golongan: z.enum(["siaga", "penggalang", "penegak", "pandega"]),
  tingkatSaatIni: z.string().min(1),
  reguPasukan: z.string().optional(),
});

/** Admin Gudep P0-6: CRUD anggota, tervalidasi email/nomor unik. */
export async function POST(request: NextRequest) {
  return withErrorHandling(async () => {
    const auth = requireAuth(request);
    requireRole(auth, ["admin_gudep"]);
    const body = createSchema.parse(await request.json());

    const pool = getPool();
    const [existing] = await pool.query<RowDataPacket[]>(
      "SELECT id FROM pengguna WHERE email = ? LIMIT 1",
      [body.email],
    );
    if (existing.length > 0) {
      return corsJson({ error: "Email sudah terdaftar." }, { status: 409 });
    }

    const penggunaId = uuidv4();
    const anggotaId = uuidv4();
    const passwordHash = await hashPassword(body.password);

    const conn = await pool.getConnection();
    try {
      await conn.beginTransaction();
      await conn.query(
        "INSERT INTO pengguna (id, gudep_id, nama, email, password_hash, role, status) VALUES (?, ?, ?, ?, ?, 'peserta_didik', 'aktif')",
        [penggunaId, auth.gudepId, body.nama, body.email, passwordHash],
      );
      await conn.query(
        "INSERT INTO anggota (id, pengguna_id, nis, golongan, tingkat_saat_ini, regu_pasukan) VALUES (?, ?, ?, ?, ?, ?)",
        [anggotaId, penggunaId, body.nis ?? null, body.golongan, body.tingkatSaatIni, body.reguPasukan ?? null],
      );
      await conn.commit();
    } catch (err) {
      await conn.rollback();
      throw err;
    } finally {
      conn.release();
    }

    return corsJson(
      {
        id: anggotaId,
        pengguna_id: penggunaId,
        nama: body.nama,
        email: body.email,
        golongan: body.golongan,
        tingkat_saat_ini: body.tingkatSaatIni,
      },
      { status: 201 },
    );
  });
}

export const OPTIONS = handleOptions;
