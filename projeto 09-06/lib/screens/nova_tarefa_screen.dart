import 'package:flutter/material.dart';
import '../models/lista_model.dart';

class NovaTarefaScreen extends StatefulWidget {
  final int listaId;
  final ListaModel lista;
  final Function(String titulo, String descricao, String data, String prioridade) onSalvar;

  const NovaTarefaScreen({
    super.key, 
    required this.listaId, 
    required this.lista,
    required this.onSalvar,
  });

  @override
  State<NovaTarefaScreen> createState() => _NovaTarefaScreenState();
}

class _NovaTarefaScreenState extends State<NovaTarefaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _dataController = TextEditingController();
  String _prioridadeSelecionada = 'Média';

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Criar Nova Tarefa', style: TextStyle(color: isDark ? Colors.white : Colors.black87)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Preencha os detalhes abaixo ✨', style: TextStyle(color: Color(0xFFFF7B93), fontSize: 13, fontWeight: FontWeight.bold)),
                const SizedBox(height: 24),
                _buildInputField(controller: _tituloController, label: 'Título da Tarefa *', icon: Icons.edit_note_rounded, obrigatorio: true),
                const SizedBox(height: 20),
                _buildInputField(controller: _descricaoController, label: 'Descrição / Detalhes', icon: Icons.description_outlined, maxLines: 4, obrigatorio: false),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: _dataController,
                  label: 'Data de Vencimento *',
                  icon: Icons.calendar_today_rounded,
                  readOnly: true,
                  obrigatorio: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _dataController.text = "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  children: ['Baixa', 'Média', 'Alta'].map((prioridade) {
                    bool estaSelecionado = _prioridadeSelecionada == prioridade;
                    Color corFoco = prioridade == 'Alta' ? const Color(0xFFFF5574) : prioridade == 'Média' ? const Color(0xFFFFA500) : const Color(0xFF4CAF50);
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _prioridadeSelecionada = prioridade),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: estaSelecionado ? corFoco.withValues(alpha: 0.15) : (isDark ? Colors.white.withValues(alpha: 0.02) : Colors.black.withValues(alpha: 0.02)),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: estaSelecionado ? corFoco : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05))),
                          ),
                          child: Center(
                            child: Text(
                              prioridade, 
                              style: TextStyle(
                                color: estaSelecionado ? (isDark ? Colors.white : Colors.black) : Colors.grey, 
                                fontWeight: estaSelecionado ? FontWeight.bold : FontWeight.normal
                              )
                            )
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), 
                    color: Theme.of(context).colorScheme.surface, 
                    border: Border.all(color: isDark ? Colors.white12 : Colors.black12)
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        widget.onSalvar(
                          _tituloController.text.trim(),
                          _descricaoController.text.trim(),
                          _dataController.text.trim(),
                          _prioridadeSelecionada,
                        );
                        Navigator.pop(context); 
                      }
                    },
                    child: Text('SALVAR DIRETRIZ', style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String label, required IconData icon, int maxLines = 1, bool readOnly = false, bool obrigatorio = true, VoidCallback? onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      readOnly: readOnly,
      onTap: onTap,
      style: TextStyle(color: isDark ? Colors.white : Colors.black87),
      validator: (value) => obrigatorio && (value == null || value.trim().isEmpty) ? 'Campo obrigatório' : null,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
        filled: true,
        fillColor: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      ),
    );
  }
}