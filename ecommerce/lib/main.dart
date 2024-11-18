import 'package:ecommerce/const/screen/homeScreen.dart'; // Importa a tela principal
import 'package:ecommerce/const/screen/loginScreen.dart'; // Importa a tela de login
import 'package:ecommerce/const/screen/registerScreen.dart'; // Importa a tela de registro
import 'package:ecommerce/controller/productController.dart'; // Importa o controlador de produtos
import 'package:ecommerce/controller/cartController.dart'; // Importa o controlador de carrinho
import 'package:flutter/material.dart'; // Importa os widgets principais do Flutter
import 'package:get/get.dart'; // Importa o GetX para gerenciamento de estado e navegação
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; // Importa a biblioteca sqflite para bancos de dados

void main() {
  sqfliteFfiInit(); // Inicializa o sqflite para ambientes desktop
  databaseFactory =
      databaseFactoryFfi; // Configura o factory do banco de dados para sqflite_common_ffi
  runApp(MyApp()); // Executa o aplicativo MyApp
}

class MyApp extends StatelessWidget {
  final ProductController productController = Get.put(
      ProductController()); // Inicializa o controlador de produtos e o coloca no sistema de injeção de dependência do GetX
  final CartController cartController = Get.put(
      CartController()); // Inicializa o controlador de carrinho e o coloca no sistema de injeção de dependência do GetX

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ecommerce', // Define o título do aplicativo
      theme:
          ThemeData(primarySwatch: Colors.blue), // Define o tema do aplicativo
      initialRoute: '/', // Define a rota inicial
      routes: {
        '/': (context) =>
            const LoginScreen(), // Define a rota para a tela de login
        '/register': (context) =>
            const RegisterScreen(), // Define a rota para a tela de registro
        '/home': (context) =>
            HomeScreen(), // Define a rota para a tela principal
      },
    );
  }
}
