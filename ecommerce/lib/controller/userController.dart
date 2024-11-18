import 'package:crypto/crypto.dart'; // Importa a biblioteca 'crypto' para hashing de senhas
import 'package:ecommerce/helper/databaseHelper.dart'; // Importa o helper do banco de dados
import 'package:ecommerce/models/userModel.dart'; // Importa o modelo 'User'
import 'dart:convert'; // Importa a biblioteca 'convert' para codificação UTF-8
import 'package:flutter/material.dart'; // Importa widgets do Flutter
import 'package:get/get_state_manager/src/simple/get_controllers.dart'; // Importa GetX para gerenciamento de estado
import 'package:sqflite/sqflite.dart'; // Importa o pacote 'sqflite' para operações de banco de dados SQLite

class UserController extends GetxController {
  final TextEditingController emailController =
      TextEditingController(); // Controlador de texto para o campo de e-mail
  final TextEditingController passwordController =
      TextEditingController(); // Controlador de texto para o campo de senha
  final TextEditingController nameController =
      TextEditingController(); // Controlador de texto para o campo de nome

  // Getter assíncrono para o banco de dados
  Future<Database> get _database async {
    return await DatabaseHelper.instance.database;
  }

  // Método para inserir um novo usuário no banco de dados
  Future<int> insertUser(String name, String email, String password) async {
    final db = await _database;
    final hashedPassword = _hashPassword(password); // Aplica hashing à senha
    return await db.insert('users', {
      'name': name,
      'email': email,
      'password': hashedPassword,
    });
  }

  // Método para atualizar as informações de um usuário existente
  Future<int> updateUser(User user) async {
    final db = await _database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Método para deletar um usuário do banco de dados pelo ID
  Future<int> deleteUser(int id) async {
    final db = await _database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Método privado para hash de senhas usando SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Codifica a senha em bytes UTF-8
    final digest = sha256.convert(bytes); // Calcula o hash SHA-256
    return digest.toString(); // Retorna o hash como uma string
  }
}
