import 'package:get/get.dart'; // Importa a biblioteca GetX para gerenciamento de estado
import 'package:ecommerce/models/productModel.dart'; // Importa o modelo Product
import 'package:ecommerce/helper/databaseHelper.dart'; // Importa o helper do banco de dados

class ProductController extends GetxController {
  var products = <Product>[].obs; // Declara uma lista observável de produtos

  // Carrega os produtos do banco de dados
  Future<void> loadProducts() async {
    final db = await DatabaseHelper
        .instance.database; // Obtém a instância do banco de dados
    final result = await db.query('products'); // Consulta a tabela de produtos
    products.value = result
        .map((json) => Product.fromMap(json))
        .toList(); // Mapeia os resultados para uma lista de produtos
  }

  // Adiciona um novo produto
  Future<void> addProduct(Product product) async {
    final db = await DatabaseHelper
        .instance.database; // Obtém a instância do banco de dados
    await db.insert(
        'products', product.toMap()); // Insere o novo produto na tabela
    loadProducts(); // Recarrega a lista de produtos
  }

  // Atualiza um produto
  Future<void> updateProduct(Product product) async {
    final db = await DatabaseHelper
        .instance.database; // Obtém a instância do banco de dados
    await db.update(
      'products', // Nome da tabela
      product.toMap(), // Mapeia o produto para um mapa de dados
      where: 'id = ?', // Condição para encontrar o produto
      whereArgs: [product.id], // Argumentos da condição (ID do produto)
    );
    loadProducts(); // Recarrega a lista de produtos
  }

  // Deleta um produto
  Future<void> deleteProduct(int id) async {
    final db = await DatabaseHelper
        .instance.database; // Obtém a instância do banco de dados
    await db.delete(
      'products', // Nome da tabela
      where: 'id = ?', // Condição para encontrar o produto
      whereArgs: [id], // Argumentos da condição (ID do produto)
    );
    loadProducts(); // Recarrega a lista de produtos
  }
}
