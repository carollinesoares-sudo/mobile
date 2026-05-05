import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/tarefa_controller.dart';

class TarefasPage extends StatelessWidget {
  const TarefasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Provider.of<TarefaController>(context);
    final input = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: input,
              decoration: InputDecoration(
                labelText: "Nova tarefa",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    c.criarTarefa(input.text);
                    input.clear();
                  },
                ),
              ),
            ),
          ),

          const TabBar(
            tabs: [
              Tab(text: "Pendentes"),
              Tab(text: "Concluídas"),
            ],
          ),

          Expanded(
            child: TabBarView(children: [_lista(c, false), _lista(c, true)]),
          ),
        ],
      ),
    );
  }

  Widget _lista(TarefaController c, bool concluida) {
    final tarefas = c.tarefas.where((t) => t.concluida == concluida).toList();

    if (tarefas.isEmpty) {
      return const Center(child: Text("Nenhuma tarefa aqui 🎉"));
    }

    return ListView(
      children: tarefas.map((t) {
        return ListTile(
          title: Text(t.titulo),
          subtitle: Text("Criado: ${t.dataCriacao.day}/${t.dataCriacao.month}"),
          trailing: concluida
              ? null
              : IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => c.alterarTarefa(c.tarefas.indexOf(t)),
                ),
        );
      }).toList(),
    );
  }
}
