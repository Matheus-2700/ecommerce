import 'package:ecommerce/models/productModel.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toMap() {
    return {
      'product_id': product.id,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product(
        id: map['product_id'],
        name: map[
            'product_name'], // Certifique-se de que essas chaves existem no seu banco de dados
        price: map['product_price'], description: '', imageUrl: '',
      ),
      quantity: map['quantity'],
    );
  }
}
