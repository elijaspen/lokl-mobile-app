enum UserRole {
  customer,
  rider,
  admin,
}

class UserModel {
  final int id;
  final String name;
  final String email;
  final UserRole role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: _parseRole(json['role']),
    );
  }

  static UserRole _parseRole(String role) {
    switch (role) {
      case 'admin': return UserRole.admin;
      case 'rider': return UserRole.rider;
      default: return UserRole.customer;
    }
  }
}
