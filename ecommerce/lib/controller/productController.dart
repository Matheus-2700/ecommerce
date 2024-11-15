import 'package:get/get.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/helper/databaseHelper.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  // Carrega os produtos do banco de dados
  Future<void> loadProducts() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('products');
    products.value = result.map((json) => Product.fromMap(json)).toList();
  }

  // Adiciona um novo produto
  Future<void> addProduct(Product product) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('products', product.toMap());
    loadProducts();
  }

  // Atualiza um produto
  Future<void> updateProduct(Product product) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
    loadProducts();
  }

  // Deleta um produto
  Future<void> deleteProduct(int id) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    loadProducts();
  }
}
