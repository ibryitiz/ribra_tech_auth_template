library ribra_tech_auth_template;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ribra_tech_auth_template/services/auth_service.dart';
import 'package:ribra_tech_auth_template/utils/error_handler.dart';

// Screens
export 'screens/login_screen.dart';
export 'screens/register_screen.dart';

// Components
export 'components/custom_button.dart';
export 'components/custom_textfield.dart';

// Utils
export 'utils/validation.dart';
export 'utils/error_handler.dart';

/// RibraTechAuth sınıfı, authentication işlemlerini yönetir
class RibraTechAuth {
  final AuthService _authService;

  RibraTechAuth({AuthService? authService})
      : _authService = authService ?? AuthService();

  /// Kullanıcı oturum durumu stream'i
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  /// Email/Password ile giriş yapma
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _authService.signInWithEmail(
        email: email,
        password: password,
      );
    } catch (e) {
      throw AuthErrorHandler.handleGeneralError(e);
    }
  }

  /// Email/Password ile kayıt olma
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _authService.signUpWithEmail(
        email: email,
        password: password,
      );
    } catch (e) {
      throw AuthErrorHandler.handleGeneralError(e);
    }
  }

  /// Şifre sıfırlama emaili gönderme
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw AuthErrorHandler.handleGeneralError(e);
    }
  }

  /// Çıkış yapma
  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      throw AuthErrorHandler.handleGeneralError(e);
    }
  }
}

