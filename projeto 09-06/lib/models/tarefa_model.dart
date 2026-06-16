class TarefaModel {
  final int? id;
  final int listaId;
  final String titulo;
  final String descricao;
  final String dataVencimento;
  final String prioridade;
  final bool feita;

  TarefaModel({
    this.id,
    required this.listaId,
    required this.titulo,
    required this.descricao,
    required this.dataVencimento,
    required this.prioridade,
    this.feita = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lista_id': listaId,
      'titulo': titulo,
      'descricao': descricao,
      'data_vencimento': dataVencimento,
      'prioridade': prioridade,
      'feita': feita ? 1 : 0, // SQLite armazena booleano como 0 ou 1
    };
  }

  factory TarefaModel.fromMap(Map<String, dynamic> map) {
    return TarefaModel(
      id: map['id'] as int?,
      listaId: map['lista_id'] as int,
      titulo: map['titulo'] as String,
      descricao: map['descricao'] as String? ?? '',
      dataVencimento: map['data_vencimento'] as String,
      prioridade: map['prioridade'] as String? ?? 'Média',
      feita: (map['feita'] as int? ?? 0) == 1,
    );
  }
}