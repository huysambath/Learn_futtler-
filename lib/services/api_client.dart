import 'dart:convert';
import 'package:flutter_basic/services/secure_storage_service.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final SecureStorageService _storage = SecureStorageService();
  static const String baseUrl = "http://127.0.0.1:7000/api/v1/admin";

  Future<Map<String, String>> _headers() async {
    final token = await _storage.getToken();

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<http.Response> get(String endpoint) async {
    return await http.get(
      Uri.parse("$baseUrl$endpoint"),
      headers: await _headers(),
    );
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse("$baseUrl$endpoint"),
      headers: await _headers(),
      body: jsonEncode(body),
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    return await http.put(
      Uri.parse("$baseUrl$endpoint"),
      headers: await _headers(),
      body: jsonEncode(body),
    );
  }

  Future<http.Response> delete(String endpoint) async {
    return await http.delete(
      Uri.parse("$baseUrl$endpoint"),
      headers: await _headers(),
    );
  }
}
