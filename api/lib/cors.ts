import { NextResponse } from "next/server";

/**
 * The Flutter web build is deployed separately on Vercel (see
 * "Deploying" in the repo root README.md) and calls this API
 * cross-origin, so every response needs CORS headers. Restrict to the
 * configured origin rather than "*" since requests carry a bearer token.
 */
function corsHeaders(): HeadersInit {
  const origin = process.env.CORS_ORIGIN ?? "*";
  return {
    "Access-Control-Allow-Origin": origin,
    "Access-Control-Allow-Methods": "GET, POST, PUT, DELETE, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Max-Age": "86400",
  };
}

export function corsJson(
  data: unknown,
  init?: { status?: number },
): NextResponse {
  return NextResponse.json(data, {
    status: init?.status ?? 200,
    headers: corsHeaders(),
  });
}

export function handleOptions(): NextResponse {
  return new NextResponse(null, { status: 204, headers: corsHeaders() });
}
