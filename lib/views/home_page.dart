import 'package:flutter/material.dart';
import 'tarefas_page.dart';
import 'dashboard_page.dart';
import 'config_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final telas = const [
    TarefasPage(),
    DashboardPage(),
    ConfigPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EcoTracker"),
        actions: const [
          Icon(Icons.notifications),
          SizedBox(width: 10),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text("Menu", style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: const Text("Tarefas"),
              onTap: () => setState(() => index = 0),
            ),
            ListTile(
              title: const Text("Dashboard"),
              onTap: () => setState(() => index = 1),
            ),
            ListTile(
              title: const Text("Configurações"),
              onTap: () => setState(() => index = 2),
            ),
          ],
        ),
      ),

      body: telas[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Tarefas"),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Config"),
        ],
      ),
    );
  }
}