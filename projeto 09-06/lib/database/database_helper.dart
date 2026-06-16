import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/lista_model.dart';
import '../models/tarefa_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('projetos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE listas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tarefas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        lista_id INTEGER NOT NULL,
        titulo TEXT NOT NULL,
        descricao TEXT,
        data_vencimento TEXT NOT NULL,
        prioridade TEXT NOT NULL,
        feita INTEGER NOT NULL DEFAULT 0,
        FOREIGN KEY (lista_id) REFERENCES listas (id) ON DELETE CASCADE
      )
    ''');
  }

  // --- Operações de Listas ---
  Future<int> insertLista(ListaModel lista) async {
    final db = await instance.database;
    return await db.insert('listas', lista.toMap());
  }

  Future<List<ListaModel>> readAllListas() async {
    final db = await instance.database;
    final result = await db.query('listas');
    return result.map((json) => ListaModel.fromMap(json)).toList();
  }

  Future<int> deleteLista(int id) async {
    final db = await instance.database;
    await db.delete('tarefas', where: 'lista_id = ?', whereArgs: [id]);
    return await db.delete('listas', where: 'id = ?', whereArgs: [id]);
  }

  // --- Operações de Tarefas ---
  Future<int> insertTarefa(TarefaModel tarefa) async {
    final db = await instance.database;
    return await db.insert('tarefas', tarefa.toMap());
  }

  Future<List<TarefaModel>> readTarefasPorLista(int listaId) async {
    final db = await instance.database;
    final result = await db.query(
      'tarefas',
      where: 'lista_id = ?',
      whereArgs: [listaId],
    );
    return result.map((json) => TarefaModel.fromMap(json)).toList();
  }

  Future<int> updateTarefa(TarefaModel tarefa) async {
    final db = await instance.database;
    return await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  Future<int> deleteTarefa(int id) async {
    final db = await instance.database;
    return await db.delete('tarefas', where: 'id = ?', whereArgs: [id]);
  }
}