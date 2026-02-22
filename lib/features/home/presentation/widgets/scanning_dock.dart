import 'package:flutter/material.dart';
import '../../../../core/theme/glass_theme.dart';
import 'package:visionsnap/features/image_upload/presentation/pages/camera_screen.dart';
import 'package:visionsnap/features/history/presentation/pages/history_screen.dart';

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
            _buildDockButton(
              context,
              Icons.photo_library_outlined,
              false,
              isGallery: true,
            ),
            const SizedBox(width: 24),
            _buildMainScanButton(context),
            const SizedBox(width: 24),
            _buildDockButton(
              context,
              Icons.history_rounded,
              false,
              isHistory: true,
            ),
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

  Widget _buildDockButton(
    BuildContext context,
    IconData icon,
    bool isActive, {
    bool isGallery = false,
    bool isHistory = false,
  }) {
    return GestureDetector(
      onTap: () {
        if (isGallery) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const CameraScreen(openGalleryInitially: true),
            ),
          );
        } else if (isHistory) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryScreen()),
          );
        }
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isActive
              ? GlassTheme.accentBlue
              : Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
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
          border: Border.all(
            color: GlassTheme.accentBlue.withOpacity(0.3),
            width: 2,
          ),
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
          child: const Icon(
            Icons.crop_free_rounded,
            color: Colors.white,
            size: 36,
          ),
        ),
      ),
    );
  }
}
