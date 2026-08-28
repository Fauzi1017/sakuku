/**
 * Seeds the VPS MySQL database with the same demo data as the Flutter
 * app's local seed (lib/data/seed/seed_data.dart) — one gudep, one demo
 * account per role, sample Penggalang SKU items (Ramu/Rakit/Terap), and
 * sample materi content. Kept in sync by hand since the two run on
 * different stacks (Dart/drift vs. Node/mysql2); if you change one,
 * mirror the change in the other.
 *
 * Usage (on the VPS, after `npm run build`):
 *   npm run seed
 *
 * Safe to re-run: every insert is guarded by an existence check.
 */
import "dotenv/config";
import mysql from "mysql2/promise";
import { randomUUID } from "node:crypto";
import bcrypt from "bcryptjs";

const GUDEP_ID = "seed-gudep-1";

async function main() {
  const pool = mysql.createPool({
    host: process.env.DB_HOST ?? "127.0.0.1",
    port: Number(process.env.DB_PORT ?? 3306),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });

  const [existing] = await pool.query("SELECT id FROM gudep WHERE id = ?", [GUDEP_ID]);
  if ((existing as unknown[]).length > 0) {
    console.log("Seed data already present — skipping.");
    await pool.end();
    return;
  }

  await pool.query(
    "INSERT INTO gudep (id, nama, alamat, kwarcab) VALUES (?, ?, ?, ?)",
    [GUDEP_ID, "Gudep 01.001 Rimba Contoh", "Jl. Kepramukaan No. 1", "Kwarcab Contoh"],
  );

  async function pengguna(nama: string, email: string, password: string, role: string) {
    const id = randomUUID();
    const hash = await bcrypt.hash(password, 10);
    await pool.query(
      "INSERT INTO pengguna (id, gudep_id, nama, email, password_hash, role) VALUES (?, ?, ?, ?, ?, ?)",
      [id, GUDEP_ID, nama, email, hash, role],
    );
    return id;
  }

  const adminId = await pengguna("Admin Gudep", "admin@sakuku.test", "admin123", "admin_gudep");
  console.log("Seeded admin_gudep:", adminId);

  const pembinaId = await pengguna("Kak Pembina", "pembina@sakuku.test", "pembina123", "pembina");
  await pool.query("INSERT INTO pembina_profil (id, pengguna_id) VALUES (?, ?)", [randomUUID(), pembinaId]);

  const pelatihId = await pengguna("Kak Pelatih Renang", "pelatih@sakuku.test", "pelatih123", "pelatih_skk");
  await pool.query(
    "INSERT INTO pembina_profil (id, pengguna_id, bidang_keahlian) VALUES (?, ?, ?)",
    [randomUUID(), pelatihId, "Renang"],
  );

  const pesertaId = await pengguna("Ahmad Fauzi", "peserta@sakuku.test", "peserta123", "peserta_didik");
  const pesertaAnggotaId = randomUUID();
  await pool.query(
    "INSERT INTO anggota (id, pengguna_id, nis, golongan, tingkat_saat_ini, regu_pasukan) VALUES (?, ?, ?, 'penggalang', 'ramu', 'Regu Elang')",
    [pesertaAnggotaId, pesertaId, "P-0001"],
  );

  const peserta2Id = await pengguna("Siti Rahma", "peserta2@sakuku.test", "peserta123", "peserta_didik");
  await pool.query(
    "INSERT INTO anggota (id, pengguna_id, nis, golongan, tingkat_saat_ini, regu_pasukan) VALUES (?, ?, ?, 'penggalang', 'rakit', 'Regu Melati')",
    [randomUUID(), peserta2Id, "P-0002"],
  );

  const skuPenggalang: Record<string, [string, string][]> = {
    ramu: [
      ["spiritual", "Dapat melaksanakan ibadah sesuai agama dan kepercayaannya secara rutin."],
      ["spiritual", "Dapat menyebutkan dan menjelaskan arti Dasa Dharma dan Tri Satya dengan kata-katanya sendiri."],
      ["kenegaraan", "Dapat mengetahui dan menjelaskan tentang lambang negara dan bendera Merah Putih."],
      ["kenegaraan", "Dapat menyanyikan lagu Indonesia Raya dengan sikap yang benar."],
      ["fisik", "Dapat menjalankan salah satu cabang olahraga sesuai bakat dan minatnya."],
      ["fisik", "Tahu tentang kesehatan pribadi dan lingkungan."],
      ["keterampilan", "Dapat baris-berbaris sedikitnya sepuluh macam gerakan dasar PBB."],
      ["keterampilan", "Dapat membuat simpul mati, simpul hidup, dan simpul anyam untuk keperluan sehari-hari."],
      ["keterampilan", "Dapat menggunakan kompas dan tahu arah mata angin."],
      ["keterampilan", "Mengetahui dan dapat memperagakan isyarat semaphore dasar."],
      ["sosial", "Dapat menyampaikan pesan secara lisan."],
      ["sosial", "Setia membayar iuran kepada gugusdepannya, dengan uang yang diusahakannya sendiri."],
    ],
    rakit: [
      ["spiritual", "Dapat menjelaskan riwayat hidup salah satu tokoh agama yang dianutnya."],
      ["spiritual", "Selalu berusaha menjalankan ibadah tepat waktu."],
      ["kenegaraan", "Dapat menjelaskan tentang lembaga-lembaga negara secara sederhana."],
      ["kenegaraan", "Pernah mengikuti kegiatan bakti masyarakat di lingkungannya."],
      ["fisik", "Dapat menjelaskan bahaya narkoba, HIV/AIDS, dan penyakit menular lainnya."],
      ["fisik", "Dapat memberikan pertolongan pertama pada kecelakaan (P3K) ringan."],
      ["keterampilan", "Dapat membuat pioneering sederhana dengan tali dan tongkat."],
      ["keterampilan", "Dapat membaca peta dan menggunakan kompas untuk menentukan arah perjalanan."],
      ["keterampilan", "Dapat memasak untuk regunya di perkemahan."],
      ["keterampilan", "Dapat mengirim dan menerima berita dengan isyarat morse atau semaphore."],
      ["sosial", "Pernah ikut serta dalam kegiatan kepemimpinan regu."],
      ["sosial", "Dapat menabung secara teratur."],
    ],
    terap: [
      ["spiritual", "Dapat memimpin doa/ibadah pada suatu kegiatan pasukan."],
      ["spiritual", "Mengajak dan mendorong temannya menjalankan ibadah."],
      ["kenegaraan", "Pernah ikut serta secara aktif dalam upacara peringatan hari-hari besar nasional."],
      ["kenegaraan", "Dapat menjelaskan sejarah kepramukaan dunia dan Indonesia secara garis besar."],
      ["fisik", "Dapat berenang menempuh jarak sedikitnya 25 meter."],
      ["fisik", "Tahu cara menjaga kebugaran jasmani dan menyusun pola hidup sehat."],
      ["keterampilan", "Dapat memimpin baris-berbaris di dalam regunya."],
      ["keterampilan", "Dapat membuat menara pandang atau pioneering tingkat lanjut."],
      ["keterampilan", "Dapat merencanakan dan memimpin acara api unggun."],
      ["keterampilan", "Dapat menggunakan GPS dasar atau aplikasi peta digital untuk navigasi."],
      ["sosial", "Pernah memimpin regunya dalam suatu kegiatan/tugas tertentu."],
      ["sosial", "Dapat merencanakan dan mengelola anggaran sederhana untuk kegiatan regu."],
    ],
  };

  const skuItemIds: Record<string, string> = {};
  for (const [tingkat, items] of Object.entries(skuPenggalang)) {
    let nomor = 1;
    for (const [kategori, deskripsi] of items) {
      const id = `sku-penggalang-${tingkat}-${nomor}`;
      skuItemIds[id] = id;
      await pool.query(
        "INSERT INTO sku_item (id, golongan, tingkat, nomor_urut, deskripsi, kategori) VALUES (?, 'penggalang', ?, ?, ?, ?)",
        [id, tingkat, nomor, deskripsi, kategori],
      );
      nomor++;
    }
  }
  console.log(`Seeded ${Object.keys(skuItemIds).length} sku_item rows.`);

  const kategoriData: [string, string, number][] = [
    ["kat-sejarah", "Sejarah Kepramukaan", 1],
    ["kat-tali", "Tali-temali & Pioneering", 2],
    ["kat-sandi", "Sandi & Isyarat", 3],
    ["kat-navigasi", "Navigasi Darat", 4],
    ["kat-p3k", "P3K & Kesehatan Lapangan", 5],
    ["kat-pbb", "Baris-Berbaris (PBB)", 6],
  ];
  for (const [id, nama, urutan] of kategoriData) {
    await pool.query("INSERT INTO materi_kategori (id, nama, urutan) VALUES (?, ?, ?)", [id, nama, urutan]);
  }

  async function topik(kategoriId: string, nama: string, urutan: number) {
    const id = randomUUID();
    await pool.query(
      "INSERT INTO materi_topik (id, kategori_id, nama, urutan) VALUES (?, ?, ?, ?)",
      [id, kategoriId, nama, urutan],
    );
    return id;
  }

  async function unit(topikId: string, judul: string, konten: string, skuIds: string[] = []) {
    const id = randomUUID();
    await pool.query(
      "INSERT INTO materi_unit (id, topik_id, judul, konten_markdown) VALUES (?, ?, ?, ?)",
      [id, topikId, judul, konten],
    );
    for (const skuItemId of skuIds) {
      await pool.query(
        "INSERT INTO materi_relasi (id, materi_unit_id, sku_item_id) VALUES (?, ?, ?)",
        [randomUUID(), id, skuItemId],
      );
    }
    return id;
  }

  const topikSimpul = await topik("kat-tali", "Simpul Dasar", 1);
  await unit(
    topikSimpul,
    "Simpul Mati, Simpul Hidup & Simpul Anyam",
    "# Simpul Dasar\n\n**Simpul mati** dipakai untuk menyambung dua ujung tali yang sama besar dan tidak licin.\n\n**Simpul hidup** dipakai untuk mengikat sesuatu yang mudah dilepas kembali.\n\n**Simpul anyam** dipakai untuk menyambung dua tali yang berbeda besar.",
    ["sku-penggalang-ramu-8"],
  );

  const topikPioneering = await topik("kat-tali", "Pioneering", 2);
  await unit(
    topikPioneering,
    "Dasar-Dasar Pioneering",
    "# Pioneering\n\nPioneering adalah teknik membangun struktur dari tongkat dan tali — mulai dari gapura sederhana hingga menara pandang.",
    ["sku-penggalang-rakit-7", "sku-penggalang-terap-8"],
  );

  const topikSemaphore = await topik("kat-sandi", "Semaphore", 1);
  await unit(
    topikSemaphore,
    "Mengenal Bendera Semaphore",
    "# Semaphore\n\nSemaphore adalah cara mengirim pesan menggunakan dua bendera dengan posisi tangan tertentu untuk tiap huruf.",
    ["sku-penggalang-ramu-10"],
  );

  const topikKompas = await topik("kat-navigasi", "Kompas & Peta", 1);
  await unit(
    topikKompas,
    "Membaca Kompas dan Menentukan Arah",
    "# Kompas\n\nKompas menunjukkan arah Utara magnetis. Delapan arah mata angin utama: Utara, Timur Laut, Timur, Tenggara, Selatan, Barat Daya, Barat, dan Barat Laut.",
    ["sku-penggalang-ramu-9", "sku-penggalang-rakit-8"],
  );

  const topikP3k = await topik("kat-p3k", "Pertolongan Pertama", 1);
  await unit(
    topikP3k,
    "P3K Ringan di Lapangan",
    "# P3K Ringan\n\nLangkah dasar menangani luka ringan, lecet, dan pingsan saat kegiatan di lapangan.",
    ["sku-penggalang-rakit-6"],
  );

  const topikSejarah = await topik("kat-sejarah", "Sejarah Kepramukaan", 1);
  await unit(
    topikSejarah,
    "Sejarah Kepramukaan Dunia & Indonesia",
    "# Sejarah Kepramukaan\n\nGerakan kepramukaan dunia dimulai oleh Baden-Powell pada 1907. Di Indonesia, gerakan ini berkembang menjadi Gerakan Pramuka sejak 1961.",
    ["sku-penggalang-terap-4"],
  );

  console.log("Seed selesai.");
  await pool.end();
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
