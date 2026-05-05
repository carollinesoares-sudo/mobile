class Tarefa {
  String titulo;
  bool concluida;
  DateTime dataCriacao;

  Tarefa({
    required this.titulo,
    this.concluida = false,
    DateTime? dataCriacao,
  }) : dataCriacao = dataCriacao ?? DateTime.now();
}