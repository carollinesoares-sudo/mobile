import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/lista_model.dart';
import '../models/tarefa_model.dart';
import 'nova_tarefa_screen.dart';

class DetalhesListaScreen extends StatefulWidget {
  final int listaId;
  final String listaNome;
  final ListaModel lista;// Adiciona o modelo completo da lista para passar para a nova tarefa  

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

  Future<void> _carregarTarefas() async {// Carrega as tarefas da lista do banco de dados
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
    await DatabaseHelper.instance.updateTarefa(tarefaAtualizada);// Atualiza o status da tarefa no banco de dados
    _carregarTarefas();
  }

  Future<void> _deletarTarefa(int id) async {
    await DatabaseHelper.instance.deleteTarefa(id);// Deleta a tarefa do banco de dados
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
          Navigator.push(  // Navega para a tela de nova tarefa, passando o ID da lista e um callback para salvar a nova tarefa
            context,
            MaterialPageRoute(
              builder: (context) => NovaTarefaScreen(// Passa o ID da lista para a nova tarefa
                listaId: widget.listaId,
                lista: widget.lista,
                onSalvar: (titulo, descricao, data, prioridade) async {// Callback que será chamado quando a nova tarefa for salva
                  final novaTarefa = TarefaModel(
                    listaId: widget.listaId,
                    titulo: titulo,
                    descricao: descricao,// A descrição é opcional, então pode ser vazia
                    dataVencimento: data,
                    prioridade: prioridade,// A nova tarefa começa como não feita
                    feita: false,
                  );
                  await DatabaseHelper.instance.insertTarefa(novaTarefa);// Insere a nova tarefa no banco de dados
                  _carregarTarefas();// Recarrega a lista de tarefas para mostrar a nova tarefa adicionada
                },
              ),
            ),
          );
        },
      ),
    );
  }
}