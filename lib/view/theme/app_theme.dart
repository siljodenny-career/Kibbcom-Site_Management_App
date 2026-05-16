import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFF0D0D0F);
  static const Color surface = Color(0xFF16161A);
  static const Color surfaceCard = Color(0xFF1C1C22);
  static const Color border = Color(0xFF2A2A35);
  static const Color primary = Color(0xFF6C63FF);
  static const Color accentGlow = Color(0xFF8B84FF);
  static const Color textPrimary = Color(0xFFEAEAF0);
  static const Color textSecondary = Color(0xFF8888A0);
  static const Color activeGreen = Color(0xFF34D399);
  static const Color maintOrange = Color(0xFFFBBF24);

  static ThemeData get dark {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.dark(surface: surface, primary: primary),
      textTheme: GoogleFonts.dmSansTextTheme(
        const TextTheme(
          displayLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
          titleMedium: TextStyle(
            color: textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
          bodySmall: TextStyle(color: textSecondary, fontSize: 12),
        ),
      ),
    );
  }
}
