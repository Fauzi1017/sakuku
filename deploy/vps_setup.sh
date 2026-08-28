#!/usr/bin/env bash
# ============================================================
# Rimba — VPS provisioning script
# Target: fresh Ubuntu VPS (tested against Ubuntu 22.04/24.04).
#
# Installs & configures, end to end:
#   - ufw firewall (22, 80, 443 only — MySQL stays localhost-only)
#   - MySQL 8 server + a dedicated least-privilege app user
#   - Node.js LTS + PM2
#   - the Next.js API from this repo (self-hosted, NOT on Vercel —
#     see README.md for why), reverse-proxied by Nginx
#   - Let's Encrypt SSL via certbot (only if DOMAIN is set — Vercel's
#     HTTPS-hosted Flutter web build cannot call a plain-HTTP API due to
#     mixed-content blocking, so a domain pointed at this VPS is required
#     for the deployment to actually work end to end)
#
# Usage:
#   1. Point a DNS A record at this VPS's IP (e.g. api.yourdomain.com),
#      or run once without DOMAIN to smoke-test over HTTP first.
#   2. As root on the VPS:
#        curl -fsSL <raw-url-to-this-script> -o vps_setup.sh
#        chmod +x vps_setup.sh
#        DOMAIN=api.yourdomain.com LETSENCRYPT_EMAIL=you@example.com ./vps_setup.sh
#      (or clone the repo and run it from deploy/vps_setup.sh directly)
#   3. Re-running is safe — every step is guarded to skip work already
#      done (except `npm run seed`, which is itself idempotent).
#
# All secrets not supplied via environment variables are generated
# randomly and printed once at the end — save them immediately.
# ============================================================
set -euo pipefail

# ---------- Configuration (override via environment variables) ----------
DOMAIN="${DOMAIN:-}"
LETSENCRYPT_EMAIL="${LETSENCRYPT_EMAIL:-}"
REPO_URL="${REPO_URL:-https://github.com/Fauzi1017/sakuku.git}"
BRANCH="${BRANCH:-claude/flutter-dart-multiplatform-jtnun4}"
APP_DIR="${APP_DIR:-/opt/sakuku}"
DB_NAME="${DB_NAME:-sakuku}"
DB_APP_USER="${DB_APP_USER:-sakuku_app}"
CORS_ORIGIN="${CORS_ORIGIN:-*}"
APP_PORT="${APP_PORT:-3001}"

# On a re-run, reuse the secrets from the previous run's .env instead of
# generating new ones — otherwise every re-run would invalidate existing
# JWTs and change the MySQL app password out from under anything that
# still has the old one cached.
EXISTING_ENV="$APP_DIR/api/.env"
if [[ -z "${DB_APP_PASSWORD:-}" && -f "$EXISTING_ENV" ]]; then
  DB_APP_PASSWORD="$(grep -m1 '^DB_PASSWORD=' "$EXISTING_ENV" | cut -d= -f2-)"
fi
if [[ -z "${JWT_SECRET:-}" && -f "$EXISTING_ENV" ]]; then
  JWT_SECRET="$(grep -m1 '^JWT_SECRET=' "$EXISTING_ENV" | cut -d= -f2-)"
fi
DB_APP_PASSWORD="${DB_APP_PASSWORD:-$(openssl rand -base64 24 | tr -d '=+/')}"
JWT_SECRET="${JWT_SECRET:-$(openssl rand -base64 48 | tr -d '\n')}"

if [[ $EUID -ne 0 ]]; then
  echo "Run this script as root (sudo -i, then run it)." >&2
  exit 1
fi

log() { echo -e "\n\033[1;32m==> $*\033[0m"; }

# ---------- 1. System update ----------
log "Updating system packages"
export DEBIAN_FRONTEND=noninteractive
apt-get update -y
apt-get upgrade -y

# ---------- 2. Firewall ----------
log "Configuring ufw firewall (22, 80, 443)"
apt-get install -y ufw
ufw allow OpenSSH
ufw allow 80/tcp
ufw allow 443/tcp
ufw --force enable
# MySQL (3306) is intentionally NOT opened — it stays reachable only from
# localhost, since the API runs on this same VPS (see README.md for the
# reasoning behind not exposing MySQL to Vercel's serverless functions).

# ---------- 3. MySQL ----------
log "Installing MySQL server"
if ! command -v mysql >/dev/null; then
  apt-get install -y mysql-server
fi
systemctl enable --now mysql

log "Creating database and app user (idempotent)"
mysql -u root <<SQL
CREATE DATABASE IF NOT EXISTS ${DB_NAME} CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER IF NOT EXISTS '${DB_APP_USER}'@'localhost' IDENTIFIED BY '${DB_APP_PASSWORD}';
ALTER USER '${DB_APP_USER}'@'localhost' IDENTIFIED BY '${DB_APP_PASSWORD}';
GRANT SELECT, INSERT, UPDATE, DELETE ON ${DB_NAME}.* TO '${DB_APP_USER}'@'localhost';
FLUSH PRIVILEGES;
SQL

# ---------- 4. Clone/update the app repo ----------
log "Fetching application code ($REPO_URL @ $BRANCH)"
if [[ -d "$APP_DIR/.git" ]]; then
  git -C "$APP_DIR" fetch origin "$BRANCH"
  git -C "$APP_DIR" checkout "$BRANCH"
  git -C "$APP_DIR" reset --hard "origin/$BRANCH"
