class Cart {
  final int id;
  final int productId;

  Cart({
    required this.id,
    required this.productId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'Id_Produto': productId,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] ?? 0,
      productId: map['productId'] ?? 0,
    );
  }
}
