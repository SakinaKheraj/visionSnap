import 'dart:io';
import 'package:flutter/material.dart';
import '../../../../core/theme/glass_theme.dart';

class ImagePreviewView extends StatelessWidget {
  final File imageFile;
  final VoidCallback onUpload;
  final VoidCallback onRetake;
  final bool isLoading;

  const ImagePreviewView({
    super.key,
    required this.imageFile,
    required this.onUpload,
    required this.onRetake,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.file(imageFile, fit: BoxFit.cover),

        SafeArea(child: Column(children: [const Spacer(), _buildFooter()])),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: isLoading ? null : onUpload,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40),
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [GlassTheme.accentBlue, Color(0xFF4F46E5)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: GlassTheme.accentBlue.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Analyze Selection',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: onRetake,
            child: const Text(
              'Retake Photo',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }
}
