import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GlassTheme {
  // Deep Midnight Navy Palette - Premium & Eye-pleasing
  static const Color bgNavy = Color(0xFF0A0E1A);    // Deepest midnight blue
  static const Color cardNavy = Color(0xFF151B2D);  // Subtle blue-grey for cards
  static const Color accentBlue = Color(0xFF3B82F6); // Electric Blue for accents
  static const Color glowBlue = Color(0xFF1D4ED8);  // Richer blue for glows
  static const Color textMain = Colors.white;
  static const Color textSub = Color(0xFF94A3B8);   // Muted slate for clarity

  static Widget glassCard({required Widget child, double opacity = 0.04, double blur = 25}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 1,
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
          // Top right subtle deep blue glow
          _PositionedGlow(
            top: -150, 
            right: -100, 
            color: glowBlue.withOpacity(0.12), 
            size: 500
          ),
          // Bottom left very faint glow for depth
          _PositionedGlow(
            bottom: -200, 
            left: -100, 
            color: glowBlue.withOpacity(0.08), 
            size: 600
          ),
          // Subtle radial overlay to ground the UI
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.3),
                ],
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
          boxShadow: [
            BoxShadow(
              color: color, 
              blurRadius: 120, 
              spreadRadius: 80,
            )
          ],
        ),
      ),
    );
  }
}