import 'package:crypto/crypto.dart';
import 'package:ecommerce/helper/databaseHelper.dart';
import 'package:ecommerce/models/userModel.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sqflite/sqflite.dart';

class UserController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  Future<Database> get _database async {
    return await DatabaseHelper.instance.database;
  }

  Future<int> insertUser(String name, String email, String password) async {
    final db = await _database;
    final hashedPassword = _hashPassword(password); // Aplicar hashing aqui
    return await db.insert('users', {
      'name': name,
      'email': email,
      'password': hashedPassword,
    });
  }

  Future<int> updateUser(User user) async {
    final db = await _database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await _database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
