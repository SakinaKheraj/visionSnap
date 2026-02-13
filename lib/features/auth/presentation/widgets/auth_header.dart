import 'package:flutter/material.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';

class AuthHeader extends StatelessWidget {
  final String tag;
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key, 
    required this.tag, 
    required this.title, 
    required this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          tag,
          style: TextStyle(
            color: GlassTheme.accentBlue,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.0,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}
