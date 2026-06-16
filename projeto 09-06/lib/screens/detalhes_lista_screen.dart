import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/lista_model.dart';
import '../models/tarefa_model.dart';
import 'nova_tarefa_screen.dart';

class DetalhesListaScreen extends StatefulWidget {
  final int listaId;
  final String listaNome;
  final ListaModel lista;

  const DetalhesListaScreen({
    super.key,
    required this.listaId,
    required this.listaNome,
    required this.lista,
  });

  @override
  State<DetalhesListaScreen> createState() => _DetalhesListaScreenState();
}

class _DetalhesListaScreenState extends State<DetalhesListaScreen> {
  List<TarefaModel> _tarefas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarTarefas();
  }

  Future<void> _carregarTarefas() async {
    setState(() => _carregando = true);
    final dados = await DatabaseHelper.instance.readTarefasPorLista(widget.listaId);
    setState(() {
      _tarefas = dados;
      _carregando = false;
    });
  }

  Future<void> _alternarStatusTarefa(TarefaModel tarefa) async {
    final tarefaAtualizada = TarefaModel(
      id: tarefa.id,
      listaId: tarefa.listaId,
      titulo: tarefa.titulo,
      descricao: tarefa.descricao,
      dataVencimento: tarefa.dataVencimento,
      prioridade: tarefa.prioridade,
      feita: !tarefa.feita,
    );
    await DatabaseHelper.instance.updateTarefa(tarefaAtualizada);
    _carregarTarefas();
  }

  Future<void> _deletarTarefa(int id) async {
    await DatabaseHelper.instance.deleteTarefa(id);
    _carregarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listaNome, style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: _carregando
          ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF7B93)))
          : _tarefas.isEmpty
              ? const Center(child: Text('Nenhuma diretriz operacional.', style: TextStyle(color: Colors.grey)))
              : ListView.builder(
                  padding: const EdgeInsets.all(24),
                  itemCount: _tarefas.length,
                  itemBuilder: (context, index) {
                    final tarefa = _tarefas[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      color: Theme.of(context).colorScheme.surface,
                      child: ListTile(
                        leading: Checkbox(
                          value: tarefa.feita,
                          activeColor: const Color(0xFFFF7B93),
                          onChanged: (_) => _alternarStatusTarefa(tarefa),
                        ),
                        title: Text(
                          tarefa.titulo, 
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                            decoration: tarefa.feita ? TextDecoration.lineThrough : null
                          )
                        ),
                        subtitle: const Text(null ?? '', style: TextStyle(color: Colors.grey)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFFF5574)),
                          onPressed: () => _deletarTarefa(tarefa.id!),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFFFF7B93),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovaTarefaScreen(
                listaId: widget.listaId,
                lista: widget.lista,
                onSalvar: (titulo, descricao, data, prioridade) async {
                  final novaTarefa = TarefaModel(
                    listaId: widget.listaId,
                    titulo: titulo,
                    descricao: descricao,
                    dataVencimento: data,
                    prioridade: prioridade,
                    feita: false,
                  );
                  await DatabaseHelper.instance.insertTarefa(novaTarefa);
                  _carregarTarefas();
                },
              ),
            ),
          );
        },
      ),
    );
  }
}