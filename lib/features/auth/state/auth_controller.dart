import 'package:flutter/foundation.dart';
import 'package:viagens_mobile/data/api/api_exception.dart';
import 'package:viagens_mobile/domain/contracts/auth_repository.dart';

class AuthController extends ChangeNotifier {
  AuthController({required this.authRepository});

  final IAuthRepository authRepository;

  bool _isInitialized = false;
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;

  bool get isInitialized => _isInitialized;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> initialize() async {
    if (_isInitialized) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      _isAuthenticated = await authRepository.hasSession();
    } finally {
      _isLoading = false;
      _isInitialized = true;
      notifyListeners();
    }
  }

  Future<bool> login({required String username, required String password}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      await authRepository.login(username: username, password: password);
      _isAuthenticated = true;
      return true;
    } catch (error) {
      if (error is ApiException) {
        _error = error.message;
      } else {
        _error = 'Falha ao autenticar';
      }
      _isAuthenticated = false;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await authRepository.clearSession();
    _isAuthenticated = false;
    notifyListeners();
  }
}
