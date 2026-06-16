class ListaModel {
  final int? id;
  final String nome;

  ListaModel({this.id, required this.nome});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
    };
  }

  factory ListaModel.fromMap(Map<String, dynamic> map) {
    return ListaModel(
      id: map['id'] as int?,
      nome: map['nome'] as String,
    );
  }
}