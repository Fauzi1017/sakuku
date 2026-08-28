/// Domain enums mirroring `schema.sql` ENUM columns.
/// Kept as plain strings at the persistence layer (drift `TextColumn`) so
/// values round-trip 1:1 with the eventual MySQL backend described in the
/// PRD (section 6.2 / 9), while these enums give type safety in Dart.
library;

enum Golongan {
  siaga,
  penggalang,
  penegak,
  pandega;

  String get label => switch (this) {
        Golongan.siaga => 'Siaga',
        Golongan.penggalang => 'Penggalang',
        Golongan.penegak => 'Penegak',
        Golongan.pandega => 'Pandega',
      };

  static Golongan fromDb(String value) => Golongan.values.byName(value);
}

/// Tingkat Penggalang (v1 scope per PRD §5 — golongan lain menyusul).
enum TingkatPenggalang {
  ramu,
  rakit,
  terap;

  String get label => switch (this) {
        TingkatPenggalang.ramu => 'Ramu',
        TingkatPenggalang.rakit => 'Rakit',
        TingkatPenggalang.terap => 'Terap',
      };

  static TingkatPenggalang fromDb(String value) =>
      TingkatPenggalang.values.byName(value);
}

enum RoleType {
  pesertaDidik,
  pembina,
  pelatihSkk,
  adminGudep,
  kwartir;

  String get dbValue => switch (this) {
        RoleType.pesertaDidik => 'peserta_didik',
        RoleType.pembina => 'pembina',
        RoleType.pelatihSkk => 'pelatih_skk',
        RoleType.adminGudep => 'admin_gudep',
        RoleType.kwartir => 'kwartir',
      };

  String get label => switch (this) {
        RoleType.pesertaDidik => 'Peserta Didik',
        RoleType.pembina => 'Pembina',
        RoleType.pelatihSkk => 'Pelatih SKK',
        RoleType.adminGudep => 'Admin Gudep',
        RoleType.kwartir => 'Kwartir',
      };

  static RoleType fromDb(String value) =>
      RoleType.values.firstWhere((r) => r.dbValue == value);
}

/// Status derivatif SKU/SKK — dihitung dari event terakhir yang sah
/// (lihat PRD §6.3 dan §9), bukan field yang di-overwrite langsung.
enum ProgressStatus {
  belum,
  diajukan,
  disahkan,
  ditolak;

  String get label => switch (this) {
        ProgressStatus.belum => 'Belum',
        ProgressStatus.diajukan => 'Diajukan',
        ProgressStatus.disahkan => 'Disahkan',
        ProgressStatus.ditolak => 'Ditolak',
      };

  static ProgressStatus fromDb(String value) =>
      ProgressStatus.values.byName(value);
}

/// Aksi pada event log append-only (`sku_event` / `skk_event`).
enum EventAksi {
  ajukan,
  sahkan,
  tolak,
  batal;

  static EventAksi fromDb(String value) => EventAksi.values.byName(value);
}

enum JenisPelantikan {
  tku,
  tkk;

  String get dbValue => switch (this) {
        JenisPelantikan.tku => 'TKU',
        JenisPelantikan.tkk => 'TKK',
      };

  static JenisPelantikan fromDb(String value) =>
      value == 'TKU' ? JenisPelantikan.tku : JenisPelantikan.tkk;
}
