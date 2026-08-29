import 'package:flutter/material.dart';

class NeonTheme {
  static const Color background = Color(0xFF030712);
  static const Color surface = Color(0xFF0D1424);
  static const Color cyan = Color(0xFF00F3FF);
  static const Color magenta = Color(0xFFFF007F);
  static const Color gold = Color(0xFFFFE600);
  static const Color neonGreen = Color(0xFF39FF14);
  static const Color alarmRed = Color(0xFFFF0033);

  static ThemeData get themeData => ThemeData.dark().copyWith(
    scaffoldBackgroundColor: background,
    primaryColor: cyan,
    colorScheme: const ColorScheme.dark(
      primary: cyan,
      secondary: magenta,
      surface: surface,
      background: background,
    ),
  );

  static BoxDecoration get neonBoxDecoration => BoxDecoration(
    color: surface.withOpacity(0.85),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: cyan, width: 2),
    boxShadow: [
      BoxShadow(color: cyan.withOpacity(0.4), blurRadius: 16, spreadRadius: 1),
    ],
  );

  static BoxDecoration get marqueeBoxDecoration => BoxDecoration(
    gradient: const RadialGradient(
      center: Alignment.center,
      colors: [Color(0xFF231606), Color(0xFF0A0502)],
    ),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: gold, width: 3),
    boxShadow: [
      BoxShadow(color: gold.withOpacity(0.55), blurRadius: 24, spreadRadius: 2),
      BoxShadow(color: magenta.withOpacity(0.35), blurRadius: 40, spreadRadius: 1),
    ],
  );
}
