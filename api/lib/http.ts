import { NextResponse } from "next/server";
import { ZodError } from "zod";
import { UnauthorizedError } from "./auth";
import { corsJson } from "./cors";

export function jsonError(message: string, status: number) {
  return corsJson({ error: message }, { status });
}

/**
 * Wraps a route handler body so every route gets consistent error
 * responses (401 for auth failures, 400 for validation errors, 500 with a
 * generic message for anything unexpected — no internal error details
 * leak to clients).
 */
export function withErrorHandling(
  fn: () => Promise<NextResponse>,
): Promise<NextResponse> {
  return fn().catch((err) => {
    if (err instanceof UnauthorizedError) {
      return jsonError(err.message, 401);
    }
    if (err instanceof ZodError) {
      return jsonError(
        `Validation error: ${err.issues.map((i) => `${i.path.join(".")}: ${i.message}`).join(", ")}`,
        400,
      );
    }
    console.error(err);
    return jsonError("Internal server error", 500);
  });
}
