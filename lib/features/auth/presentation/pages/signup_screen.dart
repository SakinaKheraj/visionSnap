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
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignupPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        RegisterRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullname: _fullnameController.text.trim(),
          username: _emailController.text.split('@')[0],
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
                        const SizedBox(height: 32),
                        const AuthHeader(
                          tag: 'GET STARTED',
                          title: 'Join Vision',
                          subtitle:
                              'Create an account to identify objects instantly.',
                        ),
                        const SizedBox(height: 32),
                        _buildForm(isLoading),
                        const SizedBox(height: 40),
                        AuthFooter(
                          prompt: "Already a member?",
                          actionText: 'Login',
                          onAction: isLoading
                              ? null
                              : () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
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
            label: 'FULL NAME',
            hint: 'E.g. John Doe',
            prefixIcon: Icons.person_outline_rounded,
            controller: _fullnameController,
            enabled: !isLoading,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your full name';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 32),
          AuthPrimaryButton(
            text: 'Create Account',
            isLoading: isLoading,
            onPressed: _onSignupPressed,
          ),
        ],
      ),
    );
  }
}
