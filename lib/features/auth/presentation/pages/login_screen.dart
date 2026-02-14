import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';
import 'package:visionsnap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:visionsnap/features/auth/presentation/bloc/auth_event.dart';
import 'package:visionsnap/features/auth/presentation/bloc/auth_state.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlassTheme.bgNavy,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            GlassTheme.showSnackBar(context, state.message);
          } else if (state is Authenticated) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Stack(
            children: [
              GlassTheme.meshBackground(),
              SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 30,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AuthBackButton(),
                        const SizedBox(height: 48),
                        const AuthHeader(
                          tag: 'WELCOME BACK',
                          title: 'Login to Vision',
                          subtitle:
                              'Access your scan history and saved vaults.',
                        ),
                        const SizedBox(height: 40),
                        _buildForm(isLoading),
                        const SizedBox(height: 40),
                        AuthFooter(
                          prompt: "Don't have an account?",
                          actionText: 'Create Account',
                          onAction: isLoading
                              ? null
                              : () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildForm(bool isLoading) {
    return GlassTheme.glassCard(
      child: Column(
        children: [
          AuthTextField(
            label: 'EMAIL',
            hint: 'name@example.com',
            prefixIcon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            enabled: !isLoading,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(
                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
              ).hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          AuthTextField(
            label: 'PASSWORD',
            hint: '••••••••',
            prefixIcon: Icons.lock_open_rounded,
            isPassword: _obscurePassword,
            controller: _passwordController,
            enabled: !isLoading,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white24,
                size: 18,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: isLoading
                  ? null
                  : () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswordScreen(),
                      ),
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
            isLoading: isLoading,
            onPressed: _onLoginPressed,
          ),
        ],
      ),
    );
  }
}
