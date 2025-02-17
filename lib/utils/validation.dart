class ValidationUtils {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email alanı boş bırakılamaz';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Geçerli bir email adresi giriniz';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre alanı boş bırakılamaz';
    }

    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }

    // En az bir büyük harf
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Şifre en az bir büyük harf içermelidir';
    }

    // En az bir küçük harf
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Şifre en az bir küçük harf içermelidir';
    }

    // En az bir rakam
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Şifre en az bir rakam içermelidir';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Şifre tekrar alanı boş bırakılamaz';
    }

    if (value != password) {
      return 'Şifreler eşleşmiyor';
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'İsim alanı boş bırakılamaz';
    }

    if (value.length < 2) {
      return 'İsim en az 2 karakter olmalıdır';
    }

    return null;
  }

  // Custom validation rule ekleme imkanı
  static String? Function(String?) createCustomRule({
    required String errorMessage,
    required bool Function(String value) validator,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Bu alan boş bırakılamaz';
      }

      if (!validator(value)) {
        return errorMessage;
      }

      return null;
    };
  }
}
