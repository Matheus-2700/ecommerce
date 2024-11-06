import 'package:ecommerce/helper/databaseHelper.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProducts(); // Carrega os produtos ao inicializar o controlador
  }

  // Carrega os produtos do banco de dados
  Future<void> loadProducts() async {
    try {
      final db = await DatabaseHelper.instance.database;
      final result = await db.query('products');
      products.value = result.map((json) => Product.fromMap(json)).toList();
    } catch (e) {
      print("Erro ao carregar produtos: $e");
    }
  }

  // Adiciona um novo produto
  Future<void> addProduct(Product product) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.insert('products', product.toMap());
      loadProducts();
    } catch (e) {
      print("Erro ao adicionar produto: $e");
    }
  }

  // Atualiza um produto
  Future<void> updateProduct(Product product) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.update(
        'products',
        product.toMap(),
        where: 'id = ?',
        whereArgs: [product.id],
      );
      loadProducts();
    } catch (e) {
      print("Erro ao atualizar produto: $e");
    }
  }

  // Deleta um produto
  Future<void> deleteProduct(int id) async {
    try {
      final db = await DatabaseHelper.instance.database;
      await db.delete(
        'products',
        where: 'id = ?',
        whereArgs: [id],
      );
      loadProducts();
    } catch (e) {
      print("Erro ao deletar produto: $e");
    }
  }
}
