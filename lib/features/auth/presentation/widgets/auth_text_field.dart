import 'package:flutter/material.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool enabled;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.enabled = true,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _isFocused
                  ? GlassTheme.accentBlue
                  : Colors.white.withOpacity(0.3),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Focus(
          onFocusChange: (focus) => setState(() => _isFocused = focus),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword,
            validator: widget.validator,
            keyboardType: widget.keyboardType,
            enabled: widget.enabled,
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: _isFocused
                  ? Colors.white.withOpacity(0.05)
                  : Colors.white.withOpacity(0.02),
              hintText: widget.hint,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.15),
                fontSize: 14,
              ),
              prefixIcon: Icon(
                widget.prefixIcon,
                color: _isFocused
                    ? GlassTheme.accentBlue
                    : Colors.white.withOpacity(0.2),
                size: 20,
              ),
              suffixIcon: widget.suffixIcon,
              contentPadding: const EdgeInsets.all(18),
              // Default Border
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
              ),
              // Focused Border
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: GlassTheme.accentBlue,
                  width: 1.2,
                ),
              ),
              // Error Border
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Colors.redAccent.withOpacity(0.5),
                ),
              ),
              // Focused Error Border
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.2,
                ),
              ),
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
