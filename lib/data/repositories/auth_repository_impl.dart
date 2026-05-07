import 'package:viagens_mobile/data/auth/auth_api.dart';
import 'package:viagens_mobile/data/storage/token_storage.dart';
import 'package:viagens_mobile/domain/contracts/auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  AuthRepositoryImpl({required this.authApi, required this.tokenStorage});

  final AuthApi authApi;
  final TokenStorage tokenStorage;

  @override
  Future<void> login({required String username, required String password}) async {
    final response = await authApi.login(username: username, password: password);
    await tokenStorage.saveTokens(
      accessToken: response.accessToken,
      refreshToken: response.refreshToken,
    );
  }

  @override
  Future<void> refresh() async {
    final refreshToken = await tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return;
    }
    final response = await authApi.refresh(refreshToken: refreshToken);
    await tokenStorage.saveAccessToken(response.accessToken);
  }

  @override
  Future<bool> hasSession() async {
    final token = await tokenStorage.readAccessToken();
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> clearSession() async {
    await tokenStorage.clear();
  }
}
