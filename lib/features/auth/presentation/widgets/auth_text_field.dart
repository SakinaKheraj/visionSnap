import 'package:flutter/material.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';

class AuthTextField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? suffixIcon;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    this.isPassword = false,
    this.controller,
    this.suffixIcon,
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
              color: _isFocused ? GlassTheme.accentBlue : Colors.white.withOpacity(0.3),
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _isFocused ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.02),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isFocused ? GlassTheme.accentBlue.withOpacity(0.4) : Colors.white.withOpacity(0.05),
              width: 1.0,
            ),
          ),
          child: Focus(
            onFocusChange: (focus) => setState(() => _isFocused = focus),
            child: TextField(
              controller: widget.controller,
              obscureText: widget.isPassword,
              cursorColor: Colors.white,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.15), fontSize: 14),
                prefixIcon: Icon(
                  widget.prefixIcon, 
                  color: _isFocused ? GlassTheme.accentBlue : Colors.white.withOpacity(0.2), 
                  size: 20,
                ),
                suffixIcon: widget.suffixIcon,
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
