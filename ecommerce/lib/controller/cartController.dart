import 'package:get/get.dart';

class CartController extends GetxController {
  // Especificação do tipo para o RxMap
  var cartItems = <String, int>{}.obs; // Mapa de produtos e suas quantidades
  final productPrices = {
    'Beijinho': 1.50,
    'Brigadeiro': 1.30,
    'Casadinho': 1.80,
    'Coco': 1.60,
    'Damasco': 2.00,
    'Nutela': 2.50,
  };

  // Adicionar item ao carrinho
  void addToCart(String productName) {
    if (cartItems.containsKey(productName)) {
      cartItems[productName] = cartItems[productName]! + 1;
    } else {
      cartItems[productName] = 1;
    }
  }

  // Remover item (diminuir quantidade ou excluir completamente)
  void removeFromCart(String productName) {
    if (cartItems.containsKey(productName) && cartItems[productName]! > 1) {
      cartItems[productName] = cartItems[productName]! - 1;
    } else {
      cartItems.remove(productName);
    }
  }

  // Remover item completamente
  void removeItem(String productName) {
    cartItems.remove(productName);
  }

  // Limpar o carrinho
  void clearCart() {
    cartItems.clear();
  }

  // Calcular o preço total do carrinho
  double get totalPrice {
    return cartItems.entries.fold(0.0, (sum, entry) {
      final productName = entry.key;
      final quantity = entry.value;

      // Verificar se o preço existe para o produto
      final price = productPrices[productName] ??
          0.0; // Garantir que o preço nunca seja nulo

      return sum + (price * quantity); // Soma o preço total
    });
  }
}
