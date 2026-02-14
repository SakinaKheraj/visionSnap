import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';
import 'package:visionsnap/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:visionsnap/features/auth/presentation/bloc/auth_event.dart';
import 'package:visionsnap/features/auth/presentation/bloc/auth_state.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_header.dart';
import 'package:visionsnap/features/auth/presentation/widgets/auth_primary_button.dart';
import 'login_screen.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onUpdatePressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        UpdatePasswordRequested(_passwordController.text),
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
          } else if (state is PasswordUpdated) {
            GlassTheme.showSnackBar(context, state.message, isError: false);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
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
                        const SizedBox(height: 60),
                        const AuthHeader(
                          tag: 'SECURITY',
                          title: 'New Password',
                          subtitle:
                              'Create a secure password to protect your account.',
                        ),
                        const SizedBox(height: 48),
                        _buildForm(isLoading),
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
            label: 'NEW PASSWORD',
            hint: '••••••••',
            prefixIcon: Icons.lock_outline_rounded,
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
                return 'Please enter a new password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          AuthTextField(
            label: 'CONFIRM PASSWORD',
            hint: '••••••••',
            prefixIcon: Icons.lock_reset_rounded,
            isPassword: _obscurePassword,
            controller: _confirmPasswordController,
            enabled: !isLoading,
            validator: (value) {
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 40),
          AuthPrimaryButton(
            text: 'Update Password',
            isLoading: isLoading,
            onPressed: _onUpdatePressed,
          ),
        ],
      ),
    );
  }
}
