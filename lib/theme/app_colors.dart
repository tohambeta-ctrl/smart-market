import 'package:flutter/material.dart';

/// All brand colours extracted from the style guide.
abstract final class AppColors {
  // ── Primary (green) ───────────────────────────────────────────────────────
  static const primary = Color(0xFF1B5E20);        // base #1B5E20
  static const primary700 = Color(0xFF1A6B3C);
  static const primary600 = Color(0xFF2E7D32);
  static const primary500 = Color(0xFF388E3C);
  static const primary400 = Color(0xFF4CAF50);
  static const primary300 = Color(0xFF81C784);
  static const primary200 = Color(0xFFA5D6A7);
  static const primary100 = Color(0xFFC8E6C9);
  static const primary50  = Color(0xFFE8F5E9);

  // ── Secondary (slate/teal) ────────────────────────────────────────────────
  static const secondary = Color(0xFF455A64);      // base #455A64
  static const secondary700 = Color(0xFF263238);
  static const secondary600 = Color(0xFF37474F);
  static const secondary500 = Color(0xFF455A64);
  static const secondary400 = Color(0xFF546E7A);
  static const secondary300 = Color(0xFF78909C);
  static const secondary200 = Color(0xFFB0BEC5);
  static const secondary100 = Color(0xFFCFD8DC);
  static const secondary50  = Color(0xFFECEFF1);

  // ── Tertiary (near-white background) ──────────────────────────────────────
  static const tertiary = Color(0xFFF5F5F5);       // base #F5F5F5
  static const surface  = Color(0xFFFFFFFF);
  static const background = Color(0xFFF5F5F5);

  // ── Neutral (dark/text) ───────────────────────────────────────────────────
  static const neutral = Color(0xFF212121);        // base #212121
  static const neutral800 = Color(0xFF424242);
  static const neutral600 = Color(0xFF757575);
  static const neutral400 = Color(0xFFBDBDBD);
  static const neutral200 = Color(0xFFEEEEEE);
  static const neutral100 = Color(0xFFF5F5F5);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const error   = Color(0xFFD32F2F);
  static const warning = Color(0xFFF57C00);
  static const success = Color(0xFF2E7D32);
  static const info    = Color(0xFF0288D1);

  // ── Cameroon flag accent dots ─────────────────────────────────────────────
  static const flagGreen  = Color(0xFF007A5E);
  static const flagRed    = Color(0xFFCE1126);
  static const flagYellow = Color(0xFFFCD116);
}
