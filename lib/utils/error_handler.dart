import 'package:firebase_auth/firebase_auth.dart';

class AuthErrorHandler {
  // Firebase Auth hata kodlarını kullanıcı dostu mesajlara çevirme
  static String handleFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'Geçersiz email adresi';
      case 'user-disabled':
        return 'Kullanıcı hesabı devre dışı bırakılmış';
      case 'user-not-found':
        return 'Kullanıcı bulunamadı';
      case 'wrong-password':
        return 'Hatalı şifre';
      case 'email-already-in-use':
        return 'Bu email adresi zaten kullanımda';
      case 'operation-not-allowed':
        return 'Bu işlem şu anda kullanılamıyor';
      case 'weak-password':
        return 'Şifre çok zayıf';
      case 'network-request-failed':
        return 'İnternet bağlantısı hatası';
      case 'too-many-requests':
        return 'Çok fazla başarısız deneme. Lütfen daha sonra tekrar deneyin';
      default:
        return 'Bir hata oluştu: ${error.message}';
    }
  }

  // Genel hata mesajlarını yönetme
  static String handleGeneralError(dynamic error) {
    if (error is FirebaseAuthException) {
      return handleFirebaseAuthError(error);
    }

    if (error is FirebaseException) {
      return 'Firebase hatası: ${error.message}';
    }

    if (error is Exception) {
      return 'Uygulama hatası: ${error.toString()}';
    }

    return 'Beklenmeyen bir hata oluştu';
  }

  // Validation hatalarını yönetme
  static String handleValidationError(String field, String message) {
    return '$field: $message';
  }

  // Network hatalarını yönetme
  static String handleNetworkError() {
    return 'İnternet bağlantınızı kontrol edin';
  }

  // Timeout hatalarını yönetme
  static String handleTimeoutError() {
    return 'İşlem zaman aşımına uğradı. Lütfen tekrar deneyin';
  }

  // Custom hata mesajı oluşturma
  static String createCustomError(String message) {
    return message;
  }
}
