import 'package:ecommerce/const/screen/cartScreen.dart';
import 'package:ecommerce/const/screen/homeScreen.dart';
import 'package:ecommerce/const/screen/loginScreen.dart';
import 'package:ecommerce/const/screen/registerScreen.dart';
import 'package:ecommerce/controller/cartController.dart';
import 'package:ecommerce/controller/loginController.dart';
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

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    productController.loadProducts(); // Carrega os produtos

    return GetMaterialApp(
      title: 'Ecommerce',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}
