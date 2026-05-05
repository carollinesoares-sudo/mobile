import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/tarefa_controller.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Provider.of<TarefaController>(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.count(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _card("Total", c.totalTarefas.toString(), Icons.list, Colors.blue),
          _card(
            "Concluídas",
            c.totalTarefasConcluidas.toString(),
            Icons.check,
            Colors.green,
          ),
          _card(
            "Pendentes",
            c.totalTarefasPendentes.toString(),
            Icons.warning,
            Colors.orange,
          ),
          _card(
            "Progresso",
            "${c.porcentagem.toStringAsFixed(0)}%",
            Icons.percent,
            Colors.purple,
          ),
        ],
      ),
    );
  }

  Widget _card(String t, String v, IconData i, Color c) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(i, size: 35, color: c),
          const SizedBox(height: 10),
          Text(t),
          const SizedBox(height: 5),
          Text(
            v,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: c,
            ),
          ),
        ],
      ),
    );
  }
}
