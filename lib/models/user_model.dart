class UserModel {
  String? id;
  String? name;
  String? regno;
  String? department;
  String? email;
  String? role;

  UserModel({
    this.id,
    this.name,
    this.regno,
    this.department,
    this.email,
    this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      name: json['name'],
      regno: json['regno'],
      department: json['department'],
      email: json['email'],
      role: json['password'],
    );
  }
}
