import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Primary ───────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF007AFF); // iOS blue
  static const Color primaryDark = Color(0xFF0051A8);

  // ── Neutrals ──────────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF2F2F7);
  static const Color backgroundDark = Color(0xFF1C1C1E);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF2C2C2E);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF000000);
  static const Color textSecondary = Color(0xFF8E8E93);
  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFF8E8E93);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color error = Color(0xFFFF3B30);
  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFFF9500);
}
