import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

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
    if (_database != null && _database!.isOpen) {
      return _database!;
    }

    // Inicializa o databaseFactory para ambientes desktop
    _initializeDatabaseFactory();

    _database = await _initDatabase();
    return _database!;
  }

  // Função para configurar o databaseFactory adequadamente
  void _initializeDatabaseFactory() {
    if (!kIsWeb &&
        (Platform.isLinux || Platform.isWindows || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }

  // Inicializa e abre o banco de dados
  Future<Database> _initDatabase() async {
    final dbPath = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
      dbPath,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Criação das tabelas
    await db.execute('''CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    avatarUrl TEXT
  )''');

    await db.execute('''CREATE TABLE IF NOT EXISTS products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    price REAL NOT NULL
  )''');

    await db.execute('''CREATE TABLE IF NOT EXISTS cart (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    productId INTEGER NOT NULL,
    FOREIGN KEY (productId) REFERENCES products (id)
  )''');

    // Verificando a quantidade de registros
    final productCount = await db.rawQuery('SELECT COUNT(*) FROM products');
    print('Número de produtos inseridos: ${productCount[0]['COUNT(*)']}');
  }

  // Método para atualizações no esquema do banco de dados (versões futuras)
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Realize alterações no banco de dados para novas versões
    }
  }

  // Função para fechar o banco de dados
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
    }
  }
}
