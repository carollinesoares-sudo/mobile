
import 'package:flutter/material.dart';// Importa o material design do Flutter
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.dark);// Inicializa com o tema escuro por padrão
  static const _key = 'is_dark_mode';

  Future<void> carregarTema() async {
    final prefs = await SharedPreferences.getInstance();// Obtém a instância do SharedPreferences
    final isDark = prefs.getBool(_key) ?? true;// Lê o valor salvo, ou assume true (tema escuro) se não houver valor
    value = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> alternarTema() async {
    final prefs = await SharedPreferences.getInstance(); // Obtém a instância do SharedPreferences
    if (value == ThemeMode.dark) {
      value = ThemeMode.light;
      await prefs.setBool(_key, false);
    } else {// Se o tema atual for claro, muda para escuro
      value = ThemeMode.dark;
      await prefs.setBool(_key, true);// Salva a preferência de tema como escuro
    }
  }
}