class Cart {
  final int id; // Identificador único do carrinho
  final int productId; // Identificador do produto associado ao carrinho

  // Construtor da classe Cart
  Cart({
    required this.id, // ID obrigatório
    required this.productId, // ID do produto obrigatório
  });

  // Método que converte a instância de Cart para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ID do carrinho
      'Id_Produto': productId, // ID do produto no carrinho
    };
  }

  // Construtor de fábrica que cria uma instância de Cart a partir de um Map
  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      id: map['id'] ?? 0, // ID do carrinho (padrão 0 se não encontrado)
      productId:
          map['productId'] ?? 0, // ID do produto (padrão 0 se não encontrado)
    );
  }
}
