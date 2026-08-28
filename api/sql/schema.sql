-- ============================================================
-- Skema MySQL — Platform SKU/SKK Pramuka (Offline-First)
-- Versi: 1.1 (server-side, disesuaikan dari schema.sql PRD)
--
-- Perbedaan dari schema.sql asli: seluruh primary/foreign key memakai
-- VARCHAR(64) (bukan BIGINT AUTO_INCREMENT). Alasan: client Flutter
-- adalah local-first dan membuat baris baru (sku_event, pelantikan, dst)
-- sepenuhnya offline dengan id UUID yang di-generate di device (lihat
-- lib/data/local/database.dart di app Flutter). Memakai skema id yang
-- sama persis di server menghindari lapisan remapping id klien->server
-- saat sync — apa yang dibuat offline langsung jadi baris final di sini.
-- ============================================================

SET NAMES utf8mb4;

-- ------------------------------------------------------------
-- ORGANISASI
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS gudep (
  id            VARCHAR(64) PRIMARY KEY,
  nama          VARCHAR(150) NOT NULL,
  alamat        VARCHAR(255),
  kwarcab       VARCHAR(150),
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- PENGGUNA
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pengguna (
  id            VARCHAR(64) PRIMARY KEY,
  gudep_id      VARCHAR(64) NOT NULL,
  nama          VARCHAR(150) NOT NULL,
  email         VARCHAR(150) UNIQUE,
  no_hp         VARCHAR(30),
  password_hash VARCHAR(255) NOT NULL,
  role          ENUM('peserta_didik','pembina','pelatih_skk','admin_gudep','kwartir') NOT NULL,
  status        ENUM('aktif','nonaktif') DEFAULT 'aktif',
  created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (gudep_id) REFERENCES gudep(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS anggota (
  id                VARCHAR(64) PRIMARY KEY,
  pengguna_id       VARCHAR(64) NOT NULL UNIQUE,
  nis               VARCHAR(50) UNIQUE,
  golongan          ENUM('siaga','penggalang','penegak','pandega') NOT NULL,
  tingkat_saat_ini  VARCHAR(30),
  tanggal_lahir     DATE,
  nama_wali         VARCHAR(150),
  kontak_wali       VARCHAR(50),
  regu_pasukan      VARCHAR(100),
  created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (pengguna_id) REFERENCES pengguna(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS pembina_profil (
  id                VARCHAR(64) PRIMARY KEY,
  pengguna_id       VARCHAR(64) NOT NULL UNIQUE,
  bidang_keahlian   VARCHAR(150),
  keterangan        TEXT,
  FOREIGN KEY (pengguna_id) REFERENCES pengguna(id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- SKU (Syarat Kecakapan Umum)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS sku_item (
  id            VARCHAR(64) PRIMARY KEY,
  golongan      ENUM('siaga','penggalang','penegak','pandega') NOT NULL,
  tingkat       VARCHAR(30) NOT NULL,
  nomor_urut    INT NOT NULL,
  deskripsi     TEXT NOT NULL,
  kategori      VARCHAR(100),
  aktif         BOOLEAN DEFAULT TRUE,
  UNIQUE KEY uq_sku (golongan, tingkat, nomor_urut)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS sku_progress (
  id            VARCHAR(64) PRIMARY KEY,
  anggota_id    VARCHAR(64) NOT NULL,
  sku_item_id   VARCHAR(64) NOT NULL,
  status        ENUM('belum','diajukan','disahkan','ditolak') DEFAULT 'belum',
  updated_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_progress (anggota_id, sku_item_id),
  FOREIGN KEY (anggota_id) REFERENCES anggota(id),
  FOREIGN KEY (sku_item_id) REFERENCES sku_item(id)
) ENGINE=InnoDB;

-- Event log append-only — sumber kebenaran status, bukan sku_progress.status langsung
CREATE TABLE IF NOT EXISTS sku_event (
  id                VARCHAR(64) PRIMARY KEY,
  sku_progress_id   VARCHAR(64) NOT NULL,
  aktor_id          VARCHAR(64) NOT NULL,
  aksi              ENUM('ajukan','sahkan','tolak','batal') NOT NULL,
  catatan           TEXT,
  device_id         VARCHAR(100),
  created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (sku_progress_id) REFERENCES sku_progress(id),
  FOREIGN KEY (aktor_id) REFERENCES pengguna(id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- SKK (Syarat Kecakapan Khusus)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS skk_bidang (
  id            VARCHAR(64) PRIMARY KEY,
  nama          VARCHAR(150) NOT NULL,
  kelompok      VARCHAR(100),
  level         ENUM('purwa','madya','utama') NOT NULL,
  UNIQUE KEY uq_skk_bidang (nama, level)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS skk_item (
  id              VARCHAR(64) PRIMARY KEY,
  skk_bidang_id   VARCHAR(64) NOT NULL,
  nomor_urut      INT NOT NULL,
  deskripsi_syarat TEXT NOT NULL,
  FOREIGN KEY (skk_bidang_id) REFERENCES skk_bidang(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS skk_progress (
  id              VARCHAR(64) PRIMARY KEY,
  anggota_id      VARCHAR(64) NOT NULL,
  skk_item_id     VARCHAR(64) NOT NULL,
  status          ENUM('belum','diajukan','disahkan','ditolak') DEFAULT 'belum',
  updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_skk_progress (anggota_id, skk_item_id),
  FOREIGN KEY (anggota_id) REFERENCES anggota(id),
  FOREIGN KEY (skk_item_id) REFERENCES skk_item(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS skk_event (
  id                VARCHAR(64) PRIMARY KEY,
  skk_progress_id   VARCHAR(64) NOT NULL,
  aktor_id          VARCHAR(64) NOT NULL,
  aksi              ENUM('ajukan','sahkan','tolak','batal') NOT NULL,
  catatan           TEXT,
  device_id         VARCHAR(100),
  created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (skk_progress_id) REFERENCES skk_progress(id),
  FOREIGN KEY (aktor_id) REFERENCES pengguna(id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- PELANTIKAN
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pelantikan (
  id              VARCHAR(64) PRIMARY KEY,
  anggota_id      VARCHAR(64) NOT NULL,
  jenis           ENUM('TKU','TKK') NOT NULL,
  referensi_label VARCHAR(150) NOT NULL,
  tanggal         DATE NOT NULL,
  pembina_id      VARCHAR(64) NOT NULL,
  catatan         TEXT,
  sertifikat_url  VARCHAR(255),
  created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (anggota_id) REFERENCES anggota(id),
  FOREIGN KEY (pembina_id) REFERENCES pengguna(id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- MATERI TEORI
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS materi_kategori (
  id            VARCHAR(64) PRIMARY KEY,
  nama          VARCHAR(150) NOT NULL,
  urutan        INT DEFAULT 0,
  ikon          VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS materi_topik (
  id              VARCHAR(64) PRIMARY KEY,
  kategori_id     VARCHAR(64) NOT NULL,
  nama            VARCHAR(150) NOT NULL,
  urutan          INT DEFAULT 0,
  FOREIGN KEY (kategori_id) REFERENCES materi_kategori(id)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS materi_unit (
  id                VARCHAR(64) PRIMARY KEY,
  topik_id          VARCHAR(64) NOT NULL,
  judul             VARCHAR(200) NOT NULL,
  konten_markdown   LONGTEXT NOT NULL,
  media_urls        JSON,
  versi             INT DEFAULT 1,
  urutan            INT DEFAULT 0,
  created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (topik_id) REFERENCES materi_topik(id)
) ENGINE=InnoDB;

-- Relasi many-to-many antara materi dan poin SKU/SKK
CREATE TABLE IF NOT EXISTS materi_relasi (
  id              VARCHAR(64) PRIMARY KEY,
  materi_unit_id  VARCHAR(64) NOT NULL,
  sku_item_id     VARCHAR(64) NULL,
  skk_item_id     VARCHAR(64) NULL,
  FOREIGN KEY (materi_unit_id) REFERENCES materi_unit(id),
  FOREIGN KEY (sku_item_id) REFERENCES sku_item(id),
  FOREIGN KEY (skk_item_id) REFERENCES skk_item(id),
  CHECK (sku_item_id IS NOT NULL OR skk_item_id IS NOT NULL)
) ENGINE=InnoDB;

-- Progress baca materi per anggota (opsional, P1)
CREATE TABLE IF NOT EXISTS materi_progress_baca (
  id              VARCHAR(64) PRIMARY KEY,
  anggota_id      VARCHAR(64) NOT NULL,
  materi_unit_id  VARCHAR(64) NOT NULL,
  dibaca_pada     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_baca (anggota_id, materi_unit_id),
  FOREIGN KEY (anggota_id) REFERENCES anggota(id),
  FOREIGN KEY (materi_unit_id) REFERENCES materi_unit(id)
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- SYNC & AUDIT
-- ------------------------------------------------------------
-- Log server-side dari setiap mutasi yang diterima lewat POST /api/sync/push
-- — dipakai untuk audit trail dan sebagai sumber /api/sync/pull (query
-- berdasarkan synced_at > cursor milik device peminta).
CREATE TABLE IF NOT EXISTS sync_log (
  id            BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  device_id     VARCHAR(100) NOT NULL,
  pengguna_id   VARCHAR(64) NOT NULL,
  entity_type   VARCHAR(50) NOT NULL,
  entity_id     VARCHAR(64) NOT NULL,
  aksi          VARCHAR(30) NOT NULL,
  payload_json  JSON,
  synced_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (pengguna_id) REFERENCES pengguna(id)
) ENGINE=InnoDB;

-- Index bantu query dashboard progress (dipakai berat oleh Admin Gudep & Pembina)
CREATE INDEX idx_sku_progress_status ON sku_progress (status);
CREATE INDEX idx_skk_progress_status ON skk_progress (status);
CREATE INDEX idx_sku_event_progress ON sku_event (sku_progress_id, created_at);
CREATE INDEX idx_skk_event_progress ON skk_event (skk_progress_id, created_at);
CREATE INDEX idx_anggota_golongan ON anggota (golongan, tingkat_saat_ini);
CREATE INDEX idx_sync_log_cursor ON sync_log (synced_at, entity_type);
CREATE INDEX idx_pengguna_gudep ON pengguna (gudep_id);
