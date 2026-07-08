import 'package:flutter_basic/models/login_request.dart';
import 'package:flutter_basic/models/login_response.dart';
import 'package:flutter_basic/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<LoginResponse> login(LoginRequest request) async {
    return await _authService.login(request);
  }
}