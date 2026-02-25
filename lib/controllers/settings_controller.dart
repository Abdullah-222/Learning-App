import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController with ChangeNotifier {
  final SharedPreferences _prefs;

  double _fontSize = 1.0;
  String _language = 'English';
  ThemeMode _themeMode = ThemeMode.system;
  bool _highContrast = false;

  SettingsController(this._prefs) {
    _loadSettings();
  }

  double get fontSize => _fontSize;
  String get language => _language;
  ThemeMode get themeMode => _themeMode;
  bool get highContrast => _highContrast;

  void _loadSettings() {
    _fontSize = _prefs.getDouble('fontSize') ?? 1.0;
    _language = _prefs.getString('language') ?? 'English';
    _highContrast = _prefs.getBool('highContrast') ?? false;
    final themeIndex = _prefs.getInt('themeMode') ?? 0;
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }

  void updateFontSize(double scale) {
    _fontSize = scale;
    _prefs.setDouble('fontSize', scale);
    notifyListeners();
  }

  void updateLanguage(String? lang) {
    if (lang == null) return;
    _language = lang;
    _prefs.setString('language', lang);
    notifyListeners();
  }

  void updateThemeMode(ThemeMode? mode) {
    if (mode == null) return;
    _themeMode = mode;
    _prefs.setInt('themeMode', mode.index);
    notifyListeners();
  }

  void updateHighContrast(bool value) {
    _highContrast = value;
    _prefs.setBool('highContrast', value);
    notifyListeners();
  }

  Future<void> resetSettings() async {
    await _prefs.clear(); // Clear all locally stored preferences
    _loadSettings();
  }
}
