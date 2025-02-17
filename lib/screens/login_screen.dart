import 'package:flutter/material.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../utils/validation.dart';

class LoginScreen extends StatefulWidget {
  final Future<void> Function(String email, String password)? onLogin;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onRegister;
  final String? title;
  final String? subtitle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget? logo;
  final bool showRegisterButton;
  final bool showForgotPassword;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Map<String, dynamic>? customizations;

  const LoginScreen({
    super.key,
    this.onLogin,
    this.onForgotPassword,
    this.onRegister,
    this.title = 'Hoş Geldiniz',
    this.subtitle = 'Devam etmek için giriş yapın',
    this.backgroundColor,
    this.padding,
    this.logo,
    this.showRegisterButton = true,
    this.showForgotPassword = true,
    this.titleStyle,
    this.subtitleStyle,
    this.customizations,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await widget.onLogin?.call(
        _emailController.text,
        _passwordController.text,
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
                  textInputAction: TextInputAction.done,
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
                if (widget.showForgotPassword) ...[
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: widget.onForgotPassword,
                      child: const Text('Şifremi Unuttum'),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Giriş Yap',
                  onPressed: _handleLogin,
                  isLoading: _isLoading,
                ),
                if (widget.showRegisterButton) ...[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hesabınız yok mu?',
                        style: theme.textTheme.bodyLarge,
                      ),
                      TextButton(
                        onPressed: widget.onRegister,
                        child: const Text('Kayıt Ol'),
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
