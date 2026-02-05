import 'package:flutter/material.dart';
import '../../../../core/theme/glass_theme.dart';
import 'package:visionsnap/features/scanner/presentation/pages/camera_screen.dart';

class ScanningDock extends StatelessWidget {
  const ScanningDock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Tap to identify',
          style: TextStyle(
            color: GlassTheme.textSub,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDockButton(Icons.photo_library_outlined, false),
            const SizedBox(width: 24),
            _buildMainScanButton(context),
            const SizedBox(width: 24),
            _buildDockButton(Icons.flash_on_rounded, false),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          'AI VISUAL SEARCH',
          style: TextStyle(
            color: GlassTheme.accentBlue,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildDockButton(IconData icon, bool isActive) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: isActive ? GlassTheme.accentBlue : Colors.white.withOpacity(0.05),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildMainScanButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CameraScreen()),
        );
      },
      child: Container(
        width: 88,
        height: 88,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: GlassTheme.accentBlue.withOpacity(0.3), width: 2),
        ),
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: const BoxDecoration(
            color: GlassTheme.accentBlue,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: GlassTheme.accentBlue,
                blurRadius: 20,
                spreadRadius: -5,
              ),
            ],
          ),
          child: const Icon(Icons.crop_free_rounded, color: Colors.white, size: 36),
        ),
      ),
    );
  }
}
