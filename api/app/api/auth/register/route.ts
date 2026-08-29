import { NextRequest } from "next/server";
import { RowDataPacket } from "mysql2";
import { v4 as uuidv4 } from "uuid";
import { z } from "zod";
import { getPool } from "@/lib/db";
import { hashPassword, signToken } from "@/lib/auth";
import { corsJson, handleOptions } from "@/lib/cors";
import { withErrorHandling } from "@/lib/http";

const bodySchema = z.object({
  nama: z.string().min(1),
  email: z.string().email(),
  password: z.string().min(6),
  nis: z.string().optional(),
  golongan: z.enum(["siaga", "penggalang", "penegak", "pandega"]),
  tingkatSaatIni: z.string().min(1),
  reguPasukan: z.string().optional(),
});

/**
 * Public self-registration for peserta_didik. v1 is single-gudep (PRD §3),
 * so there is no gudep picker — new accounts join the one gudep this API
 * instance serves. Returns the same shape as /api/auth/login so the
 * Flutter client can treat a successful registration as an immediate
 * logged-in session (see RegisterController in the Flutter app).
 */
export async function POST(request: NextRequest) {
  return withErrorHandling(async () => {
    const body = bodySchema.parse(await request.json());
    const pool = getPool();

    const [gudepRows] = await pool.query<RowDataPacket[]>(
      "SELECT id FROM gudep ORDER BY created_at LIMIT 1",
    );
    const gudepId = gudepRows[0]?.id as string | undefined;
    if (!gudepId) {
      return corsJson(
        { error: "Belum ada gudep terdaftar di server ini." },
        { status: 500 },
      );
    }

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
        [penggunaId, gudepId, body.nama, body.email, passwordHash],
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

    const token = signToken({ sub: penggunaId, gudepId, role: "peserta_didik" });

    return corsJson(
      {
        token,
        pengguna: {
          id: penggunaId,
          gudep_id: gudepId,
          nama: body.nama,
          email: body.email,
          no_hp: null,
          role: "peserta_didik",
          status: "aktif",
        },
        anggota: {
          id: anggotaId,
          pengguna_id: penggunaId,
          nis: body.nis ?? null,
          golongan: body.golongan,
          tingkat_saat_ini: body.tingkatSaatIni,
          regu_pasukan: body.reguPasukan ?? null,
        },
      },
      { status: 201 },
    );
  });
}

export const OPTIONS = handleOptions;
