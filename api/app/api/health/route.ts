import { getPool } from "@/lib/db";
import { corsJson, handleOptions } from "@/lib/cors";

export async function GET() {
  try {
    await getPool().query("SELECT 1");
    return corsJson({ status: "ok", db: "ok" });
  } catch (err) {
    console.error(err);
    return corsJson({ status: "degraded", db: "error" }, { status: 503 });
  }
}

export const OPTIONS = handleOptions;
