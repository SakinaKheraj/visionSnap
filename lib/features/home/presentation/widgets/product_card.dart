import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../../../core/theme/glass_theme.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String category;
  final String price;
  final IconData icon;

  const ProductCard({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: GlassTheme.glassCard(
        opacity: 0.05,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.white.withOpacity(0.05),
                    child: Center(
                      child: Icon(icon, size: 48, color: Colors.white24),
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          price,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              category,
              style: const TextStyle(
                fontSize: 12,
                color: GlassTheme.textSub,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
