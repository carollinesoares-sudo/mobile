
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.dark);

  static const _key = 'is_dark_mode';

  Future<void> carregarTema() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key) ?? true;
    value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> alternarTema() async {
    final prefs = await SharedPreferences.getInstance();
    if (value == ThemeMode.dark) {
      value = ThemeMode.light;
      await prefs.setBool(_key, false);
    } else {
      value = ThemeMode.dark;
      await prefs.setBool(_key, true);
    }
  }
}