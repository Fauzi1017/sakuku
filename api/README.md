# Rimba API

Backend for the SKU/SKK Pramuka platform (`../lib`, the Flutter app). Next.js
App Router, used purely for its API routes — self-hosted on the VPS via PM2
(see `../deploy/vps_setup.sh`), **not** deployed to Vercel. The reasoning is
in the root `README.md`.

## Endpoints

| Route | Auth | Notes |
|---|---|---|
| `GET /api/health` | none | pings MySQL |
| `POST /api/auth/login` | none | `{email, password}` → `{token, pengguna, anggota}` |
| `GET /api/auth/me` | Bearer | current session |
| `POST /api/sync/push` | Bearer | drains the Flutter client's local outbox |
| `GET /api/sync/pull?since=` | Bearer | changes since an ISO cursor |
| `GET /api/materi/bundle` | Bearer | full materi tree for offline caching |
| `GET /api/anggota` | Bearer (admin/pembina/pelatih) | roster |
| `POST /api/anggota` | Bearer (admin) | create anggota |

## Local development

```sh
cp .env.example .env   # point at a local MySQL instance
mysql -u root your_db < sql/schema.sql
npm install
npm run seed            # demo accounts, matches lib/data/seed/seed_data.dart
npm run dev
```

## Data model

`sql/schema.sql` mirrors the PRD's `schema.sql`, with one deliberate
change: every primary/foreign key is `VARCHAR(64)` instead of
`BIGINT AUTO_INCREMENT`. The Flutter client is local-first and creates
records (sku_event, pelantikan, ...) fully offline with client-generated
UUIDs (see `lib/data/local/database.dart` in the Flutter app) — matching
that id scheme here means a sync push never needs a client↔server id
remapping step.

## Production build

```sh
npm run build
# next.config.ts sets output: "standalone" — copy static assets in manually:
cp -r public .next/standalone/public
cp -r .next/static .next/standalone/.next/static
pm2 start ecosystem.config.js
```

`deploy/vps_setup.sh` does all of this automatically.
