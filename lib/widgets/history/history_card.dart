import 'package:flutter/material.dart';
import '../../core/theme/glass_theme.dart';
import '../../models/scanned_item.dart';

class HistoryCard extends StatelessWidget {
  final ScannedItem item;

  const HistoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GlassTheme.glassCard(
        opacity: 0.05,
        child: Row(
          children: [
            // Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 80,
                height: 80,
                color: Colors.white.withOpacity(0.05),
                child: item.imageUrl.startsWith('http') 
                  ? Image.network(item.imageUrl, fit: BoxFit.cover)
                  : Icon(item.placeholderIcon ?? Icons.image_rounded, color: Colors.white24, size: 32),
              ),
            ),
            const SizedBox(width: 16),
            
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${item.category} • ${item.brand}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: GlassTheme.textSub,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item.timestamp,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: GlassTheme.accentBlue,
                    ),
                  ),
                ],
              ),
            ),

            // Share/Action Button
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: const Icon(
                Icons.ios_share_rounded,
                color: GlassTheme.accentBlue,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
