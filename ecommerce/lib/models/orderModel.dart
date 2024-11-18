class Order {
  final int id; // Identificador único do pedido
  final List<CartItem> items; // Lista de itens no carrinho associados ao pedido
  final DateTime date; // Data em que o pedido foi realizado

  // Construtor da classe Order
  Order({
    required this.id, // ID obrigatório
    required this.items, // Lista de itens obrigatória
    required this.date, // Data obrigatória
  });

  // Método que converte a instância de Order para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ID do pedido
      'date': date.toIso8601String(), // Data do pedido no formato ISO8601
      // 'items': items.map((item) => item.toMap()).toList(), // Modelos de item podem ser mapeados separadamente.
    };
  }

  // Construtor de fábrica que cria uma instância de Order a partir de um Map
  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'], // ID do pedido
      date: DateTime.parse(map['date']), // Data do pedido
      items: [], // items deve ser carregado através de uma consulta com o ID do pedido
    );
  }
}

class CartItem {
  get product => null; // Produto associado ao item no carrinho
  get quantity => null; // Quantidade do produto no carrinho
}
