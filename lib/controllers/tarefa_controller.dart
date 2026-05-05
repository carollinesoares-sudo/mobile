import 'package:flutter/material.dart';
import '../models/tarefa.dart';

class TarefaController extends ChangeNotifier {
  final List<Tarefa> _tarefas = [];

  List<Tarefa> get tarefas => _tarefas;

  void criarTarefa(String titulo) {
    if (titulo.trim().isEmpty) return;
    _tarefas.add(Tarefa(titulo: titulo.trim()));
    notifyListeners();
  }

  void alterarTarefa(int index) {
    _tarefas[index].concluida = !_tarefas[index].concluida;
    notifyListeners();
  }

  void removerTarefa(int index) {
    _tarefas.removeAt(index);
    notifyListeners();
  }

  int get totalTarefas => _tarefas.length;

  int get totalTarefasConcluidas => _tarefas.where((t) => t.concluida).length;

  int get totalTarefasPendentes => _tarefas.where((t) => !t.concluida).length;

  double get porcentagem {
    if (_tarefas.isEmpty) return 0;
    return (totalTarefasConcluidas / totalTarefas) * 100;
  }
}
