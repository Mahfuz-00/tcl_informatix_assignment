// ------------------------------------------------------------
// AppTheme
//
// - Centralized theme configuration for the app
// - Defines Material 3 light and dark color palettes
// - Sets scaffoldBackgroundColor, AppBarTheme, CardTheme for consistent UI
// - Light and dark ThemeData objects available for ThemeService
// ------------------------------------------------------------


import 'package:flutter/material.dart';

class AppTheme {
  // -------------------- Light Palette --------------------
  static const Color lightPrimary = Color(0xFF0D47A1);
  static const Color lightSecondary = Color(0xFF03A9F4);
  static const Color lightTertiary = Color(0xFF7F92AB);
  static const Color lightSurface = Color(0xFFF5F5F5);
  static const Color lightCard = Color(0xFFF5F5F5); // off-white card

  // -------------------- Dark Palette --------------------
  static const Color darkPrimary = Color(0xFF90CAF9);
  static const Color darkSecondary = Color(0xFF023B54);
  static const Color darkTertiary = Color(0xFF03034D);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkCard = Color(0xFF323232); // grey card

  // -------------------- Light Theme --------------------
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      tertiary: lightTertiary,
      surface: lightSurface,
      onPrimary: Colors.white,
      onSecondary: Colors.black87,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: lightSurface,
    cardTheme: const CardThemeData(
      color: lightCard,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: Colors.black87,
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      centerTitle: false,
    ),
  );

  // -------------------- Dark Theme --------------------
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      tertiary: darkTertiary,
      surface: darkSurface,
      onPrimary: Colors.black87,
      onSecondary: Colors.black87,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: darkSurface,
    cardTheme: const CardThemeData(
      color: darkCard,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: Colors.white,
      elevation: 5,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      centerTitle: false,
    ),
  );
}
