import 'package:flutter/material.dart';
import 'package:flutter_basic/models/user_create_request.dart';
import 'package:flutter_basic/models/user_update_request.dart';
import 'package:flutter_basic/repository/user_repository.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _repository = UserRepository();

  List<User> users = [];
  bool isLoading = false;
  String? error;

  Future<void> loadUsers() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final data = await _repository.getUsers();

      users = data;
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createUser(UserCreateRequest request) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      await _repository.createUser(request);
    } catch (e) {
      error = e.toString();
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateUser(int id, UserUpdateRequest request) async {
    try {
      isLoading = true;
      notifyListeners();

      await _repository.updateUser(id, request);

      await loadUsers();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;

      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await _repository.deleteUser(id);
      users.removeWhere((user) => user.id == id);
      notifyListeners();
    } catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }
}
