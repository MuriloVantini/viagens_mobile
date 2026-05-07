abstract class IAuthRepository {
  Future<void> login({required String username, required String password});
  Future<void> refresh();
  Future<bool> hasSession();
  Future<void> clearSession();
}
