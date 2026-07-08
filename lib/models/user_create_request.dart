class UserCreateRequest {
  final int? id;
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String password;
  final String roleName;
  final int roleId;
  final bool isAdmin;
  final int statusId;
  final int? createdBy;

  UserCreateRequest({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.password,
    required this.roleName,
    required this.roleId,
    required this.isAdmin,
    required this.statusId,
    this.createdBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "user_name": userName,
      "email": email,
      "password": password,
      "role_name": roleName,
      "role_id": roleId,
      "is_admin": isAdmin,
      "status_id": statusId,
      "created_by": createdBy,
    };
  }
}
