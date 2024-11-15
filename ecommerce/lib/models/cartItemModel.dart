import 'package:ecommerce/models/productModel.dart'; // Verifique se o caminho está correto

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1}) {
    if (quantity < 1) {
      throw ArgumentError("A quantidade inicial não pode ser menor que 1.");
    }
  }

  // Getter para calcular o valor total do item (preço unitário * quantidade)
  double get value => product.price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'quantity': quantity,
      'value': value, // Inclui o valor total no mapa
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map['product']),
      quantity: map['quantity'] ?? 1, // Define a quantidade padrão para 1
    );
  }

  get price => null;

  String? get name => null;
}
