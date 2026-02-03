import 'package:flutter/material.dart';
import '../core/theme/glass_theme.dart';
import '../widgets/camera/scanning_area.dart';
import '../widgets/camera/camera_controls.dart';

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
          // Simulated Camera Preview
          GlassTheme.meshBackground(),
          
          // Scanning HUD
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
            ),
          ),

          // Overlay Content
          SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                const Spacer(),
                ScanningArea(scanLineAnimation: _scanLineAnimation),
                const Spacer(),
                const CameraControls(),
              ],
            ),
          ),
        ],
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