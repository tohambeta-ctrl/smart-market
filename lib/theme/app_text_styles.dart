import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography scale derived from the style guide.
///
/// Headline family → Manrope
/// Body / Label family → Work Sans
abstract final class AppTextStyles {
  // ── Headline (Manrope) ────────────────────────────────────────────────────
  static TextStyle get displayLarge => GoogleFonts.manrope(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral,
        height: 1.12,
      );

  static TextStyle get displayMedium => GoogleFonts.manrope(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral,
        height: 1.16,
      );

  static TextStyle get displaySmall => GoogleFonts.manrope(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral,
        height: 1.22,
      );

  static TextStyle get headlineLarge => GoogleFonts.manrope(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral,
        height: 1.25,
      );

  static TextStyle get headlineMedium => GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral,
        height: 1.29,
      );

  static TextStyle get headlineSmall => GoogleFonts.manrope(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral,
        height: 1.33,
      );

  static TextStyle get titleLarge => GoogleFonts.manrope(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral,
        height: 1.27,
      );

  static TextStyle get titleMedium => GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral,
        letterSpacing: 0.15,
        height: 1.5,
      );

  static TextStyle get titleSmall => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral,
        letterSpacing: 0.1,
        height: 1.43,
      );

  // ── Body (Work Sans) ──────────────────────────────────────────────────────
  static TextStyle get bodyLarge => GoogleFonts.workSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral,
        height: 1.5,
        letterSpacing: 0.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.workSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral,
        height: 1.43,
        letterSpacing: 0.25,
      );

  static TextStyle get bodySmall => GoogleFonts.workSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.neutral600,
        height: 1.33,
        letterSpacing: 0.4,
      );

  // ── Label (Work Sans) ─────────────────────────────────────────────────────
  static TextStyle get labelLarge => GoogleFonts.workSans(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.neutral,
        height: 1.43,
        letterSpacing: 0.1,
      );

  static TextStyle get labelMedium => GoogleFonts.workSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral,
        height: 1.33,
        letterSpacing: 0.5,
      );

  static TextStyle get labelSmall => GoogleFonts.workSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral600,
        height: 1.45,
        letterSpacing: 0.5,
      );

  // ── Convenience shortcuts ─────────────────────────────────────────────────

  /// Splash / branding title
  static TextStyle get splashTitle => GoogleFonts.manrope(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.primary,
        letterSpacing: -0.3,
      );

  /// Tagline / caption uppercase
  static TextStyle get tagline => GoogleFonts.workSans(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.neutral400,
        letterSpacing: 2.0,
      );

  /// "Powered by" strip
  static TextStyle get poweredBy => GoogleFonts.workSans(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.neutral,
        letterSpacing: 1.2,
      );
}
