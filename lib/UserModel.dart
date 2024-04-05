class Users {
  final String name;
  final String email;
  final String password;
  final String ID;
  Users({
    required this.ID,
    required this.name,
    required this.email,
    required this.password,
  });
  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
        name: map["name"],
        email: map["email"],
        password: map["password"],
        ID: map["ID"]);
  }
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "ID": ID,
    };
  }

  Users copyWith({
    String? name,
    String? email,
    String? password,
    String? ID,
  }) {
    return Users(
        ID: ID ?? this.ID,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password);
  }
}
