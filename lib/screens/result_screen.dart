import 'package:flutter/material.dart';
import '../core/theme/glass_theme.dart';
import '../models/scan_result_product.dart';
import '../widgets/results/result_product_card.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _selectedFilter = 'Best Match';

  static final List<ScanResultProduct> _allProducts = [
    ScanResultProduct(
      id: '1',
      brand: 'ASOS',
      title: 'Urban Retro Biker Jacket',
      price: '\$129.99',
      imageUrl: '',
      placeholderIcon: Icons.checkroom,
    ),
    ScanResultProduct(
      id: '2',
      brand: 'Zara',
      title: 'Faux Leather Moto',
      price: '\$85.00',
      imageUrl: '',
      placeholderIcon: Icons.checkroom,
    ),
    ScanResultProduct(
      id: '3',
      brand: 'Nordstrom',
      title: 'AllSaints Dalby',
      price: '\$450.00',
      imageUrl: '',
      placeholderIcon: Icons.checkroom,
    ),
    ScanResultProduct(
      id: '4',
      brand: 'eBay',
      title: 'Vintage Levi\'s Trucker',
      price: '\$95.00',
      imageUrl: '',
      isUsed: true,
      placeholderIcon: Icons.checkroom,
    ),
    ScanResultProduct(
      id: '5',
      brand: 'Uniqlo',
      title: 'Classic Bomber',
      price: '\$65.00',
      imageUrl: '',
      placeholderIcon: Icons.checkroom,
    ),
    ScanResultProduct(
      id: '6',
      brand: 'H&M',
      title: 'Moto Racer Zipped',
      price: '\$75.00',
      imageUrl: '',
      placeholderIcon: Icons.checkroom,
    ),
  ];

  List<ScanResultProduct> get _filteredProducts {
    if (_selectedFilter == 'Under \$100') {
      return _allProducts.where((p) {
        final double price = double.tryParse(p.price.replaceAll('\$', '')) ?? 0;
        return price < 100;
      }).toList();
    }
    // For "Best Match" and "Prime Delivery" we'll just show all for now 
    // but in a real app this would have different logic
    return _allProducts;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Calculate aspect ratio based on screen width to avoid overflow on small screens
    final double aspectRatio = (size.width / 2) / 300; 

    return Scaffold(
      body: Stack(
        children: [
          GlassTheme.meshBackground(),
          
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 16),
                _buildFilters(),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 120),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: aspectRatio.clamp(0.6, 0.8),
                    ),
                    itemCount: _filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ResultProductCard(product: _filteredProducts[index]);
                    },
                  ),
                ),
              ],
            ),
          ),

          // Bottom Floating Button
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: _buildSnapNewButton(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleButton(Icons.arrow_back_rounded, onTap: () => Navigator.pop(context)),
          Column(
            children: const [
              Text(
                'SCANNED RESULT',
                style: TextStyle(
                  color: GlassTheme.accentBlue,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Vintage Leather Jacket',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          _buildCircleButton(Icons.tune_rounded),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildFilterChip('Best Match', icon: Icons.verified_rounded),
          const SizedBox(width: 12),
          _buildFilterChip('Under \$100'),
          const SizedBox(width: 12),
          _buildFilterChip('Prime Delivery'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {IconData? icon}) {
    final bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedFilter = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? GlassTheme.accentBlue : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? GlassTheme.accentBlue : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 16),
              const SizedBox(width: 8),
            ],
            Text(label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSnapNewButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: GlassTheme.accentBlue.withOpacity(0.3),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: GlassTheme.accentBlue,
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 10),
                  const Text(
                    'Snap New Photo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

