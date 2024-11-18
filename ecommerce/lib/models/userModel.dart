class User {
  int? id; // Identificador único do usuário, pode ser null durante a criação
  String name; // Nome do usuário
  String email; // E-mail do usuário
  String password; // Senha do usuário
  String? avatarUrl; // URL do avatar do usuário, pode ser null

  // Construtor da classe User
  User({
    this.id, // ID opcional
    required this.name, // Nome obrigatório
    required this.email, // E-mail obrigatório
    required this.password, // Senha obrigatória
    this.avatarUrl, // Avatar opcional
  });

  // Converte uma instância de User para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id, // ID do usuário
      'name': name, // Nome do usuário
      'email': email, // E-mail do usuário
      'password': password, // Senha do usuário
      'avatarUrl': avatarUrl, // URL do avatar do usuário
    };
  }

  // Construtor de fábrica que cria uma instância de User a partir de um Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'], // ID do usuário
      name: map['name'], // Nome do usuário
      email: map['email'], // E-mail do usuário
      password: map['password'], // Senha do usuário
      avatarUrl: map['avatarUrl'], // URL do avatar do usuário
    );
  }
}
