import 'package:flutter_basic/models/user_create_request.dart';
import 'package:flutter_basic/models/user_update_request.dart';

import '../models/user.dart';
import '../services/user_service.dart';

class UserRepository {
  final UserService _service = UserService();
  
  Future<List<User>> getUsers({
    int page = 1,
    int perPage = 10,
    String? search,
  }) {
    return _service.getUsers(page: page, perPage: perPage, search: search);
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
