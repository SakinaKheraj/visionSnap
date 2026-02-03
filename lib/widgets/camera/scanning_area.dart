import 'package:flutter/material.dart';
import '../../core/theme/glass_theme.dart';

class ScanningArea extends StatelessWidget {
  final Animation<double> scanLineAnimation;

  const ScanningArea({
    super.key,
    required this.scanLineAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      height: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Stack(
        children: [
          // Corner Brackets
          _buildCorner(0, 0),
          _buildCorner(1, 0),
          _buildCorner(0, 1),
          _buildCorner(1, 1),

          // Scanning Line
          AnimatedBuilder(
            animation: scanLineAnimation,
            builder: (context, child) {
              return Positioned(
                top: 380 * scanLineAnimation.value,
                left: 20,
                right: 20,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: GlassTheme.accentBlue,
                    boxShadow: [
                      BoxShadow(
                        color: GlassTheme.accentBlue.withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCorner(int x, int y) {
    return Positioned(
      top: y == 0 ? 0 : null,
      bottom: y == 1 ? 0 : null,
      left: x == 0 ? 0 : null,
      right: x == 1 ? 0 : null,
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          border: Border(
            top: y == 0 ? const BorderSide(color: GlassTheme.accentBlue, width: 4) : BorderSide.none,
            bottom: y == 1 ? const BorderSide(color: GlassTheme.accentBlue, width: 4) : BorderSide.none,
            left: x == 0 ? const BorderSide(color: GlassTheme.accentBlue, width: 4) : BorderSide.none,
            right: x == 1 ? const BorderSide(color: GlassTheme.accentBlue, width: 4) : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
