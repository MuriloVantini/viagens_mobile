import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:viagens_mobile/data/api/api_exception.dart';
import 'package:viagens_mobile/data/storage/token_storage.dart';

class ApiClient {
  ApiClient({required this.baseUrl, required this.tokenStorage, http.Client? client}) : _client = client ?? http.Client();

  final String baseUrl;
  final TokenStorage tokenStorage;
  final http.Client _client;

  Future<Map<String, String>> _headers({required bool auth}) async {
    final headers = <String, String>{'Content-Type': 'application/json', 'Accept': 'application/json'};
    if (auth) {
      final token = await tokenStorage.readAccessToken();
      if (token != null && token.isNotEmpty) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<dynamic> getJson(String path, {bool auth = true}) async {
    final response = await _client.get(_uri(path), headers: await _headers(auth: auth));
    return _handleResponse(response);
  }

  Future<dynamic> postJson(String path, Map<String, dynamic> body, {bool auth = true}) async {
    final response = await _client.post(
      _uri(path),
      headers: await _headers(auth: auth),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> patchJson(String path, Map<String, dynamic> body, {bool auth = true}) async {
    final response = await _client.patch(
      _uri(path),
      headers: await _headers(auth: auth),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return null;
      }
      return jsonDecode(response.body);
    }
    throw ApiException.fromResponse(response.statusCode, response.body);
  }
}
