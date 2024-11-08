import 'package:app_smartkho/data/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService = AuthService();

  Future<Map<String, dynamic>?> login(String email, String password) {
    return _authService.login(email, password);
  }
}
