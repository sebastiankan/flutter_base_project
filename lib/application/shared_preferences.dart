import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDefaults {
  static UserDefaults shared = UserDefaults();

  String _appearance_key = "theme_appearance_key";
  String _locale_key = "current_locale_key";

  /// Appearance
  Future<Brightness> getAppearance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_appearance_key) == "dark" ? Brightness.dark : Brightness.light;
  }

  Future<void> setAppearance(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_appearance_key, isDark ? "dark" : "light");
  }

  /// Appearance
  Future<String> getCurrentLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_locale_key) ?? "";
  }

  Future<void> setCurrentLocale(String locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_locale_key, locale);
  }
}
