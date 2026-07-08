// import 'package:flutter/material.dart';
// import 'package:flutter_basic/models/login_request.dart';
// import 'package:flutter_basic/models/login_response.dart';
// import 'package:flutter_basic/repository/auth_repository.dart';
// import 'package:flutter_basic/services/secure_storage_service.dart';

// class AuthProvider extends ChangeNotifier {
//   final AuthRepository _authRepository = AuthRepository();
//   final SecureStorageService _storage = SecureStorageService();

//   bool _isLoading = false;
//   bool _isLoggedIn = false;

//   bool get isLoading => _isLoading;
//   bool get isLoggedIn => _isLoggedIn;

//   /// LOGIN FUNCTION
//   Future<void> login(LoginRequest request) async {
//     try {
//       _isLoading = true;
//       notifyListeners();

//       final LoginResponse response = await _authRepository.login(request);

//       // Save token
//       await _storage.saveToken(response.auth.token);

//       _isLoggedIn = true;
//     } catch (e) {
//       _isLoggedIn = false;
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   /// CHECK LOGIN (for splash screen)
//   Future<void> checkLogin() async {
//     final token = await _storage.getToken();

//     _isLoggedIn = token != null;

//     notifyListeners();
//   }

//   /// LOGOUT
//   Future<void> logout() async {
//     await _storage.deleteToken();
//     _isLoggedIn = false;
//     notifyListeners();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_basic/models/login_request.dart';
import 'package:flutter_basic/repository/auth_repository.dart';
import 'package:flutter_basic/services/secure_storage_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  final SecureStorageService _storage = SecureStorageService();

  bool _isLoading = false;
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> login(LoginRequest request) async {
    try {
      _isLoading = true;
      notifyListeners();

      final response = await _authRepository.login(request);

      await _storage.saveToken(response.auth.token);

      _isLoggedIn = true;
    } catch (e) {
      _isLoggedIn = false;
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkLogin() async {
    final token = await _storage.getToken();
    _isLoggedIn = token != null;
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.deleteToken();
    _isLoggedIn = false;
    notifyListeners();
  }
}
