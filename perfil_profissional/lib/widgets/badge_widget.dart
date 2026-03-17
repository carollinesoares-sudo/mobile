import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final String titulo;
  final String valor;

  const BadgeWidget(this.titulo, this.valor, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            valor,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Text(titulo),
        ],
      ),
    );
  }
}