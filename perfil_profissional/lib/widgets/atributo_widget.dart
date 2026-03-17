import 'package:flutter/material.dart';

class AtributoWidget extends StatelessWidget {
  final String titulo;
  final String valor;

  const AtributoWidget(this.titulo, this.valor, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_right),
      title: Text(titulo),
      subtitle: Text(valor),
    );
  }
}