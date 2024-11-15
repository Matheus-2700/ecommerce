class Product {
  final int? id;
  final String name;
  final double price;
  final String?
      imagePath; // Adiciona o caminho da imagem como um campo opcional

  Product({this.id, required this.name, required this.price, this.imagePath});

  // Atualize o método fromMap se estiver usando o SQLite
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      imagePath:
          map['imagePath'], // Certifique-se de salvar o caminho da imagem
    );
  }

  String? get description => null;

  // Atualize o método toMap se estiver usando o SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath, // Certifique-se de salvar o caminho da imagem
    };
  }
}
