import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/utils/password_hash.dart';
import '../local/database.dart';

const _uuid = Uuid();

/// Seeds the local database with demo data on first run so the app is
/// immediately usable offline, without a backend.
///
/// Scope follows the PRD's MVP recommendation (§5, §13): golongan
/// **Penggalang** only (Ramu/Rakit/Terap), one demo `gudep`. The SKU point
/// descriptions below are illustrative/representative of the real
/// structure (kategori: spiritual, kenegaraan, fisik & kesehatan,
/// keterampilan, sosial) — per PRD §7.3 and §12, final wording must still
/// be curated against the SK Kwarnas that is in force, which is outside
/// engineering's scope.
abstract final class SeedData {
  static const demoGudepId = 'seed-gudep-1';

  static Future<void> seedIfEmpty(AppDatabase db) async {
    final hasData = await db.select(db.gudeps).get();
    if (hasData.isNotEmpty) return;

    await db.transaction(() async {
      await _seedGudep(db);
      final akun = await _seedAkun(db);
      await _seedSkuPenggalang(db);
      await _seedMateri(db);
      await _seedProgressDemo(db, akun);
    });
  }

  static Future<void> _seedGudep(AppDatabase db) async {
    await db.into(db.gudeps).insert(
          GudepsCompanion.insert(
            id: demoGudepId,
            nama: 'Gudep 01.001 Rimba Contoh',
            alamat: const Value('Jl. Kepramukaan No. 1'),
            kwarcab: const Value('Kwarcab Contoh'),
          ),
        );
  }

  /// Returns the created pengguna ids keyed by role, for [_seedProgressDemo].
  static Future<_DemoAkun> _seedAkun(AppDatabase db) async {
    Future<String> pengguna({
      required String nama,
      required String email,
      required String password,
      required String role,
    }) async {
      final id = _uuid.v4();
      await db.into(db.penggunas).insert(
            PenggunasCompanion.insert(
              id: id,
              gudepId: demoGudepId,
              nama: nama,
              email: Value(email),
              passwordHash: PasswordHash.hash(password),
              role: role,
            ),
          );
      return id;
    }

    final adminId = await pengguna(
      nama: 'Admin Gudep',
      email: 'admin@sakuku.test',
      password: 'admin123',
      role: 'admin_gudep',
    );

    final pembinaId = await pengguna(
      nama: 'Kak Pembina',
      email: 'pembina@sakuku.test',
      password: 'pembina123',
      role: 'pembina',
    );
    await db.into(db.pembinaProfils).insert(
          PembinaProfilsCompanion.insert(
            id: _uuid.v4(),
            penggunaId: pembinaId,
          ),
        );

    final pelatihId = await pengguna(
      nama: 'Kak Pelatih Renang',
      email: 'pelatih@sakuku.test',
      password: 'pelatih123',
      role: 'pelatih_skk',
    );
    await db.into(db.pembinaProfils).insert(
          PembinaProfilsCompanion.insert(
            id: _uuid.v4(),
            penggunaId: pelatihId,
            bidangKeahlian: const Value('Renang'),
          ),
        );

    final pesertaId = await pengguna(
      nama: 'Ahmad Fauzi',
      email: 'peserta@sakuku.test',
      password: 'peserta123',
      role: 'peserta_didik',
    );
    final pesertaAnggotaId = _uuid.v4();
    await db.into(db.anggotas).insert(
          AnggotasCompanion.insert(
            id: pesertaAnggotaId,
            penggunaId: pesertaId,
            nis: const Value('P-0001'),
            golongan: 'penggalang',
            tingkatSaatIni: const Value('ramu'),
            reguPasukan: const Value('Regu Elang'),
          ),
        );

    final peserta2Id = await pengguna(
      nama: 'Siti Rahma',
      email: 'peserta2@sakuku.test',
      password: 'peserta123',
      role: 'peserta_didik',
    );
    final peserta2AnggotaId = _uuid.v4();
    await db.into(db.anggotas).insert(
          AnggotasCompanion.insert(
            id: peserta2AnggotaId,
            penggunaId: peserta2Id,
            nis: const Value('P-0002'),
            golongan: 'penggalang',
            tingkatSaatIni: const Value('rakit'),
            reguPasukan: const Value('Regu Melati'),
          ),
        );

    return _DemoAkun(
      adminId: adminId,
      pembinaId: pembinaId,
      pelatihId: pelatihId,
      pesertaId: pesertaId,
      pesertaAnggotaId: pesertaAnggotaId,
      peserta2Id: peserta2Id,
      peserta2AnggotaId: peserta2AnggotaId,
    );
  }

