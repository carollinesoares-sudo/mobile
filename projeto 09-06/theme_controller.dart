import 'package:flutter/material.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.dark) {
    _carregarTema();
  }

  static const _key = 'is_dark_mode';
  
  get SharedPreferences => null;

  // Carrega a preferência salva ao iniciar o app
  Future<void> _carregarTema() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_key) ?? true; // Padrão será escuro (true)
    value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  // Alterna o tema e salva localmente
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

// Instância global para ser acessada de qualquer tela
final themeController = ThemeController();