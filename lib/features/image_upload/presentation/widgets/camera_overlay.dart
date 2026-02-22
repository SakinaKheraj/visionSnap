import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/glass_theme.dart';

class CameraOverlay extends StatelessWidget {
  const CameraOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Darken outside frame
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.srcOut,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  backgroundBlendMode: BlendMode.dstOut,
                ),
              ),
              Center(
                child: Container(
                  width: 320,
                  height: 450,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Frame Corners & Instruction
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 320,
                height: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: GlassTheme.accentBlue.withOpacity(0.2),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    _buildCorner(0, 0), // Top left
                    _buildCorner(0, 1), // Top right
                    _buildCorner(1, 0), // Bottom left
                    _buildCorner(1, 1), // Bottom right
                    // Animated scanning line
                    Center(
                      child:
                          Container(
                                width: 300,
                                height: 2,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      GlassTheme.accentBlue.withOpacity(0),
                                      GlassTheme.accentBlue,
                                      GlassTheme.accentBlue.withOpacity(0),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: GlassTheme.accentBlue.withOpacity(
                                        0.5,
                                      ),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              )
                              .animate(
                                onPlay: (controller) => controller.repeat(),
                              )
                              .moveY(
                                begin: -210,
                                end: 210,
                                duration: 2000.ms,
                                curve: Curves.easeInOut,
                              ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: GlassTheme.accentBlue.withOpacity(0.3),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: GlassTheme.accentBlue.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const Text(
                      'Align item within frame',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                  .animate(
                    onPlay: (controller) => controller.repeat(reverse: true),
                  )
                  .scale(
                    begin: const Offset(1, 1),
                    end: const Offset(1.05, 1.05),
                    duration: 1500.ms,
                    curve: Curves.easeInOut,
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCorner(double top, double left) {
    const double length = 30;
    const double thickness = 3;
    const double radius = 40;

    return Positioned(
      top: top == 0 ? 0 : null,
      bottom: top == 1 ? 0 : null,
      left: left == 0 ? 0 : null,
      right: left == 1 ? 0 : null,
      child: Container(
        width: length,
        height: length,
        child: CustomPaint(
          painter: CornerPainter(
            isTop: top == 0,
            isLeft: left == 0,
            radius: radius,
            thickness: thickness,
            color: GlassTheme.accentBlue,
          ),
        ),
      ),
    );
  }
}

class CornerPainter extends CustomPainter {
  final bool isTop;
  final bool isLeft;
  final double radius;
  final double thickness;
  final Color color;

  CornerPainter({
    required this.isTop,
    required this.isLeft,
    required this.radius,
    required this.thickness,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke;

    final path = Path();
    if (isTop && isLeft) {
      path.moveTo(thickness / 2, size.height);
      path.lineTo(thickness / 2, thickness / 2);
      path.lineTo(size.width, thickness / 2);
    } else if (isTop && !isLeft) {
      path.moveTo(0, thickness / 2);
      path.lineTo(size.width - thickness / 2, thickness / 2);
      path.lineTo(size.width - thickness / 2, size.height);
    } else if (!isTop && isLeft) {
      path.moveTo(thickness / 2, 0);
      path.lineTo(thickness / 2, size.height - thickness / 2);
      path.lineTo(size.width, size.height - thickness / 2);
    } else {
      path.moveTo(0, size.height - thickness / 2);
      path.lineTo(size.width - thickness / 2, size.height - thickness / 2);
      path.lineTo(size.width - thickness / 2, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
