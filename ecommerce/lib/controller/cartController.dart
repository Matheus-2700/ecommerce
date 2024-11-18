import 'package:get/get.dart'; // Importa a biblioteca GetX para gerenciamento de estado

class CartController extends GetxController {
  // Especificação do tipo para o RxMap
  var cartItems =
      <String, int>{}.obs; // Mapa observável de produtos e suas quantidades
  final productPrices = {
    'Beijinho': 1.50, // Preço do Beijinho
    'Brigadeiro': 1.30, // Preço do Brigadeiro
    'Casadinho': 1.80, // Preço do Casadinho
    'Coco': 1.60, // Preço do Coco
    'Damasco': 2.00, // Preço do Damasco
    'Nutela': 2.50, // Preço do Nutela
  };

  // Adicionar item ao carrinho
  void addToCart(String productName) {
    if (cartItems.containsKey(productName)) {
      cartItems[productName] =
          cartItems[productName]! + 1; // Incrementa a quantidade do produto
    } else {
      cartItems[productName] =
          1; // Adiciona o produto com quantidade 1 se não existir
    }
  }

  // Remover item (diminuir quantidade ou excluir completamente)
  void removeFromCart(String productName) {
    if (cartItems.containsKey(productName) && cartItems[productName]! > 1) {
      cartItems[productName] =
          cartItems[productName]! - 1; // Decrementa a quantidade do produto
    } else {
      cartItems.remove(
          productName); // Remove o produto do carrinho se a quantidade for 1
    }
  }

  // Remover item completamente
  void removeItem(String productName) {
    cartItems.remove(productName); // Remove o produto do carrinho
  }

  // Limpar o carrinho
  void clearCart() {
    cartItems.clear(); // Remove todos os itens do carrinho
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
