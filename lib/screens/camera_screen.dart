import 'package:flutter/material.dart';
import 'package:visionsnap/core/theme/glass_theme.dart';
import 'dart:ui' as ui;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> with TickerProviderStateMixin {
  late AnimationController _scanLineController;
  late Animation<double> _scanLineAnimation;

  @override
  void initState() {
    super.initState();
    _scanLineController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _scanLineAnimation = Tween<double>(begin: 0.2, end: 0.8).animate(
      CurvedAnimation(parent: _scanLineController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Simulated Camera Preview (Deep Navy with subtle mesh)
          GlassTheme.meshBackground(),
          
          // Scanning HUD
          _buildScanningHUD(),

          // Overlay Content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                const Spacer(),
                _buildScanningArea(),
                const Spacer(),
                _buildControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanningHUD() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircularBtn(
            Icons.close_rounded,
            onTap: () => Navigator.pop(context),
          ),
          const Column(
            children: [
              Text(
                'AI SCANNER',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: GlassTheme.accentBlue,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Point at an object',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          _buildCircularBtn(Icons.more_horiz_rounded),
        ],
      ),
    );
  }

  Widget _buildScanningArea() {
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
            animation: _scanLineAnimation,
            builder: (context, child) {
              return Positioned(
                top: 380 * _scanLineAnimation.value,
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

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNavBtn(Icons.photo_library_outlined, 'Gallery'),
          const SizedBox(width: 40),
          _buildCaptureButton(),
          const SizedBox(width: 40),
          _buildNavBtn(Icons.flash_on_rounded, 'Flash'),
        ],
      ),
    );
  }

  Widget _buildCaptureButton() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 4),
      ),
      padding: const EdgeInsets.all(6),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildNavBtn(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildCircularBtn(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}