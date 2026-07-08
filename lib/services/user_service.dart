import 'dart:convert';
import 'package:flutter_basic/models/user.dart';
import 'package:flutter_basic/models/user_create_request.dart';
import 'package:flutter_basic/models/user_update_request.dart';
import 'api_client.dart';

class UserService {
  final ApiClient _apiClient = ApiClient();

  Future<List<User>> getUsers() async {
    final response = await _apiClient.get("/users");

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final List users = json["data"]["users"];
      return users.map((e) => User.fromJson(e)).toList();
    }

    throw Exception("Failed to load users");
  }

  Future<void> createUser(UserCreateRequest request) async {
    await _apiClient.post("/users/create", request.toJson());
  }

  Future<void> updateUser(int id, UserUpdateRequest request) async {
    final response = await _apiClient.put(
      "/users/update/$id",
      request.toJson(),
    );
    if (response.statusCode == 200) {
      return;
    }
    throw Exception(response.body);
  }

  Future<void> deleteUser(int id) async {
    final response = await _apiClient.delete("/users/delete/$id");
    if (response.statusCode != 200) {
      throw Exception("Failed to delete user");
    }
  }
}
