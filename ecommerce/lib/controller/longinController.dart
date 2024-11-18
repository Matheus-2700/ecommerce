import 'dart:convert'; // Importa a biblioteca 'convert' para codificação UTF-8
import 'package:crypto/crypto.dart'; // Importa a biblioteca 'crypto' para hashing de senhas
import 'package:ecommerce/helper/databaseHelper.dart'; // Importa o helper do banco de dados
import 'package:ecommerce/models/userModel.dart'; // Importa o modelo 'User'
import 'package:flutter/material.dart'; // Importa widgets do Flutter
import 'package:get/get.dart'; // Importa o GetX para gerenciamento de estado
import 'package:get/get_state_manager/src/simple/get_controllers.dart'; // Importa GetX para gerenciamento de estado
import 'package:sqflite/sqflite.dart'; // Importa o pacote 'sqflite' para operações de banco de dados SQLite

class LoginController extends GetxController {
  final TextEditingController emailController =
      TextEditingController(); // Controlador de texto para o campo de e-mail
  final TextEditingController passwordController =
      TextEditingController(); // Controlador de texto para o campo de senha
  final RxBool isLoading =
      false.obs; // Variável observável para estado de carregamento

  // Getter assíncrono para o banco de dados
  Future<Database> get database async {
    return await DatabaseHelper.instance.database;
  }

  // Método para autenticar o usuário
  Future<bool> loginUser() async {
    final email = emailController.text; // Obtém o e-mail do controlador
    final password = passwordController.text; // Obtém a senha do controlador
    if (email.isEmpty || password.isEmpty) {
      // Verifica se os campos estão vazios
      Get.snackbar(
        'Erro',
        'Preencha todos os campos',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    final user = await getUserByEmailAndPassword(
        email, _hashPassword(password)); // Busca o usuário pelo e-mail e senha
    if (user != null) {
      _clearFields(); // Limpa os campos de entrada
      return true; // Retorna true se o usuário for encontrado
    } else {
      return false; // Retorna false se o usuário não for encontrado
    }
  }

  // Método para obter usuário pelo e-mail e senha
  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    final db = await database; // Obtém a instância do banco de dados
    final maps = await db.query(
      'users', // Nome da tabela
      where: 'email = ? AND password = ?', // Condições da query
      whereArgs: [email, password], // Argumentos das condições
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first); // Retorna o usuário se encontrado
    }
    return null; // Retorna null se não encontrar
  }

  // Método para limpar os campos de entrada
  void _clearFields() {
    emailController.clear(); // Limpa o campo de e-mail
    passwordController.clear(); // Limpa o campo de senha
  }

  // Método privado para hash de senhas usando SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Codifica a senha em bytes UTF-8
    final digest = sha256.convert(bytes); // Calcula o hash SHA-256
    return digest.toString(); // Retorna o hash como uma string
  }
}
