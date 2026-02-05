import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../../../core/theme/glass_theme.dart';

class BottomNav extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavIcon(Icons.home_filled, 0),
              _buildNavIcon(Icons.history_rounded, 1),
              _buildNavIcon(Icons.favorite_rounded, 2),
              _buildNavIcon(Icons.person_rounded, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onItemSelected(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? GlassTheme.accentBlue.withOpacity(0.2) : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isSelected ? GlassTheme.accentBlue : GlassTheme.textSub.withOpacity(0.6),
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          
        ],
      ),
    );
  }
}
