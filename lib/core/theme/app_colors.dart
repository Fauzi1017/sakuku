import 'package:flutter/material.dart';

/// Design tokens — Platform SKU/SKK Pramuka (v1.0)
/// Ported 1:1 from `designtokens.css` / `tailwind.tokens.js`.
/// Palet terinspirasi warna seragam pramuka (coklat/khaki) + warna
/// golongan sebagai aksen, dengan kontras ramah anak.
abstract final class AppColors {
  // ---------- Brand / Primary (coklat pramuka) ----------
  static const brand50 = Color(0xFFFAF6F0);
  static const brand100 = Color(0xFFF0E6D6);
  static const brand200 = Color(0xFFE0CBAD);
  static const brand300 = Color(0xFFCBA97D);
  static const brand400 = Color(0xFFA97F51);
  static const brand500 = Color(0xFF8B5E34); // coklat khas seragam - primary
  static const brand600 = Color(0xFF6F4726);
  static const brand700 = Color(0xFF573619);
  static const brand800 = Color(0xFF402710);
  static const brand900 = Color(0xFF2A1A0A);

  // ---------- Aksen per golongan ----------
  static const siaga = Color(0xFFF2A93B); // kuning/oranye
  static const penggalang = Color(0xFFD9432E); // merah
  static const penegak = Color(0xFF2E6F73); // hijau tua kebiruan
  static const pandega = Color(0xFF3A4750); // abu gelap

  // ---------- Status SKU/SKK ----------
  static const statusBelum = Color(0xFFB8B2A7); // abu netral
  static const statusDiajukan = Color(0xFFE6A430); // kuning - menunggu uji
  static const statusDisahkan = Color(0xFF4E8B5C); // hijau - lulus
  static const statusDitolak = Color(0xFFC24A3D); // merah - perlu ulang

  // ---------- Semantic ----------
  static const success = Color(0xFF4E8B5C);
  static const warning = Color(0xFFE6A430);
  static const error = Color(0xFFC24A3D);
  static const info = Color(0xFF3B7A94);

  // ---------- Surface & Text (light) ----------
  static const surface = Color(0xFFFFFFFF);
  static const surfaceAlt = Color(0xFFFAF6F0);
  static const surfaceSunken = Color(0xFFF0EAE0);
  static const border = Color(0xFFE0D8C9);
  static const textPrimary = Color(0xFF2A1A0A);
  static const textSecondary = Color(0xFF6B5D4D);
  static const textInverse = Color(0xFFFFFFFF);
  static const textDisabled = Color(0xFFA79A88);

  // ---------- Dark mode (mode malam/kemah) ----------
  static const surfaceDark = Color(0xFF201A12);
  static const surfaceDarkAlt = Color(0xFF2A2318);
  static const borderDark = Color(0xFF3D3323);
  static const textPrimaryDark = Color(0xFFF5EFE4);
  static const textSecondaryDark = Color(0xFFC9BCA5);

  // ---------- Sync/offline status indicator ----------
  static const syncOnline = Color(0xFF4E8B5C);
  static const syncPending = Color(0xFFE6A430);
  static const syncOffline = Color(0xFF8A8074);

  /// Warna aksen sesuai golongan (siaga/penggalang/penegak/pandega).
  static Color golonganAksen(String golongan) => switch (golongan) {
        'siaga' => siaga,
        'penggalang' => penggalang,
        'penegak' => penegak,
        'pandega' => pandega,
        _ => brand500,
      };

  /// Warna badge sesuai status progress SKU/SKK.
  static Color statusColor(String status) => switch (status) {
        'belum' => statusBelum,
        'diajukan' => statusDiajukan,
        'disahkan' => statusDisahkan,
        'ditolak' => statusDitolak,
        _ => statusBelum,
      };
}
