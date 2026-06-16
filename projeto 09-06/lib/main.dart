import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme_controller.dart'; // Importa o controlador de tema

// Instância global única conectada com o arquivo correto
final ThemeController themeController = ThemeController();// Instância global única do ThemeController

void main() async {
  // 1. Garante que os plugins nativos (SharedPreferences) funcionem antes do runApp
  WidgetsFlutterBinding.ensureInitialized();
  

  await themeController.carregarTema(); // Carrega o tema salvo antes de iniciar a aplicação
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {// StatelessWidget porque o estado do tema é gerenciado pelo ThemeController
  const MyApp({super.key});// Construtor padrão

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeController,
      builder: (context, currentThemeMode, child) {// Rebuilda a aplicação toda vez que o tema mudar
        return MaterialApp(
          title: 'Todo List Sênior',
          debugShowCheckedModeBanner: false,// Remove a tag de debug
          themeMode: currentThemeMode,

          // TEMA CLARO 
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF8FAFC), 
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF6366F1),
              brightness: Brightness.light,
              primary: const Color(0xFF4F46E5),
              surface: Colors.white,
            ),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleTextStyle: TextStyle(color: Color(0xFF1E293B), fontSize: 20, fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Color(0xFF1E293B)),
            ),
          ),

          // TEMA ESCURO 
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0D0B14),
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFFA58DCC),
              brightness: Brightness.dark,
              primary: const Color(0xFFFF7B93),
              surface: const Color(0xFF161420),
            ),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              iconTheme: IconThemeData(color: Colors.white70),
            ),
            datePickerTheme: const DatePickerThemeData(
              backgroundColor: Color(0xFF161420),
              headerBackgroundColor: Color(0xFF0D0B14),
              headerForegroundColor: Colors.white,
            ),
          ),
          
          home: const HomeScreen(),
        );
      },
    );
  }
}