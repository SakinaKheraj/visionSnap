import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GlassTheme {
  // Deep Navy Modern Palette
  static const Color bgNavy = Color(0xFF0D111F);
  static const Color accentBlue = Color(0xFF3B82F6);
  static const Color cardNavy = Color(0xFF1E293B);
  static const Color textMain = Colors.white;
  static const Color textSub = Color(0xFF94A3B8);

  static Widget glassCard({required Widget child, double opacity = 0.1, double blur = 20}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(opacity + 0.05),
                Colors.white.withOpacity(opacity),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  static Widget meshBackground() {
    return Container(
      color: bgNavy,
      child: Stack(
        children: [
          // Top right subtle glow
          _PositionedGlow(top: -100, right: -50, color: accentBlue.withOpacity(0.15), size: 400),
          // Bottom left subtle glow
          _PositionedGlow(bottom: -150, left: -50, color: accentBlue.withOpacity(0.1), size: 500),
          // Subtle radial vignette
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PositionedGlow extends StatelessWidget {
  final double? top, bottom, left, right;
  final Color color;
  final double size;
  const _PositionedGlow({this.top, this.bottom, this.left, this.right, required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top, bottom: bottom, left: left, right: right,
      child: Container(
        width: size, height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: color, blurRadius: 100, spreadRadius: 50)],
        ),
      ),
    );
  }
}