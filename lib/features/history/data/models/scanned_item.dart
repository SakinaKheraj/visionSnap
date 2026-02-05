import 'package:flutter/material.dart';

class ScannedItem {
  final String id;
  final String title;
  final String category;
  final String brand;
  final String timestamp;
  final String imageUrl;
  final IconData? placeholderIcon;

  ScannedItem({
    required this.id,
    required this.title,
    required this.category,
    required this.brand,
    required this.timestamp,
    required this.imageUrl,
    this.placeholderIcon,
  });
}
