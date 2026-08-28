import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { NextRequest } from "next/server";

export type RoleType =
  | "peserta_didik"
  | "pembina"
  | "pelatih_skk"
  | "admin_gudep"
  | "kwartir";

export interface JwtPayload {
  sub: string; // pengguna.id
  gudepId: string;
  role: RoleType;
}

function jwtSecret(): string {
  const secret = process.env.JWT_SECRET;
  if (!secret) {
    throw new Error("Missing JWT_SECRET environment variable.");
  }
  return secret;
}

export function hashPassword(plain: string): Promise<string> {
  return bcrypt.hash(plain, 10);
}

export function verifyPassword(
  plain: string,
  hash: string,
): Promise<boolean> {
  return bcrypt.compare(plain, hash);
}

/**
 * PRD §6.2: "Token JWT dengan masa berlaku panjang" — anggota harus tetap
 * bisa membuka app tanpa koneksi selama berhari-hari saat kemah, jadi masa
 * berlaku token dibuat panjang (30 hari) alih-alih short-lived + refresh
 * token terpisah, yang butuh koneksi rutin untuk refresh.
 */
export function signToken(payload: JwtPayload): string {
  return jwt.sign(payload, jwtSecret(), { expiresIn: "30d" });
}

export class UnauthorizedError extends Error {}

export function requireAuth(request: NextRequest): JwtPayload {
  const header = request.headers.get("authorization");
  const token = header?.startsWith("Bearer ") ? header.slice(7) : null;
  if (!token) throw new UnauthorizedError("Missing bearer token");

  try {
    return jwt.verify(token, jwtSecret()) as JwtPayload;
  } catch {
    throw new UnauthorizedError("Invalid or expired token");
  }
}

export function requireRole(
  payload: JwtPayload,
  allowed: RoleType[],
): void {
  if (!allowed.includes(payload.role)) {
    throw new UnauthorizedError(
      `Role '${payload.role}' is not allowed to perform this action`,
    );
  }
}
