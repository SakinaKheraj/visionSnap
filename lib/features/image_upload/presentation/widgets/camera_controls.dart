import 'package:flutter/material.dart';
import '../../../../core/theme/glass_theme.dart';

class CameraControls extends StatelessWidget {
  final VoidCallback onGalleryTap;
  final VoidCallback onCaptureTap;
  final VoidCallback onFlashTap;
  final bool isFlashActive;

  const CameraControls({
    super.key,
    required this.onGalleryTap,
    required this.onCaptureTap,
    required this.onFlashTap,
    this.isFlashActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildDynamicButton(
            Icons.photo_library_outlined,
            'GALLERY',
            onGalleryTap,
          ),
          _buildCaptureButton(),
          _buildDynamicButton(
            Icons.flash_on_rounded,
            'FLASH',
            onFlashTap,
            isActive: isFlashActive,
          ),
        ],
      ),
    );
  }

  Widget _buildCaptureButton() {
    return GestureDetector(
      onTap: onCaptureTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.3), width: 4),
        ),
        child: Center(
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.crop_free_rounded,
              color: Colors.black,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDynamicButton(
    IconData icon,
    String label,
    VoidCallback onTap, {
    bool isActive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isActive
                  ? GlassTheme.accentBlue
                  : Colors.white.withOpacity(0.1),
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
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