  static Future<void> _seedSkuPenggalang(AppDatabase db) async {
    for (final tingkat in _skuPenggalang.keys) {
      var nomor = 1;
      for (final (kategori, deskripsi) in _skuPenggalang[tingkat]!) {
        await db.into(db.skuItems).insert(
              SkuItemsCompanion.insert(
                id: 'sku-penggalang-$tingkat-$nomor',
                golongan: 'penggalang',
                tingkat: tingkat,
                nomorUrut: nomor,
                deskripsi: deskripsi,
                kategori: Value(kategori),
              ),
            );
        nomor++;
      }
    }
  }

  static const _skuPenggalang = <String, List<(String, String)>>{
    'ramu': [
      ('spiritual', 'Dapat melaksanakan ibadah sesuai agama dan kepercayaannya secara rutin.'),
      ('spiritual', 'Dapat menyebutkan dan menjelaskan arti Dasa Dharma dan Tri Satya dengan kata-katanya sendiri.'),
      ('kenegaraan', 'Dapat mengetahui dan menjelaskan tentang lambang negara dan bendera Merah Putih.'),
      ('kenegaraan', 'Dapat menyanyikan lagu Indonesia Raya dengan sikap yang benar.'),
      ('fisik', 'Dapat menjalankan salah satu cabang olahraga sesuai bakat dan minatnya.'),
      ('fisik', 'Tahu tentang kesehatan pribadi dan lingkungan.'),
      ('keterampilan', 'Dapat baris-berbaris sedikitnya sepuluh macam gerakan dasar PBB.'),
      ('keterampilan', 'Dapat membuat simpul mati, simpul hidup, dan simpul anyam untuk keperluan sehari-hari.'),
      ('keterampilan', 'Dapat menggunakan kompas dan tahu arah mata angin.'),
      ('keterampilan', 'Mengetahui dan dapat memperagakan isyarat semaphore dasar.'),
      ('sosial', 'Dapat menyampaikan pesan secara lisan.'),
      ('sosial', 'Setia membayar iuran kepada gugusdepannya, dengan uang yang diusahakannya sendiri.'),
    ],
    'rakit': [
      ('spiritual', 'Dapat menjelaskan riwayat hidup salah satu tokoh agama yang dianutnya.'),
      ('spiritual', 'Selalu berusaha menjalankan ibadah tepat waktu.'),
      ('kenegaraan', 'Dapat menjelaskan tentang lembaga-lembaga negara secara sederhana.'),
      ('kenegaraan', 'Pernah mengikuti kegiatan bakti masyarakat di lingkungannya.'),
      ('fisik', 'Dapat menjelaskan bahaya narkoba, HIV/AIDS, dan penyakit menular lainnya.'),
      ('fisik', 'Dapat memberikan pertolongan pertama pada kecelakaan (P3K) ringan.'),
      ('keterampilan', 'Dapat membuat pioneering sederhana dengan tali dan tongkat.'),
      ('keterampilan', 'Dapat membaca peta dan menggunakan kompas untuk menentukan arah perjalanan.'),
      ('keterampilan', 'Dapat memasak untuk regunya di perkemahan.'),
      ('keterampilan', 'Dapat mengirim dan menerima berita dengan isyarat morse atau semaphore.'),
      ('sosial', 'Pernah ikut serta dalam kegiatan kepemimpinan regu.'),
      ('sosial', 'Dapat menabung secara teratur.'),
    ],
    'terap': [
      ('spiritual', 'Dapat memimpin doa/ibadah pada suatu kegiatan pasukan.'),
      ('spiritual', 'Mengajak dan mendorong temannya menjalankan ibadah.'),
      ('kenegaraan', 'Pernah ikut serta secara aktif dalam upacara peringatan hari-hari besar nasional.'),
      ('kenegaraan', 'Dapat menjelaskan sejarah kepramukaan dunia dan Indonesia secara garis besar.'),
      ('fisik', 'Dapat berenang menempuh jarak sedikitnya 25 meter.'),
      ('fisik', 'Tahu cara menjaga kebugaran jasmani dan menyusun pola hidup sehat.'),
      ('keterampilan', 'Dapat memimpin baris-berbaris di dalam regunya.'),
      ('keterampilan', 'Dapat membuat menara pandang atau pioneering tingkat lanjut.'),
      ('keterampilan', 'Dapat merencanakan dan memimpin acara api unggun.'),
      ('keterampilan', 'Dapat menggunakan GPS dasar atau aplikasi peta digital untuk navigasi.'),
      ('sosial', 'Pernah memimpin regunya dalam suatu kegiatan/tugas tertentu.'),
      ('sosial', 'Dapat merencanakan dan mengelola anggaran sederhana untuk kegiatan regu.'),
    ],
  };

