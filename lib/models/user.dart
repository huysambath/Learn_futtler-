class User {
  final int id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String roleName;
  final int roleId;
  final bool isAdmin;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.roleName,
    required this.roleId,
    required this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      userName: json["user_name"],
      email: json["email"],
      roleName: json["role_name"],
      roleId: json["role_id"],
      isAdmin: json["is_admin"],
    );
  }
}