import 'package:ecommerce/models/productModel.dart'; // Verifique se o caminho está correto

class CartItem {
  final Product product; // Produto associado ao item no carrinho
  int quantity; // Quantidade do produto no carrinho

  // Construtor da classe CartItem
  CartItem({required this.product, this.quantity = 1}) {
    if (quantity < 1) {
      throw ArgumentError(
          "A quantidade inicial não pode ser menor que 1."); // Garante que a quantidade inicial seja pelo menos 1
    }
  }

  // Getter para calcular o valor total do item (preço unitário * quantidade)
  double get value => product.price * quantity;

  // Método que converte a instância de CartItem para um Map
  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(), // Converte o produto para um Map
      'quantity': quantity, // Quantidade do produto no carrinho
      'value': value, // Inclui o valor total no mapa
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

  get price =>
      null; // Propriedade não implementada, potencial para melhorias futuras
  String? get name =>
      null; // Propriedade não implementada, potencial para melhorias futuras
}
