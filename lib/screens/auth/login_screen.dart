import 'package:flutter/material.dart';
import '../../core/theme/glass_theme.dart';
import '../../widgets/auth/auth_text_field.dart';
import '../main_screen.dart';
import 'signup_screen.dart';

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
      body: Stack(
        children: [
          GlassTheme.meshBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
              child: Column(
                children: [
                  // App Logo/Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: GlassTheme.accentBlue,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: GlassTheme.accentBlue.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: const Icon(Icons.crop_free_rounded, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'VisionSnap',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Text(
                    'Identify anything. Shop everything.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Login Card
                  GlassTheme.glassCard(
                    opacity: 0.05,
                    child: Column(
                      children: [
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const AuthTextField(
                          label: 'Email Address',
                          hint: 'hello@example.com',
                          prefixIcon: Icons.alternate_email_rounded,
                        ),
                        const SizedBox(height: 14),
                        AuthTextField(
                          label: 'Password',
                          hint: '••••••••',
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: !_isPasswordVisible,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white38,
                              size: 20,
                            ),
                            onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: GlassTheme.accentBlue, fontSize: 13),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        _buildPrimaryButton(context),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Footer Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white54),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupScreen()),
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: GlassTheme.accentBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  
                  // Terms & Privacy
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSmallLink('PRIVACY'),
                      _buildDot(),
                      _buildSmallLink('TERMS'),
                      _buildDot(),
                      _buildSmallLink('HELP'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            GlassTheme.accentBlue,
            GlassTheme.accentBlue.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: GlassTheme.accentBlue.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const MainScreen()),
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Log In',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.login_rounded, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallLink(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
        color: Colors.white.withOpacity(0.4),
      ),
    );
  }

  Widget _buildDot() {
    return Container(
      width: 4,
      height: 4,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: Colors.white24,
        shape: BoxShape.circle,
      ),
    );
  }
}