  static Future<void> _seedMateri(AppDatabase db) async {
    final kategoriData = <(String id, String nama, int urutan)>[
      ('kat-sejarah', 'Sejarah Kepramukaan', 1),
      ('kat-tali', 'Tali-temali & Pioneering', 2),
      ('kat-sandi', 'Sandi & Isyarat', 3),
      ('kat-navigasi', 'Navigasi Darat', 4),
      ('kat-p3k', 'P3K & Kesehatan Lapangan', 5),
      ('kat-pbb', 'Baris-Berbaris (PBB)', 6),
    ];
    for (final (id, nama, urutan) in kategoriData) {
      await db.into(db.materiKategoris).insert(
            MateriKategorisCompanion.insert(
              id: id,
              nama: nama,
              urutan: Value(urutan),
            ),
          );
    }

    Future<String> topik(String kategoriId, String nama, int urutan) async {
      final id = _uuid.v4();
      await db.into(db.materiTopiks).insert(
            MateriTopiksCompanion.insert(
              id: id,
              kategoriId: kategoriId,
              nama: nama,
              urutan: Value(urutan),
            ),
          );
      return id;
    }

    Future<String> unit(
      String topikId,
      String judul,
      String konten, {
      int urutan = 0,
      List<String> skuItemIds = const [],
    }) async {
      final id = _uuid.v4();
      await db.into(db.materiUnits).insert(
            MateriUnitsCompanion.insert(
              id: id,
              topikId: topikId,
              judul: judul,
              kontenMarkdown: konten,
              urutan: Value(urutan),
            ),
          );
      for (final skuItemId in skuItemIds) {
        await db.into(db.materiRelasis).insert(
              MateriRelasisCompanion.insert(
                id: _uuid.v4(),
                materiUnitId: id,
                skuItemId: Value(skuItemId),
              ),
            );
      }
      return id;
    }

    final topikSimpul = await topik('kat-tali', 'Simpul Dasar', 1);
    await unit(
      topikSimpul,
      'Simpul Mati, Simpul Hidup & Simpul Anyam',
      '# Simpul Dasar\n\n'
          '**Simpul mati** dipakai untuk menyambung dua ujung tali yang '
          'sama besar dan tidak licin.\n\n'
          '**Simpul hidup** dipakai untuk mengikat sesuatu yang mudah '
          'dilepas kembali.\n\n'
          '**Simpul anyam** dipakai untuk menyambung dua tali yang '
          'berbeda besar.\n\n'
          '_Latihan rutin membuat simpul akan membantumu lulus poin SKU '
          'terkait tali-temali._',
      skuItemIds: const ['sku-penggalang-ramu-8'],
    );

    final topikPioneering = await topik('kat-tali', 'Pioneering', 2);
    await unit(
      topikPioneering,
      'Dasar-Dasar Pioneering',
      '# Pioneering\n\n'
          'Pioneering adalah teknik membangun struktur dari tongkat dan '
          'tali — mulai dari gapura sederhana hingga menara pandang.\n\n'
          'Struktur sederhana biasanya memakai simpul pangkal dan ikatan '
          'silang.',
      skuItemIds: const ['sku-penggalang-rakit-7', 'sku-penggalang-terap-8'],
    );

    final topikSemaphore = await topik('kat-sandi', 'Semaphore', 1);
    await unit(
      topikSemaphore,
      'Mengenal Bendera Semaphore',
      '# Semaphore\n\n'
          'Semaphore adalah cara mengirim pesan menggunakan dua bendera '
          'dengan posisi tangan tertentu untuk tiap huruf.\n\n'
          'Mulailah berlatih dari huruf A-Z secara berurutan sebelum '
          'mencoba mengirim kalimat penuh.',
      skuItemIds: const ['sku-penggalang-ramu-10'],
    );

    final topikMorse = await topik('kat-sandi', 'Sandi Morse', 2);
    await unit(
      topikMorse,
      'Dasar Sandi Morse',
      '# Sandi Morse\n\n'
          'Morse menggunakan kombinasi titik (pendek) dan garis (panjang) '
          'untuk tiap huruf/angka, bisa dikirim lewat suara, cahaya, atau '
          'ketukan.',
      skuItemIds: const ['sku-penggalang-rakit-10'],
    );

    final topikKompas = await topik('kat-navigasi', 'Kompas & Peta', 1);
    await unit(
      topikKompas,
      'Membaca Kompas dan Menentukan Arah',
      '# Kompas\n\n'
          'Kompas menunjukkan arah Utara magnetis. Delapan arah mata '
          'angin utama: Utara, Timur Laut, Timur, Tenggara, Selatan, '
          'Barat Daya, Barat, dan Barat Laut.',
      skuItemIds: const ['sku-penggalang-ramu-9', 'sku-penggalang-rakit-8'],
    );

    final topikGps = await topik('kat-navigasi', 'GPS & Peta Digital', 2);
    await unit(
      topikGps,
      'Navigasi dengan GPS Dasar',
      '# GPS Dasar\n\n'
          'Selain kompas konvensional, aplikasi peta digital dapat '
          'membantu navigasi saat sinyal tersedia — tetap penting '
          'menguasai kompas manual untuk kondisi tanpa sinyal di alam '
          'terbuka.',
      skuItemIds: const ['sku-penggalang-terap-10'],
    );

    final topikP3k = await topik('kat-p3k', 'Pertolongan Pertama', 1);
    await unit(
      topikP3k,
      'P3K Ringan di Lapangan',
      '# P3K Ringan\n\n'
          'Langkah dasar menangani luka ringan, lecet, dan pingsan saat '
          'kegiatan di lapangan: bersihkan, tenangkan, dan segera rujuk '
          'ke tenaga medis bila perlu.',
      skuItemIds: const ['sku-penggalang-rakit-6'],
    );

    final topikPbbDasar = await topik('kat-pbb', 'Gerakan Dasar PBB', 1);
    await unit(
      topikPbbDasar,
      '10 Gerakan Dasar Baris-Berbaris',
      '# PBB Dasar\n\n'
          'Sikap sempurna, istirahat, hormat, lencang kanan/kiri, hadap '
          'kanan/kiri/serong, balik kanan, dan langkah tegap adalah '
          'gerakan dasar yang wajib dikuasai.',
      skuItemIds: const ['sku-penggalang-ramu-7'],
    );

    final topikSejarah = await topik('kat-sejarah', 'Sejarah Kepramukaan', 1);
    await unit(
      topikSejarah,
      'Sejarah Kepramukaan Dunia & Indonesia',
      '# Sejarah Kepramukaan\n\n'
          'Gerakan kepramukaan dunia dimulai oleh Baden-Powell pada 1907. '
          'Di Indonesia, gerakan ini berkembang menjadi Gerakan Pramuka '
          'sejak 1961 dengan Sri Sultan Hamengkubuwono IX sebagai Bapak '
          'Pramuka Indonesia.',
      skuItemIds: const ['sku-penggalang-terap-4'],
    );
  }

