import 'package:flutter/material.dart';
import '../../../../core/theme/glass_theme.dart';
import '../widgets/home_header.dart';
import '../widgets/product_card.dart';
import '../widgets/scanning_dock.dart';
import '../widgets/bottom_nav.dart';

import 'package:visionsnap/features/history/presentation/pages/history_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const HistoryScreen(),
    const Center(child: Text('Saved Items', style: TextStyle(color: Colors.white))),
    const Center(child: Text('Profile', style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNav(
        selectedIndex: _selectedIndex,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        GlassTheme.meshBackground(),

        SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HomeHeader(),
                const SizedBox(height: 16),
                _buildRecentlyScannedSection(),
                const SizedBox(height: 32),
                const ScanningDock(),
                const SizedBox(height: 100), // Space for bottom nav
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentlyScannedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recently Scanned',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'View All',
                  style: TextStyle(color: GlassTheme.accentBlue),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 280,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: const [
              ProductCard(
                title: 'Nike Air Max',
                category: 'Sneakers • Men',
                price: '\$120',
                icon: Icons.directions_run_rounded,
              ),
              ProductCard(
                title: 'Modern Lamp',
                category: 'Home • Decor',
                price: '\$45',
                icon: Icons.light_rounded,
              ),
              ProductCard(
                title: 'Leather Jacket',
                category: 'Apparel • Men',
                price: '\$210',
                icon: Icons.checkroom_rounded,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
