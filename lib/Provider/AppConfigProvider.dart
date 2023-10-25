import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;
  SharedPreferences? preferences;
  final String themeKey = 'theme';
  final String languageKey = 'language';

  String? getTheme() {
    return preferences!.getString(themeKey);
  }

  String? getLanguage() {
    return preferences!.getString(languageKey);
  }

  Future<void> saveTheme(ThemeMode themeMode) async {
    String themeValue = (themeMode == ThemeMode.light ? 'light' : 'dark');
    await preferences!.setString(themeKey, themeValue);
  }

  Future<void> saveLanguage(String newLanguage) async {
    preferences!.setString(languageKey, newLanguage);
  }

  Future<void> loadSettingConfig() async {
    preferences = await SharedPreferences.getInstance();
    String? themeMode = getTheme();
    String? lang = getTheme();
    if (themeMode != null) {
      appTheme = (themeMode == 'light' ? ThemeMode.light : ThemeMode.dark);
    }
    if (lang != null) {
      appLanguage = lang;
    }
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }

  void changeTheme(ThemeMode newMode) {
    if (newMode == appTheme) {
      return;
    }
    appTheme = newMode;
    notifyListeners();
    saveTheme(newMode);
  }

  void changeLanguage(String langcode) {
    if (langcode == appLanguage) {
      return;
    }
    appLanguage = langcode;
    notifyListeners();
    saveLanguage(langcode);
  }
}