else
  mkdir -p "$APP_DIR"
  git clone --branch "$BRANCH" "$REPO_URL" "$APP_DIR"
fi

# ---------- 5. Import schema (only if tables don't exist yet) ----------
log "Importing MySQL schema (skipped if already applied)"
TABLE_COUNT=$(mysql -u root -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema='${DB_NAME}';")
if [[ "$TABLE_COUNT" -eq 0 ]]; then
  mysql -u root "$DB_NAME" < "$APP_DIR/api/sql/schema.sql"
  echo "Schema imported."
else
  echo "Schema already present ($TABLE_COUNT tables) — skipping import."
fi

# ---------- 6. Node.js + PM2 ----------
log "Installing Node.js LTS"
if ! command -v node >/dev/null || [[ "$(node -v | cut -d. -f1 | tr -d v)" -lt 20 ]]; then
  curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
  apt-get install -y nodejs
fi

log "Installing PM2"
if ! command -v pm2 >/dev/null; then
  npm install -g pm2
fi

# ---------- 7. Configure and build the API ----------
log "Writing api/.env"
cat > "$APP_DIR/api/.env" <<ENV
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=${DB_APP_USER}
DB_PASSWORD=${DB_APP_PASSWORD}
DB_NAME=${DB_NAME}
JWT_SECRET=${JWT_SECRET}
CORS_ORIGIN=${CORS_ORIGIN}
PORT=${APP_PORT}
ENV
chmod 600 "$APP_DIR/api/.env"

log "Installing dependencies and building the API"
cd "$APP_DIR/api"
npm ci
npm run build

# `output: standalone` needs public/ and .next/static/ copied in manually
# (Next.js does not do this automatically — see next.config.ts comment).
rm -rf .next/standalone/public .next/standalone/.next/static
cp -r public .next/standalone/public
cp -r .next/static .next/standalone/.next/static

log "Seeding demo data (skipped if already present)"
npm run seed

# ---------- 8. Start/reload under PM2 ----------
log "Starting the API under PM2"
pm2 startOrReload ecosystem.config.js
pm2 save

# Persist PM2 across reboots — `pm2 startup` prints the exact systemd
# install command rather than running it; extract and run just that line.
STARTUP_CMD="$(pm2 startup systemd -u root --hp /root 2>&1 | grep -m1 '^sudo ' | sed 's/^sudo //')"
if [[ -n "$STARTUP_CMD" ]]; then
  eval "$STARTUP_CMD"
fi

# ---------- 9. Nginx reverse proxy ----------
log "Installing and configuring Nginx"
apt-get install -y nginx

NGINX_SERVER_NAME="${DOMAIN:-_}"
cat > /etc/nginx/sites-available/sakuku-api <<NGINX
server {
    listen 80;
    server_name ${NGINX_SERVER_NAME};

    location / {
        proxy_pass http://127.0.0.1:${APP_PORT};
        proxy_http_version 1.1;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}
NGINX
ln -sf /etc/nginx/sites-available/sakuku-api /etc/nginx/sites-enabled/sakuku-api
rm -f /etc/nginx/sites-enabled/default
nginx -t
systemctl reload nginx

# ---------- 10. SSL (only if a domain was given) ----------
if [[ -n "$DOMAIN" ]]; then
  log "Requesting Let's Encrypt certificate for $DOMAIN"
  apt-get install -y certbot python3-certbot-nginx
  if [[ -n "$LETSENCRYPT_EMAIL" ]]; then
    certbot --nginx -d "$DOMAIN" --non-interactive --agree-tos -m "$LETSENCRYPT_EMAIL" --redirect
  else
    certbot --nginx -d "$DOMAIN" --non-interactive --agree-tos --register-unsafely-without-email --redirect
  fi
  API_URL="https://${DOMAIN}"
else
  API_URL="http://$(curl -s ifconfig.me)"
  echo -e "\n\033[1;33mWARNING: no DOMAIN given — API is only reachable over plain HTTP.\033[0m"
  echo "A Flutter web build hosted on Vercel (HTTPS) CANNOT call an HTTP API"
  echo "(browsers block mixed content). Point a DNS A record at this VPS and"
  echo "re-run with DOMAIN=api.yourdomain.com before deploying the web build."
fi

# ---------- Summary ----------
log "Done."
cat <<SUMMARY

======================================================================
 Rimba API is running.

 API base URL:      ${API_URL}
 Health check:      ${API_URL}/api/health

 MySQL database:    ${DB_NAME}
 MySQL app user:    ${DB_APP_USER}
 MySQL app password:${DB_APP_PASSWORD}
 JWT secret:        ${JWT_SECRET}

 These are saved in ${APP_DIR}/api/.env (mode 600) — this is the only
 place they're stored on disk. Keep a copy somewhere safe now.

 Demo accounts (see api/scripts/seed.ts):
   admin@sakuku.test    / admin123
   pembina@sakuku.test  / pembina123
   pelatih@sakuku.test  / pelatih123
   peserta@sakuku.test  / peserta123

 Next steps:
   1. Deploy the Flutter web build to Vercel (see README.md "Deploying"),
      setting API_BASE_URL=${API_URL} as a build-time dart-define.
   2. Once you know the Vercel URL, re-run this script with
      CORS_ORIGIN=https://your-app.vercel.app so the API only accepts
      browser requests from your deployed frontend.
   3. pm2 logs sakuku-api   — tail the API logs
   4. pm2 restart sakuku-api — after a manual `git pull` + rebuild
======================================================================
SUMMARY
