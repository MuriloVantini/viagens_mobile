import 'dart:convert';

class ApiException implements Exception {
  ApiException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';

  factory ApiException.fromResponse(int statusCode, String body) {
    String message = 'Erro inesperado.';
    if (body.isNotEmpty) {
      try {
        final decoded = jsonDecode(body);
        message = decoded['mensagem'] as String;
      } catch (_) {
        message = body;
      }
    }
    return ApiException(message, statusCode: statusCode);
  }
}
