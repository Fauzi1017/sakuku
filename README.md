# Rimba (sakuku) — Platform Digital SKU/SKK Pramuka

Flutter/Dart implementation of the offline-first SKU/SKK platform described
in `PRD.md` — one codebase targeting **Web, Android, and iOS**.

## Scope implemented (v1 / MVP, per PRD §13 Fase 1)

- Golongan **Penggalang** (Ramu/Rakit/Terap) — checklist SKU, ajukan uji,
  pengesahan/penolakan oleh pembina, append-only event log (P0-1 … P0-4).
- Modul Materi Teori terhubung ke poin SKU, dibaca sepenuhnya offline
  (P0-5).
- Admin Gudep: kelola anggota/golongan (P0-6).
- Sinkronisasi: local-first read/write dengan outbox (`sync_queue`),
  push+pull terhadap backend nyata (`api/`), dan indikator status
  online/pending/offline (P0-7).
- Portofolio riwayat pelantikan TKU (P0-8).
- Role-based routing dalam satu app (peserta_didik / pembina & pelatih_skk
  / admin_gudep), sesuai rekomendasi PRD §14.
- Backend REST (`api/`, Next.js) + skema MySQL (`api/sql/schema.sql`),
  dengan panduan deploy ke VPS (`deploy/vps_setup.sh`) dan Flutter web ke
  Vercel (`vercel.json` / `vercel-build.sh`) — lihat "Deploying" di bawah.

Not yet implemented (out of v1 scope per PRD): SKK end-to-end (data model
exists, no UI), push notifications, export laporan, golongan lain (Siaga/
Penegak/Pandega).

## Architecture

- **State management:** Riverpod.
- **Routing:** go_router, redirect-based role routing.
- **Local-first database:** Drift, opened via `drift_flutter`'s
  `driftDatabase()` — native SQLite on Android/iOS/desktop, sqlite3 wasm on
  Web (see `web/sqlite3.wasm` and `web/drift_worker.js`). Schema in
  `lib/data/local/tables/` mirrors `schema.sql`; primary keys are
  client-generated UUIDs rather than `AUTO_INCREMENT` so records can be
  created fully offline (see the doc comment on `AppDatabase`).
- **Append-only event log:** `sku_event`/`skk_event` are never overwritten;
  `sku_progress.status`/`skk_progress.status` are derived and only ever
  written by `SkuDao.appendEvent` (PRD §6.3).
- **Design tokens:** `lib/core/theme/` is a 1:1 port of
  `designtokens.css` / `tailwind.tokens.js`.
- **Demo data:** `lib/data/seed/seed_data.dart` seeds one gudep, demo
  accounts per role, sample Penggalang SKU items, and sample materi on
  first run — see the file for demo credentials. `api/scripts/seed.ts`
  seeds the same data server-side (kept in sync by hand).
- **Backend:** `api/` — Next.js API routes + MySQL (`mysql2`), JWT auth.
  Self-hosted on a VPS (PM2 + Nginx + Let's Encrypt), not on Vercel — see
  "Why the API isn't on Vercel" below. Local-first stays true even with a
  backend: every write lands in `sku_event`/`sync_queue` locally first
  (`SkuDao.appendEvent`), and `SyncService` pushes/pulls against the API
  only when online and logged in (`lib/core/sync/sync_service.dart`).

## Running

```sh
flutter pub get
flutter run -d chrome   # or -d <android-device-id> / an iOS simulator
```

Without `--dart-define=API_BASE_URL=...`, the app runs as a pure local-only
offline demo (no backend calls at all — see
`lib/core/network/api_config.dart`). Demo logins (seeded locally):

| Role | Email | Password |
|---|---|---|
| Peserta Didik | `peserta@sakuku.test` | `peserta123` |
| Pembina | `pembina@sakuku.test` | `pembina123` |
| Pelatih SKK | `pelatih@sakuku.test` | `pelatih123` |
| Admin Gudep | `admin@sakuku.test` | `admin123` |

## Regenerating Drift code

After changing anything in `lib/data/local/tables/` or `daos/`:

```sh
dart run build_runner build --delete-conflicting-outputs
```

## Deploying

Two independent deployables:

1. **API + MySQL, self-hosted on your VPS.** `deploy/vps_setup.sh`
   provisions everything on a fresh Ubuntu VPS: ufw firewall, MySQL
   (localhost-only), Node.js + PM2, the Next.js API from `api/`, Nginx
   reverse proxy, and Let's Encrypt SSL. As root on the VPS:

   ```sh
   git clone https://github.com/Fauzi1017/sakuku.git /opt/sakuku
   cd /opt/sakuku
   DOMAIN=api.yourdomain.com LETSENCRYPT_EMAIL=you@example.com \
     ./deploy/vps_setup.sh
   ```

   `DOMAIN` needs a DNS A record pointing at the VPS *before* you run
   this (Certbot verifies it). Run once without `DOMAIN` first if you
   just want to smoke-test over plain HTTP — but the Vercel-hosted web
   build below **cannot** call a plain-HTTP API (browsers block
   mixed content from an HTTPS page), so a real domain is required for
   an end-to-end deployment. The script prints generated secrets and the
   API URL at the end; re-running it is safe (idempotent) and reuses the
   same secrets.

   **Why the API isn't on Vercel:** Vercel serverless functions have no
   fixed IP, so MySQL couldn't be locked down to specific callers — it'd
   have to accept connections from anywhere on the internet. Running the
   API on the same VPS as MySQL means the database never leaves
   `localhost` (see `api/lib/db.ts`).

2. **Flutter web build, on Vercel.** In the Vercel dashboard, "Add New
   Project" → import this repo → in Project Settings, set the
   **Environment Variable** `API_BASE_URL` to your VPS API's URL (e.g.
   `https://api.yourdomain.com`). `vercel.json` at the repo root already
   points Vercel at `vercel-build.sh`, which installs the Flutter SDK
   during the build and runs `flutter build web`, publishing
   `build/web`. Then deploy.

   Once you have the Vercel URL, go back and re-run `vps_setup.sh` with
   `CORS_ORIGIN=https://your-app.vercel.app` so the API only accepts
   browser calls from your deployed frontend (it defaults to `*`, open
   to any origin, until this is set).
