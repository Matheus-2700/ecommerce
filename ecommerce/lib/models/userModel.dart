class User {
  int? id;
  String name;
  String email;
  String password;
  String? avatarUrl;
  User(
      {this.id,
      required this.name,
      required this.email,
      required this.password,
      this.avatarUrl});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'avatarUrl': avatarUrl,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      avatarUrl: map['avatarUrl'],
    );
  }
}
