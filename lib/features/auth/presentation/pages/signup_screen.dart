import 'package:flutter/material.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_header.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_footer.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_back_button.dart';
import 'package:visionsnap/features/home/presentation/pages/main_screen.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
                  const SizedBox(height: 32),
                  const AuthHeader(
                    tag: 'GET STARTED',
                    title: 'Join Vision',
                    subtitle: 'Create an account to identify objects instantly.',
                  ),
                  const SizedBox(height: 32),
                  _buildForm(),
                  const SizedBox(height: 40),
                  AuthFooter(
                    prompt: "Already a member?",
                    actionText: 'Login',
                    onAction: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
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
            label: 'FULL NAME',
            hint: 'E.g. John Doe',
            prefixIcon: Icons.person_outline_rounded,
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 32),
          AuthPrimaryButton(
            text: 'Create Account',
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