  /// Beberapa data progress contoh supaya checklist & antrian pembina
  /// tidak kosong saat pertama kali membuka app.
  static Future<void> _seedProgressDemo(
    AppDatabase db,
    _DemoAkun akun,
  ) async {
    Future<void> progress(
      String anggotaId,
      String skuItemId,
      String status, {
      String? catatan,
    }) async {
      final progressId = _uuid.v4();
      await db.into(db.skuProgresses).insert(
            SkuProgressesCompanion.insert(
              id: progressId,
              anggotaId: anggotaId,
              skuItemId: skuItemId,
              status: Value(status),
            ),
          );
      await db.into(db.skuEvents).insert(
            SkuEventsCompanion.insert(
              id: _uuid.v4(),
              skuProgressId: progressId,
              aktorId: status == 'diajukan' ? akun.pesertaId : akun.pembinaId,
              aksi: status == 'diajukan' ? 'ajukan' : 'sahkan',
              catatan: Value(catatan),
              deviceId: const Value('seed'),
            ),
          );
    }

    await progress(akun.pesertaAnggotaId, 'sku-penggalang-ramu-1', 'disahkan');
    await progress(akun.pesertaAnggotaId, 'sku-penggalang-ramu-2', 'disahkan');
    await progress(akun.pesertaAnggotaId, 'sku-penggalang-ramu-3', 'diajukan');
    await progress(akun.peserta2AnggotaId, 'sku-penggalang-rakit-1', 'diajukan');
  }
}

class _DemoAkun {
  final String adminId;
  final String pembinaId;
  final String pelatihId;
  final String pesertaId;
  final String pesertaAnggotaId;
  final String peserta2Id;
  final String peserta2AnggotaId;

  const _DemoAkun({
    required this.adminId,
    required this.pembinaId,
    required this.pelatihId,
    required this.pesertaId,
    required this.pesertaAnggotaId,
    required this.peserta2Id,
    required this.peserta2AnggotaId,
  });
}
