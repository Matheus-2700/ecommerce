class Order {
  final int id;
  final List<CartItem> items;
  final DateTime date;
  Order({
    required this.id,
    required this.items,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      // 'items': items.map((item) => item.toMap()).toList(), // Modelos de item podem ser mapeados separadamente.
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      date: DateTime.parse(map['date']), items: [],
      // items deve ser carregado através de uma consulta com o ID do pedido.
    );
  }
}

class CartItem {
  get product => null;
  get quantity => null;
}
