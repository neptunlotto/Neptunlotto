import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors (from styles.css)
  static const Color bgVoid = Color(0xFF07211A);
  static const Color bgPanel = Color(0xFF0E2E24);
  static const Color bgPanelRaised = Color(0xFF123A2D);
  static const Color hairline = Color(0x2EC9A227); // rgba(201, 162, 39, 0.18) -> 0.18 * 255 = 46 ~ 0x2E
  static const Color greenEmerald = Color(0xFF1E7A4C);
  static const Color greenEmeraldBright = Color(0xFF2FAE70);
  static const Color gold = Color(0xFFC9A227);
  static const Color goldBright = Color(0xFFF0D77B);
  static const Color cream = Color(0xFFF3EEDD);
  static const Color inkMuted = Color(0xFF9FB8AC);
  static const Color danger = Color(0xFFE2836B);

  // Map to common theme names for easier migration
  static const Color primary = greenEmerald;
  static const Color secondary = goldBright;
  
  static const Color backgroundLight = bgVoid; // We'll keep dark mode default for both
  static const Color backgroundDark = bgVoid;
  static const Color surfaceLight = bgPanel;
  static const Color surfaceDark = bgPanel;

  static const Color textPrimaryLight = cream;
  static const Color textSecondaryLight = inkMuted;
  static const Color textPrimaryDark = cream;
  static const Color textSecondaryDark = inkMuted;

  static const Color error = danger;
  static const Color borderLight = hairline;
  static const Color borderDark = hairline;
}
