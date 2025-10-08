class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String role; // student, teacher, parent, admin
  final DateTime registeredDate;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.role,
    required this.registeredDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      role: json['role'],
      registeredDate: DateTime.parse(json['registeredDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'role': role,
      'registeredDate': registeredDate.toIso8601String(),
    };
  }
}
