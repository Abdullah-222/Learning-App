import 'dart:async';

/// Abstract base class for authentication services.
/// This allows us to switch between Mock and Real (Firebase) implementations easily.
abstract class AuthService {
  Future<bool> login(String email, String password);
  Future<bool> register(String email, String password);
  Future<void> logout();
  Future<bool> isLoggedIn();
  String? get currentUserEmail;
}

/// Mock implementation for development and testing.
class MockAuthService implements AuthService {
  String? _currentUser;

  @override
  String? get currentUserEmail => _currentUser;

  @override
  Future<bool> login(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Simple mock validation
    if (email.isNotEmpty && password.length >= 6) {
      _currentUser = email;
      return true;
    }
    return false;
  }

  @override
  Future<bool> register(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email.isNotEmpty && password.length >= 6) {
      _currentUser = email;
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  @override
  Future<bool> isLoggedIn() async {
    // For mock, we simply check if we have a user in memory.
    // In a real app, we might check secure storage or a token.
    return _currentUser != null;
  }
}
