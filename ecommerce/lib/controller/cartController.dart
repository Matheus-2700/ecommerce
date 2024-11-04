import 'package:get/get.dart';
import 'package:ecommerce/models/cartItemModel.dart';
import 'package:ecommerce/models/productModel.dart';
import 'package:ecommerce/helper/databaseHelper.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;

  // Carrega os itens do carrinho do banco de dados
  Future<void> loadCartItems() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('cart_items');
    cartItems.value = result.map((json) => CartItem.fromMap(json)).toList();
  }

  // Adiciona um item ao carrinho
  void addToCart(Product product) {
    var existingItem =
        cartItems.firstWhereOrNull((item) => item.product.id == product.id);

    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }
    // Save changes to the database as needed
  }

  // Remove um item do carrinho
  void removeFromCart(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      cartItems.remove(cartItem);
    }
    // Save changes to the database as needed
  }

  // Limpa o carrinho
  void clearCart() {
    cartItems.clear();
    // Save changes to the database as needed
  }

  // Calcula o total do carrinho
  double get totalPrice {
    return cartItems.fold(
        0, (sum, item) => sum + (item.product.price * item.quantity));
  }
}
