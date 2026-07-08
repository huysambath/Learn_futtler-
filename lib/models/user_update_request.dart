class UserUpdateRequest {
  final String firstName;
  final String lastName;
  final String userName;
  final String email;
  final String roleName;
  final int roleId;
  final int statusId;

  UserUpdateRequest({
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.roleName,
    required this.roleId,
    required this.statusId,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "user_name": userName,
      "email": email,
      "role_name": roleName,
      "role_id": roleId,
      "status_id": statusId,
    };
  }
}
