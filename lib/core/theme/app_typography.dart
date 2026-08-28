import 'package:flutter/material.dart';

/// Typography tokens — ported 1:1 from `designtokens.css`.
/// `Inter` untuk body/base, `Poppins` untuk judul/headline (terasa lebih
/// ramah & tegas — cocok untuk audiens Siaga/Penggalang).
abstract final class AppTypography {
  static const fontFamilyBase = 'Inter';
  static const fontFamilyDisplay = 'Poppins';

  static const fontSizeXs = 12.0;
  static const fontSizeSm = 14.0;
  static const fontSizeBase = 16.0;
  static const fontSizeLg = 18.0;
  static const fontSizeXl = 20.0;
  static const fontSize2xl = 24.0;
  static const fontSize3xl = 30.0;
  static const fontSize4xl = 36.0;

  static const weightRegular = FontWeight.w400;
  static const weightMedium = FontWeight.w500;
  static const weightSemibold = FontWeight.w600;
  static const weightBold = FontWeight.w700;

  static const lineHeightTight = 1.25;
  static const lineHeightNormal = 1.5;
  static const lineHeightRelaxed = 1.75;

  static TextTheme textTheme(Color primary, Color secondary) => TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontFamilyDisplay,
          fontSize: fontSize4xl,
          fontWeight: weightBold,
          height: lineHeightTight,
          color: primary,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamilyDisplay,
          fontSize: fontSize3xl,
          fontWeight: weightBold,
          height: lineHeightTight,
          color: primary,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamilyDisplay,
          fontSize: fontSize2xl,
          fontWeight: weightSemibold,
          height: lineHeightTight,
          color: primary,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamilyDisplay,
          fontSize: fontSizeXl,
          fontWeight: weightSemibold,
          height: lineHeightTight,
          color: primary,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamilyDisplay,
          fontSize: fontSizeLg,
          fontWeight: weightSemibold,
          height: lineHeightNormal,
          color: primary,
        ),
        titleLarge: TextStyle(
          fontFamily: fontFamilyDisplay,
          fontSize: fontSizeLg,
          fontWeight: weightMedium,
          height: lineHeightNormal,
          color: primary,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamilyBase,
          fontSize: fontSizeBase,
          fontWeight: weightMedium,
          height: lineHeightNormal,
          color: primary,
        ),
        titleSmall: TextStyle(
          fontFamily: fontFamilyBase,
          fontSize: fontSizeSm,
          fontWeight: weightMedium,
          height: lineHeightNormal,
          color: primary,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamilyBase,
          fontSize: fontSizeBase,
          fontWeight: weightRegular,
          height: lineHeightRelaxed,
          color: primary,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamilyBase,
          fontSize: fontSizeSm,
          fontWeight: weightRegular,
          height: lineHeightNormal,
          color: primary,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamilyBase,
          fontSize: fontSizeXs,
          fontWeight: weightRegular,
          height: lineHeightNormal,
          color: secondary,
        ),
        labelLarge: TextStyle(
          fontFamily: fontFamilyBase,
          fontSize: fontSizeSm,
          fontWeight: weightSemibold,
          height: lineHeightNormal,
          color: primary,
        ),
        labelMedium: TextStyle(
          fontFamily: fontFamilyBase,
          fontSize: fontSizeXs,
          fontWeight: weightMedium,
          height: lineHeightNormal,
          color: secondary,
        ),
        labelSmall: TextStyle(
          fontFamily: fontFamilyBase,
          fontSize: fontSizeXs,
          fontWeight: weightMedium,
          height: lineHeightNormal,
          color: secondary,
        ),
      );
}
