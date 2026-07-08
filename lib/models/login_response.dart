class LoginResponse {
  final bool success;
  final String message;
  final int statusCode;
  final Auth auth;

  LoginResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.auth,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final data = json["data"];
    final authJson = data is Map<String, dynamic> ? data["auth"] : json;
    return LoginResponse(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      statusCode: json["status_code"] ?? 0,
      auth: Auth.fromJson(authJson is Map<String, dynamic> ? authJson : json),
    );
  }
}

class Auth {
  final String? token;
  final String tokenType;

  Auth({this.token, required this.tokenType});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      token: json["token"] ?? "",
      tokenType: json["token_type"] ?? "",
    );
  }
}
