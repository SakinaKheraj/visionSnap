import 'package:flutter/material.dart';
import '../../core/theme/glass_theme.dart';
import '../../models/scan_result_product.dart';

class ResultProductCard extends StatelessWidget {
  final ScanResultProduct product;

  const ResultProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: GlassTheme.cardNavy.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section - Flexible to avoid overflow
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.white.withOpacity(0.05),
                    child: product.imageUrl.startsWith('http')
                        ? Image.network(product.imageUrl, fit: BoxFit.cover)
                        : Center(
                            child: Icon(
                              product.placeholderIcon ?? Icons.shopping_bag_outlined,
                              size: 40,
                              color: Colors.white10,
                            ),
                          ),
                  ),
                ),
                // Wishlist Button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite_rounded, color: Colors.white, size: 16),
                  ),
                ),
                // Used Label
                if (product.isUsed)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF59E0B),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'USED',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Details Section
          Flexible(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.brand,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: GlassTheme.textSub.withOpacity(0.6),
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.price,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                          color: GlassTheme.accentBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.shopping_bag_rounded, color: Colors.white, size: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

