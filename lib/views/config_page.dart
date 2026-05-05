import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/tarefa_controller.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Provider.of<TarefaController>(context, listen: false);

    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          for (int i = c.tarefas.length - 1; i >= 0; i--) {
            c.removerTarefa(i);
          }
        },
        child: const Text("Resetar Tarefas"),
      ),
    );
  }
}
