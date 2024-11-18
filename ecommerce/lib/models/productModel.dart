class Product {
  final int?
      id; // Identificador único do produto, pode ser null durante a criação
  final String name; // Nome do produto
  final double price; // Preço do produto
  final String? imagePath; // Caminho da imagem do produto, pode ser null

  // Construtor da classe Product
  Product({
    this.id, // ID opcional
    required this.name, // Nome obrigatório
    required this.price, // Preço obrigatório
    this.imagePath, // Caminho da imagem opcional
  });

  // Construtor de fábrica que cria uma instância de Product a partir de um Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'], // ID do produto
      name: map['name'], // Nome do produto
      price: map['price'], // Preço do produto
      imagePath: map['imagePath'], // Caminho da imagem do produto
    );
  }

  String? get description =>
      null; // Propriedade que retorna null, potencial para melhorias futuras

  // Converte uma instância de Product para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ID do produto
      'name': name, // Nome do produto
      'price': price, // Preço do produto
      'imagePath': imagePath, // Caminho da imagem do produto
    };
  }
}
