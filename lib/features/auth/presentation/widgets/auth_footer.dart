import 'package:flutter/material.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';

class AuthFooter extends StatelessWidget {
  final String prompt;
  final String actionText;
  final VoidCallback onAction;

  const AuthFooter({
    super.key, 
    required this.prompt, 
    required this.actionText, 
    required this.onAction
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$prompt ",
            style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 13),
          ),
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionText,
              style: const TextStyle(
                color: GlassTheme.accentBlue,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
