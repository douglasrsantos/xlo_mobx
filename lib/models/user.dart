enum UserType { PARTICULAR, PROFESSIONAL }

class User {
  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.pasword,
    this.type = UserType.PARTICULAR,
    this.createdAt,
  });

  String? id;
  String? name;
  String? email;
  String? phone;
  String? pasword;
  UserType type;
  DateTime? createdAt;

  @override
  String toString() {
    return 'User{id: $id, name: $name, email: $email, phone: $phone, pasword: $pasword, type: $type, createdAt: $createdAt}';
  }
}
