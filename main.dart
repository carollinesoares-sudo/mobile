import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/home_page.dart';
import 'controllers/tarefa_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TarefaController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
