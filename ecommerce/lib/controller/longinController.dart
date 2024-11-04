import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:ecommerce/helper/databaseHelper.dart';
import 'package:ecommerce/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sqflite/sqflite.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  Future<Database> get database async {
    return await DatabaseHelper.instance.database;
  }

  Future<bool> loginUser() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Erro',
        'Preencha todos os campos',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    final user =
        await getUserByEmailAndPassword(email, _hashPassword(password));

    if (user != null) {
      _clearFields();
      return true;
    } else {
      return false;
    }
  }

  Future<User?> getUserByEmailAndPassword(String email, String password) async {
    final db = await database;

    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  void _clearFields() {
    emailController.clear();
    passwordController.clear();
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
