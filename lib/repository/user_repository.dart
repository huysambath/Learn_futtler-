import 'package:flutter_basic/models/user_create_request.dart';
import 'package:flutter_basic/models/user_update_request.dart';

import '../models/user.dart';
import '../services/user_service.dart';

class UserRepository {
  final UserService _service = UserService();

  Future<List<User>> getUsers() async {
    return await _service.getUsers();
  }

  Future<void> createUser(UserCreateRequest request) {
    return _service.createUser(request);
  }

  Future<void> updateUser(int id, UserUpdateRequest request) {
    return _service.updateUser(id, request);
  }

  Future<void> deleteUser(int id) async {
    return await _service.deleteUser(id);
  }
}
