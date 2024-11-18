import 'package:ecommerce/models/productModel.dart'; // Importa o modelo Product

class CartItem {
  final Product product; // Produto associado ao item no carrinho
  int quantity; // Quantidade do produto no carrinho

  // Construtor da classe CartItem
  CartItem({required this.product, this.quantity = 1});

  // Getter para o valor do item
  double get value =>
      (product.price ?? 0) *
      quantity; // Calcula o valor total do item, tratando preço nulo

  // Método que converte a instância de CartItem para um Map
  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(), // Converte o produto para um Map
      'quantity': quantity, // Quantidade do produto no carrinho
      'value': value, // Valor total do item
    };
  }

  // Construtor de fábrica que cria uma instância de CartItem a partir de um Map
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product:
          Product.fromMap(map['product']), // Constrói o produto a partir do Map
      quantity: map['quantity'] ?? 1, // Define a quantidade padrão para 1
    );
  }
}
