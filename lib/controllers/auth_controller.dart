import 'package:flutter/foundation.dart';
import 'package:secure_learning_app/services/auth_service.dart';

class AuthController with ChangeNotifier {
  final AuthService _authService;

  AuthController(this._authService);

  bool _isLoading = false;
  String? _errorMessage;
  bool _isAuthenticated = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _isAuthenticated;
  String? get userEmail => _authService.currentUserEmail;

  Future<void> checkAuthStatus() async {
    _isAuthenticated = await _authService.isLoggedIn();
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final success = await _authService.login(email, password);
      if (success) {
        _isAuthenticated = true;
      } else {
        _errorMessage = 'Invalid email or password';
      }
      return success;
    } catch (e) {
      _errorMessage = 'An error occurred during login';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register(String email, String password) async {
    _setLoading(true);
    _clearError();

    try {
      final success = await _authService.register(email, password);
      if (success) {
        _isAuthenticated = true;
      } else {
        _errorMessage = 'Registration failed. Please try again.';
      }
      return success;
    } catch (e) {
      _errorMessage = 'An error occurred during registration';
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
