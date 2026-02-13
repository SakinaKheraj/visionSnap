import 'package:flutter/material.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_header.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_primary_button.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_footer.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_back_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
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
                  const SizedBox(height: 60),
                  const AuthHeader(
                    tag: 'RECOVERY',
                    title: 'Reset Password',
                    subtitle: 'Enter your email to receive recovery instructions.',
                  ),
                  const SizedBox(height: 48),
                  _buildForm(),
                  const SizedBox(height: 40),
                  AuthFooter(
                    prompt: "Remember your password?",
                    actionText: 'Login',
                    onAction: () => Navigator.pop(context),
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
            prefixIcon: Icons.alternate_email_rounded,
          ),
          const SizedBox(height: 40),
          AuthPrimaryButton(
            text: 'Send Instructions',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Recovery instructions sent.')),
              );
            },
          ),
        ],
      ),
    );
  }
}
