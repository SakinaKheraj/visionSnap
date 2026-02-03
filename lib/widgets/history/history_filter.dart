import 'package:flutter/material.dart';
import '../../core/theme/glass_theme.dart';

class HistoryFilter extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const HistoryFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          _buildFilterItem('Today'),
          _buildFilterItem('Week'),
          _buildFilterItem('All'),
        ],
      ),
    );
  }

  Widget _buildFilterItem(String label) {
    final bool isSelected = selectedFilter == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterChanged(label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? GlassTheme.accentBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(21),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : GlassTheme.textSub,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
