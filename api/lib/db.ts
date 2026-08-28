import mysql from "mysql2/promise";

/**
 * Single shared connection pool for the whole process — the VPS deployment
 * runs this app as one long-lived Node process under PM2, so a module-level
 * pool is safe (unlike Vercel's serverless functions, where a fresh pool
 * per invocation would exhaust MySQL's connection limit; this app is
 * intentionally self-hosted on the VPS for that reason — see README.md).
 */
declare global {
  var __sakukuPool: mysql.Pool | undefined;
}

function createPool(): mysql.Pool {
  const {
    DB_HOST = "127.0.0.1",
    DB_PORT = "3306",
    DB_USER,
    DB_PASSWORD,
    DB_NAME,
  } = process.env;

  if (!DB_USER || !DB_PASSWORD || !DB_NAME) {
    throw new Error(
      "Missing DB_USER / DB_PASSWORD / DB_NAME environment variables. Copy .env.example to .env and fill them in.",
    );
  }

  return mysql.createPool({
    host: DB_HOST,
    port: Number(DB_PORT),
    user: DB_USER,
    password: DB_PASSWORD,
    database: DB_NAME,
    waitForConnections: true,
    connectionLimit: 10,
    dateStrings: true,
  });
}

export function getPool(): mysql.Pool {
  if (!global.__sakukuPool) {
    global.__sakukuPool = createPool();
  }
  return global.__sakukuPool;
}
