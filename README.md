<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Ribra Tech Auth Template

Modern, özelleştirilebilir ve kullanımı kolay bir Firebase Authentication paketi.

## Özellikler

- 🎨 Tamamen özelleştirilebilir UI bileşenleri
- 🔒 Firebase Authentication entegrasyonu
- ✨ Modern ve minimalist tasarım
- 📱 Responsive yapı
- ✅ Form validasyonları
- ❌ Merkezi hata yönetimi
- 🔄 Loading states
- 🎯 Callback-based yapı

## Kurulum

Paketi projenize eklemek için iki yol var:

### 1. GitHub üzerinden kurulum (Önerilen)

```yaml
dependencies:
  ribra_tech_auth_template:
    git:
      url: https://github.com/ibryitiz/ribra_tech_auth_template.git
      ref: v0.0.1  # Spesifik versiyon için
      # veya
      ref: main    # En son güncellemeler için
```

### 2. Local path üzerinden kurulum (Geliştirme için)

```yaml
dependencies:
  ribra_tech_auth_template:
    path: ../ribra_tech_auth_template
```

### Gerekli Bağımlılıklar
```yaml
dependencies:
  firebase_core: ^3.11.0
  firebase_auth: ^5.4.2
```

## Kullanım

### 1. Firebase Kurulumu

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

### 2. Login Ekranı

```dart
LoginScreen(
  onLogin: (email, password) async {
    try {
      await auth.signInWithEmail(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  },
  onForgotPassword: () {
    // Handle forgot password
  },
  onRegister: () {
    // Navigate to register
  },
  // Özelleştirmeler
  logo: Image.asset('assets/logo.png'),
  backgroundColor: Colors.white,
  title: 'Hoş Geldiniz',
  subtitle: 'Devam etmek için giriş yapın',
);
```

### 3. Register Ekranı

```dart
RegisterScreen(
  onRegister: (email, password, name) async {
    try {
      await auth.signUpWithEmail(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
  },
  onLogin: () {
    // Navigate to login
  },
  // Özelleştirmeler
  logo: Image.asset('assets/logo.png'),
  backgroundColor: Colors.white,
  title: 'Kayıt Ol',
  subtitle: 'Yeni bir hesap oluşturun',
);
```

## Özelleştirme

### UI Bileşenleri

```dart
CustomButton(
  text: 'Giriş Yap',
  onPressed: () {},
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  borderRadius: 8,
  prefix: Icon(Icons.login),
  isLoading: false,
);

CustomTextField(
  label: 'Email',
  hint: 'example@email.com',
  prefixIcon: Icon(Icons.email),
  validator: ValidationUtils.validateEmail,
  borderRadius: 8,
);
```

### Validation

```dart
// Custom validation rule ekleme
String? customValidator = ValidationUtils.createCustomRule(
  errorMessage: 'Geçersiz değer',
  validator: (value) => value.length > 3,
);
```

### Hata Yönetimi

```dart
try {
  await auth.signInWithEmail(email: email, password: password);
} catch (e) {
  final errorMessage = AuthErrorHandler.handleGeneralError(e);
  showError(errorMessage);
}
```

## Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için [LICENSE](LICENSE) dosyasına bakın.

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
