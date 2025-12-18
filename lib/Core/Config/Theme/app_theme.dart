import 'package:flutter/material.dart';

class AppTheme {
  // Light palette (Material 3 colors)
  static final Color lightPrimary = const Color(0xFF0D47A1);    // Blue 900
  static final Color lightSecondary = const Color(0xFF03A9F4);  // Light Blue 500
  static final Color lightTertiary = const Color(0xFFEEEEEE);   // Amber 500
  static final Color lightSurface = const Color(0xFFF5F5F5);    // Grey 100
  static final Color lightBackground = const Color(0xFFFFFFFF); // White

  // Dark palette (Material 3 colors)
  static final Color darkPrimary = const Color(0xFF90CAF9);     // Blue 200
  static final Color darkSecondary = const Color(0xFF03A9F4);   // Light Blue 500
  static final Color darkTertiary = const Color(0xFF282828);    // Amber 300
  static final Color darkSurface = const Color(0xFF121212);     // Dark background
  static final Color darkBackground = const Color(0xFF1E1E1E);  // Slightly lighter than surface

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      tertiary: lightTertiary,
      surface: lightSurface,
      background: lightBackground,
      onPrimary: Colors.white,
      onSecondary: Colors.black87,
      onSurface: Colors.black87,
      onBackground: Colors.black87,
    ),
    scaffoldBackgroundColor: lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: lightSurface,
      foregroundColor: Colors.black87,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      tertiary: darkTertiary,
      surface: darkSurface,
      background: darkBackground,
      onPrimary: Colors.black87,
      onSecondary: Colors.black87,
      onSurface: Colors.white,
      onBackground: Colors.white,
    ),
    scaffoldBackgroundColor: darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: darkSurface,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: const CardThemeData(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
  );
}
