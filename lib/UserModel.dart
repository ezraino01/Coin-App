// class Users {
//   final String name;
//   final String email;
//   final String password;
//   final String ID;
//   final String? profileImage;
//   final String amount;
//
//   Users({
//     required this.ID,
//     required this.name,
//     required this.email,
//     required this.password,
//     this.profileImage,
//     required this.amount,
//   });
//
//   factory Users.fromMap(Map<String, dynamic> map) {
//     return Users(
//       name: map["name"] ?? '',
//       email: map["email"] ?? '',
//       password: map["password"] ?? '',
//       profileImage: map["profileImage"] ?? '',
//       ID: map["ID"] ?? '',
//       amount: map["amount"] ?? '',
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       "profileImage": profileImage ?? '',
//       "name": name,
//       "email": email,
//       "password": password,
//       "ID": ID,
//       "amount": amount,
//     };
//   }
//
//   Users copyWith({
//     String? name,
//     String? email,
//     String? password,
//     String? ID,
//     String? profileImage,
//     String? amount,
//   }) {
//     return Users(
//       ID: ID ?? this.ID,
//       name: name ?? this.name,
//       email: email ?? this.email,
//       password: password ?? this.password,
//       profileImage: profileImage ?? this.profileImage,
//       amount: amount ?? this.amount,
//     );
//   }
// }


class Users {
  final String name;
  final String email;
  final String password;
  final String ID;
  final String? profile_images;
  final String amount;

  Users({
    required this.ID,
    required this.name,
    required this.email,
    required this.password,
    this.profile_images,
    required this.amount,
  });

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map["name"] ?? '',
      email: map["email"] ?? '',
      password: map["password"] ?? '',
      profile_images: map["profile_images"] ?? '',
      ID: map["ID"] ?? '',
      amount: map["amount"] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "profile_images": profile_images ?? '',
      "name": name,
      "email": email,
      "password": password,
      "ID": ID,
      "amount": amount,
    };
  }
  Users copyWith({
    String? name,
    String? email,
    String? password,
    String? ID,
    String? profile_images,
    String? amount,
  }) {
    return Users(
      ID: ID ?? this.ID,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      profile_images: profile_images ?? this.profile_images,
      amount: amount ?? this.amount,
    );
  }
}
