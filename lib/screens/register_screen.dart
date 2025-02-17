import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../utils/validation.dart';

class RegisterScreen extends StatefulWidget {
  final Future<void> Function(String email, String password, String name)? onRegister;
  final VoidCallback? onLogin;
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget? logo;
  final bool showLoginButton;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Map<String, dynamic>? customizations;

  const RegisterScreen({
    super.key,
    this.onRegister,
    this.onLogin,
    this.title = 'Kayıt Ol',
    this.subtitle = 'Yeni bir hesap oluşturun',
    this.backgroundColor,
    this.padding,
    this.logo,
    this.showLoginButton = true,
    this.titleStyle,
    this.subtitleStyle,
    this.customizations,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await widget.onRegister?.call(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: widget.backgroundColor ?? theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (widget.logo != null) ...[
                  widget.logo!,
                  const SizedBox(height: 32),
                ],
                Text(
                  widget.title!,
                  style: widget.titleStyle ??
                      theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (widget.subtitle != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitle!,
                    style: widget.subtitleStyle ?? theme.textTheme.bodyLarge,
                  ),
                ],
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _nameController,
                  label: 'Ad Soyad',
                  hint: 'John Doe',
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  validator: ValidationUtils.validateName,
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'example@email.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: ValidationUtils.validateEmail,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Şifre',
                  hint: '********',
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
                  validator: ValidationUtils.validatePassword,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Şifre Tekrar',
                  hint: '********',
                  obscureText: _obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  validator: (value) => ValidationUtils.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() =>
                          _obscureConfirmPassword = !_obscureConfirmPassword);
                    },
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Kayıt Ol',
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                ),
                if (widget.showLoginButton) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Zaten hesabınız var mı?',
                        style: theme.textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: widget.onLogin,
                        child: const Text('Giriş Yap'),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
