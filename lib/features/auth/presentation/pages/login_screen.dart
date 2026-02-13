import 'package:flutter/material.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_header.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_footer.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:visionsnap/features/home/presentation/pages/main_screen.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlassTheme.bgNavy,
      body: Stack(
        children: [
          GlassTheme.meshBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthBackButton(),
                  const SizedBox(height: 48),
                  const AuthHeader(
                    tag: 'WELCOME BACK',
                    title: 'Login to Vision',
                    subtitle: 'Access your scan history and saved vaults.',
                  ),
                  const SizedBox(height: 40),
                  _buildForm(),
                  const SizedBox(height: 40),
                  AuthFooter(
                    prompt: "Don't have an account?",
                    actionText: 'Create Account',
                    onAction: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const SignupScreen()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return GlassTheme.glassCard(
      child: Column(
        children: [
          const AuthTextField(
            label: 'EMAIL',
            hint: 'name@example.com',
            prefixIcon: Icons.email_outlined,
          ),
          const SizedBox(height: 20),
          AuthTextField(
            label: 'PASSWORD',
            hint: '••••••••',
            prefixIcon: Icons.lock_open_rounded,
            isPassword: !_isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.white24,
                size: 18,
              ),
              onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
              ),
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          AuthPrimaryButton(
            text: 'Login',
            onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            ),
          ),
        ],
      ),
    );
  }
}
