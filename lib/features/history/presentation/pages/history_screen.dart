import 'package:flutter/material.dart';
import '../../../../core/theme/glass_theme.dart';
import '../../data/models/scanned_item.dart';
import '../widgets/history_card.dart';
import '../widgets/history_filter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'Today';

  final List<ScannedItem> _recentActivity = [
    ScannedItem(
      id: '1',
      title: 'Modern Velvet Sofa',
      category: 'Living Room',
      brand: 'IKEA',
      timestamp: '2:45 PM TODAY',
      imageUrl: '', // Blank for placeholder
      placeholderIcon: Icons.weekend_rounded,
    ),
    ScannedItem(
      id: '2',
      title: 'Minimalist Floor Lamp',
      category: 'Lighting',
      brand: 'West Elm',
      timestamp: '11:20 AM TODAY',
      imageUrl: '',
      placeholderIcon: Icons.light_rounded,
    ),
  ];

  final List<ScannedItem> _yesterdayActivity = [
    ScannedItem(
      id: '3',
      title: 'Ceramic Coffee Mug',
      category: 'Kitchenware',
      brand: 'Etsy',
      timestamp: '4:15 PM OCT 23',
      imageUrl: '',
      placeholderIcon: Icons.coffee_rounded,
    ),
    ScannedItem(
      id: '4',
      title: 'Swift Running Shoes',
      category: 'Apparel',
      brand: 'Nike',
      timestamp: '9:05 AM OCT 23',
      imageUrl: '',
      placeholderIcon: Icons.directions_run_rounded,
    ),
    ScannedItem(
      id: '5',
      title: 'Chronos Silver Watch',
      category: 'Accessories',
      brand: 'Fossil',
      timestamp: '8:20 PM OCT 22',
      imageUrl: '',
      placeholderIcon: Icons.watch_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GlassTheme.meshBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 24),
                  HistoryFilter(
                    selectedFilter: _selectedFilter,
                    onFilterChanged: (filter) => setState(() => _selectedFilter = filter),
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        _buildSectionHeader('RECENT ACTIVITY'),
                        ..._recentActivity.map((item) => HistoryCard(item: item)),
                        const SizedBox(height: 16),
                        _buildSectionHeader('YESTERDAY'),
                        ..._yesterdayActivity.map((item) => HistoryCard(item: item)),
                        const SizedBox(height: 100), // Space for bottom nav
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
            ),
          ),
          const Text(
            'Archives',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.1)),
            ),
            child: const Icon(Icons.search_rounded, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.white.withOpacity(0.4),
        ),
      ),
    );
  }
}
