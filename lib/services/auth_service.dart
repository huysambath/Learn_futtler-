import 'dart:convert';
import 'package:flutter_basic/models/login_request.dart';
import 'package:flutter_basic/models/login_response.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<LoginResponse> login(LoginRequest request) async {
    final response = await _apiClient.post("/auth/login", request.toJson());

    if (response.statusCode == 200) {
      return LoginResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception("Login Failed (status: ${response.statusCode})");
  }
}
