// PM2 process definition for the self-hosted Next.js API (see
// ../deploy/vps_setup.sh, which writes /opt/sakuku/api/.env next to this
// file). Runs the `output: standalone` server bundle directly — `next
// start` does not support standalone builds (next.config.ts).
//
// DB_*/JWT_SECRET/CORS_ORIGIN are loaded from .env here (at PM2
// config-parse time) and injected directly via PM2's `env`, rather than
// relying on the standalone server.js's own dotenv loading — its cwd at
// runtime depends on how it's invoked, so this is the reliable path.
const path = require("node:path");
require("dotenv").config({ path: path.join(__dirname, ".env") });

module.exports = {
  apps: [
    {
      name: "sakuku-api",
      cwd: __dirname,
      script: ".next/standalone/server.js",
      env: {
        ...process.env,
        NODE_ENV: "production",
        HOSTNAME: "127.0.0.1", // bind loopback only — Nginx proxies from 443
        PORT: "3001",
      },
      instances: 1,
      autorestart: true,
      max_restarts: 10,
      restart_delay: 2000,
    },
  ],
};
