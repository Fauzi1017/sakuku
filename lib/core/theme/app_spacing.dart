/// Spacing / radius / shadow / motion / touch-target tokens.
/// Ported 1:1 from `designtokens.css` (basis 4px).
abstract final class AppSpacing {
  static const s1 = 4.0;
  static const s2 = 8.0;
  static const s3 = 12.0;
  static const s4 = 16.0;
  static const s5 = 20.0;
  static const s6 = 24.0;
  static const s8 = 32.0;
  static const s10 = 40.0;
  static const s12 = 48.0;
  static const s16 = 64.0;
}

abstract final class AppRadius {
  static const sm = 4.0;
  static const md = 8.0;
  static const lg = 12.0;
  static const xl = 16.0;
  static const full = 9999.0;
}

/// Touch target sizes — ramah anak Siaga/Penggalang.
abstract final class AppTouchTarget {
  static const min = 44.0;
  static const comfortable = 56.0;
}

/// Motion durations & easing curves.
abstract final class AppMotion {
  static const fast = Duration(milliseconds: 150);
  static const base = Duration(milliseconds: 250);
  static const slow = Duration(milliseconds: 400);
}
