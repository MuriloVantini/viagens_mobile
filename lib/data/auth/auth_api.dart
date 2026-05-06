import 'package:viagens_mobile/data/api/api_client.dart';
import 'package:viagens_mobile/data/auth/auth_models.dart';

class AuthApi {
  AuthApi(this._client);

  final ApiClient _client;

  Future<LoginResponseDto> login({
    required String username,
    required String password,
  }) async {
    final json = await _client.postJson(
      '/auth/login',
      {'username': username, 'password': password},
      auth: false,
    );
    return LoginResponseDto.fromJson(json as Map<String, dynamic>);
  }

  Future<RefreshResponseDto> refresh({required String refreshToken}) async {
    final json = await _client.postJson(
      '/auth/refresh',
      {'refreshToken': refreshToken},
      auth: false,
    );
    return RefreshResponseDto.fromJson(json as Map<String, dynamic>);
  }
}
