# Rimba (sakuku) — Platform Digital SKU/SKK Pramuka

Flutter/Dart implementation of the offline-first SKU/SKK platform described
in `PRD.md` — one codebase targeting **Web, Android, and iOS**.

## Scope implemented (v1 / MVP, per PRD §13 Fase 1)

- Golongan **Penggalang** (Ramu/Rakit/Terap) — checklist SKU, ajukan uji,
  pengesahan/penolakan oleh pembina, append-only event log (P0-1 … P0-4).
- Modul Materi Teori terhubung ke poin SKU, dibaca sepenuhnya offline
  (P0-5).
- Admin Gudep: kelola anggota/golongan (P0-6).
- Sinkronisasi: local-first read/write dengan outbox (`sync_queue`) dan
  indikator status online/pending/offline (P0-7 — lihat catatan di
  `lib/core/sync/sync_service.dart`, backend REST belum ada).
- Portofolio riwayat pelantikan TKU (P0-8).
- Role-based routing dalam satu app (peserta_didik / pembina & pelatih_skk
  / admin_gudep), sesuai rekomendasi PRD §14.

Not yet implemented (out of v1 scope per PRD): SKK end-to-end, real backend
sync endpoint, push notifications, export laporan, golongan lain (Siaga/
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
  first run — see the file for demo credentials.

## Running

```sh
flutter pub get
flutter run -d chrome   # or -d <android-device-id> / an iOS simulator
```

Demo logins (seeded locally, no backend required):

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
