import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter_basic/services/secure_storage_service.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final SecureStorageService _storage = SecureStorageService();
  static const String baseUrl = "http://127.0.0.1:7000/api/v1/admin";

  String get _baseUrl {
    if (Platform.isAndroid) {
      return "http://10.0.2.2:7000/api/v1/admin";
    }
    return baseUrl;
  }

  Uri get baseUri => Uri.parse(_baseUrl);

  Future<Map<String, String>> _headers() async {
    final token = await _storage.getToken();

    return {
      "Content-Type": "application/json",
      if (token != null) "Authorization": "Bearer $token",
    };
  }

  Future<http.Response> get(String endpoint) async {
    return await http.get(
      Uri.parse("$_baseUrl$endpoint"),
      headers: await _headers(),
    );
  }

  Future<http.Response> getUri(Uri uri) async {
    return await http.get(uri, headers: await _headers());
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    return await http.post(
      Uri.parse("$_baseUrl$endpoint"),
      headers: await _headers(),
      body: jsonEncode(body),
    );
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    return await http.put(
      Uri.parse("$_baseUrl$endpoint"),
      headers: await _headers(),
      body: jsonEncode(body),
    );
  }

  Future<http.Response> delete(String endpoint) async {
    return await http.delete(
      Uri.parse("$_baseUrl$endpoint"),
      headers: await _headers(),
    );
  }
}
