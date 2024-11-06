import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _databaseName = 'app_database.db';
  static const int _databaseVersion = 1;

  // Instância única da classe
  static final DatabaseHelper instance = DatabaseHelper._();

  // Database privado
  static Database? _database;

  // Construtor privado
  DatabaseHelper._();

  // Getter assíncrono para o banco de dados
  Future<Database> get database async {
    // Retorna o banco de dados existente ou o inicializa
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa e abre o banco de dados
  Future<Database> _initDatabase() async {
    // Obtém o caminho do banco de dados
    final dbPath = join(await getDatabasesPath(), _databaseName);

    // Abre o banco de dados com a criação inicial e versão definida
    return await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  // Método chamado na criação do banco de dados
  Future<void> _onCreate(Database db, int version) async {
    // Tabela de usuários
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        avatarUrl TEXT
      )
    ''');

    // Tabela de produtos
    await db.execute('''
      CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        price REAL NOT NULL
      )
    ''');

    // Tabela de carrinho
    await db.execute('''
      CREATE TABLE IF NOT EXISTS cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        productId INTEGER NOT NULL,
        FOREIGN KEY (productId) REFERENCES products (id)
      )
    ''');
  }

  // Método para atualizações no esquema do banco de dados (versões futuras)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Realize alterações no banco de dados para novas versões, como adicionar colunas ou novas tabelas
      // Exemplo:
      // await db.execute('ALTER TABLE users ADD COLUMN new_column TEXT');
    }
  }

  // Função para fechar o banco de dados
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
    }
  }
}
