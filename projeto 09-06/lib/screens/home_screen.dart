import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import '../database/database_helper.dart';
import '../models/lista_model.dart';
import '../main.dart'; // Importa o themeController global do main
import 'detalhes_lista_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ListaModel> _todasAsListas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _buscarDadosDoBanco();
  }

  Future<void> _buscarDadosDoBanco() async {
    if (!mounted) return;
    setState(() => _carregando = true);
    final dados = await DatabaseHelper.instance.readAllListas();
    if (!mounted) return;
    setState(() {
      _todasAsListas = dados;
      _carregando = false;
    });
  }

  Widget _buildCategoriaBlock({
    required String tituloCategoria,
    required IconData icone,
    required List<ListaModel> listas,
    required Color corTema,
  }) {
    if (listas.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: corTema.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icone, color: corTema, size: 18),
              ),
              const SizedBox(width: 12),
              Text(
                tituloCategoria.toUpperCase(),
                style: TextStyle(
                  color: corTema.withValues(alpha: 0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: 1.3,
          ),
          itemCount: listas.length,
          itemBuilder: (context, index) {
            final lista = listas[index];
            return Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.05), 
                  width: 1.2,
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalhesListaScreen(
                          listaId: lista.id!,
                          listaNome: lista.nome,
                          lista: lista,
                        ),
                      ),
                    ).then((_) => _buscarDadosDoBanco());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.folder_open_rounded, color: corTema.withValues(alpha: 0.5), size: 20),
                            IconButton(
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.close_rounded, color: Color(0xFFFF5574), size: 18),
                              onPressed: () => _confirmarExclusao(lista),
                            ),
                          ],
                        ),
                        Text(
                          lista.nome,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600, 
                            fontSize: 16,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  void _confirmarExclusao(ListaModel lista) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: const BorderSide(color: Color(0xFFFF5574), width: 1),
        ),
        title: const Text('Desintegrar Bloco?', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text('Tem certeza que deseja excluir "${lista.nome}"? Todas as tarefas sumirão.', style: const TextStyle(color: Colors.grey)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Voltar', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () async {
              await DatabaseHelper.instance.deleteLista(lista.id!);
              if (context.mounted) Navigator.pop(context);
              _buscarDadosDoBanco();
            },
            child: const Text('Apagar', style: TextStyle(color: Color(0xFFFF5574), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listasCasa = _todasAsListas.where((l) => l.nome.toLowerCase().contains('casa') || l.nome.toLowerCase().contains('varrer') || l.nome.toLowerCase().contains('lavar')).toList();
    final listasEstudos = _todasAsListas.where((l) => !listasCasa.contains(l)).toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sincronize seus planos ✨'.toUpperCase(), style: const TextStyle(color: Color(0xFFFF7B93), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 2.5)),
                          const SizedBox(height: 6),
                          const Text('Meus Blocos', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300, letterSpacing: -1.0)),
                        ],
                      ),
                      
                      // CONTROLLER GLOBAL ACIONADO NO BOTÃO
                      ValueListenableBuilder<ThemeMode>(
                        valueListenable: themeController,
                        builder: (context, modoAtual, child) {
                          return Container(
                            decoration: BoxDecoration(
                              color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: IconButton(
                              icon: Icon(
                                modoAtual == ThemeMode.dark 
                                    ? Icons.light_mode_rounded 
                                    : Icons.dark_mode_rounded,
                                color: isDark ? Colors.white70 : Colors.black87,
                                size: 22,
                              ),
                              onPressed: () => themeController.alternarTema(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: _carregando
                      ? const Center(child: CircularProgressIndicator(color: Color(0xFFFF7B93)))
                      : _todasAsListas.isEmpty
                          ? const Center(child: Text('Nenhum bloco operacional.\nInicie um projeto abaixo.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 14, height: 1.5)))
                          : ListView(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              physics: const BouncingScrollPhysics(),
                              children: [
                                _buildCategoriaBlock(tituloCategoria: 'Arquivos de Casa', icone: Icons.roofing_rounded, listas: listasCasa, corTema: const Color(0xFFFF7B93)),
                                _buildCategoriaBlock(tituloCategoria: 'Estudos & Diretrizes', icone: Icons.terminal_rounded, listas: listasEstudos, corTema: const Color(0xFFA58DCC)),
                                const SizedBox(height: 80),
                              ],
                            ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 8),
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), 
          border: Border.all(color: isDark ? Colors.white12 : Colors.black12, width: 1.5), 
          color: isDark ? const Color(0xFF161420) : Colors.white
        ),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.transparent,
          elevation: 0,
          highlightElevation: 0,
          icon: Icon(Icons.add_to_photos_rounded, color: isDark ? Colors.white : Colors.black87, size: 18),
          label: Text('GERAR NOVO BLOCO', style: TextStyle(color: isDark ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 2)),
          onPressed: () => _mostrarCriarListaDialog(context),
        ),
      ),
    );
  }

  void _mostrarCriarListaDialog(BuildContext context) {
    TextEditingController nomeListaController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24), side: BorderSide(color: isDark ? Colors.white12 : Colors.black12)),
        title: const Text('Novo Bloco de Projetos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        content: TextField(
          controller: nomeListaController,
          autofocus: true,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-ZáàâãéèêíïóôõöúçñÁÀÂÃÉÈÊÍÏÓÔÕÖÚÇÑ ]'))],
          style: const TextStyle(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: "Nome do Bloco",
            hintStyle: const TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
            filled: true,
            fillColor: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.black.withValues(alpha: 0.03),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar', style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () async {
              if (nomeListaController.text.trim().isNotEmpty) {
                final novaLista = ListaModel(nome: nomeListaController.text.trim());
                await DatabaseHelper.instance.insertLista(novaLista);
                if (context.mounted) Navigator.pop(context);
                _buscarDadosDoBanco();
              }
            },
            child: const Text('Instanciar', style: TextStyle(color: Color(0xFFA58DCC), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}