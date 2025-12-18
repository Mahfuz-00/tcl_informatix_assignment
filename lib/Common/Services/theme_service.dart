// --------------
// Service for managing theme mode (light/dark).
// Uses ChangeNotifier to update UI on switch.
// --------------
import 'package:flutter/material.dart';

class ThemeService with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}