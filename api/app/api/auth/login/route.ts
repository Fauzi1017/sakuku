import { NextRequest } from "next/server";
import { z } from "zod";
import { RowDataPacket } from "mysql2";
import { getPool } from "@/lib/db";
import { signToken, verifyPassword } from "@/lib/auth";
import { corsJson, handleOptions } from "@/lib/cors";
import { withErrorHandling } from "@/lib/http";

const bodySchema = z.object({
  email: z.string().email(),
  password: z.string().min(1),
});

interface PenggunaRow extends RowDataPacket {
  id: string;
  gudep_id: string;
  nama: string;
  email: string | null;
  no_hp: string | null;
  password_hash: string;
  role: string;
  status: string;
}

interface AnggotaRow extends RowDataPacket {
  id: string;
  pengguna_id: string;
  nis: string | null;
  golongan: string;
  tingkat_saat_ini: string | null;
  regu_pasukan: string | null;
}

/**
 * PRD §6.2: "login awal wajib online sekali" — this is that one required
 * online round-trip. The Flutter client falls back to comparing against
 * the last-synced local credentials whenever this endpoint is unreachable
 * (see AuthController.login in the Flutter app).
 */
export async function POST(request: NextRequest) {
  return withErrorHandling(async () => {
    const body = bodySchema.parse(await request.json());
    const pool = getPool();

    const [rows] = await pool.query<PenggunaRow[]>(
      "SELECT * FROM pengguna WHERE email = ? LIMIT 1",
      [body.email],
    );
    const pengguna = rows[0];
    if (!pengguna || pengguna.status !== "aktif") {
      return corsJson({ error: "Email atau kata sandi salah." }, { status: 401 });
    }

    const valid = await verifyPassword(body.password, pengguna.password_hash);
    if (!valid) {
      return corsJson({ error: "Email atau kata sandi salah." }, { status: 401 });
    }

    let anggota: AnggotaRow | null = null;
    if (pengguna.role === "peserta_didik") {
      const [anggotaRows] = await pool.query<AnggotaRow[]>(
        "SELECT * FROM anggota WHERE pengguna_id = ? LIMIT 1",
        [pengguna.id],
      );
      anggota = anggotaRows[0] ?? null;
    }

    const token = signToken({
      sub: pengguna.id,
      gudepId: pengguna.gudep_id,
      role: pengguna.role as never,
    });

    return corsJson({
      token,
      pengguna: {
        id: pengguna.id,
        gudep_id: pengguna.gudep_id,
        nama: pengguna.nama,
        email: pengguna.email,
        no_hp: pengguna.no_hp,
        role: pengguna.role,
        status: pengguna.status,
      },
      anggota: anggota && {
        id: anggota.id,
        pengguna_id: anggota.pengguna_id,
        nis: anggota.nis,
        golongan: anggota.golongan,
        tingkat_saat_ini: anggota.tingkat_saat_ini,
        regu_pasukan: anggota.regu_pasukan,
      },
    });
  });
}

export const OPTIONS = handleOptions;
