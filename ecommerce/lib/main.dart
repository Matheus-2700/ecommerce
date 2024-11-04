import 'package:ecommerce/const/screen/homeScreen.dart';
import 'package:ecommerce/const/screen/loginScreen.dart';
import 'package:ecommerce/const/screen/registerScreen.dart';
import 'package:ecommerce/controller/productController.dart';
import 'package:ecommerce/controller/cartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ecommerce',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => HomeScreen(), // Use a classe HomeScreen aqui
      },
    );
  }
}
