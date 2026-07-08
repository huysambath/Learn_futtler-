import 'dart:convert';
import 'package:flutter_basic/models/user.dart';
import 'package:flutter_basic/models/user_create_request.dart';
import 'package:flutter_basic/models/user_update_request.dart';
import 'api_client.dart';

class UserService {
  final ApiClient _apiClient = ApiClient();

  Future<List<User>> getUsers({
    int page = 1,
    int perPage = 10,
    String? search,
  }) async {
    String endpoint = "/users?paging_options[page]=$page&paging_options[per_page]=$perPage";

    if (search != null && search.isNotEmpty) {
      endpoint += "&filters[0][property]=u.user_name&filters[0][value]=${Uri.encodeQueryComponent('%$search%')}";
    }

    final response = await _apiClient.get(endpoint);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final users = json["data"]["users"] as List? ?? [];

      return users.map((e) => User.fromJson(e)).toList();
    }

    throw Exception("Failed to load users (${response.statusCode}): ${response.body}");
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
