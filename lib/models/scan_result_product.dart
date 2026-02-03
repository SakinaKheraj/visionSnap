import 'package:flutter/material.dart';

class ScanResultProduct {
  final String id;
  final String title;
  final String brand;
  final String price;
  final String imageUrl;
  final bool isUsed;
  final IconData? placeholderIcon;

  ScanResultProduct({
    required this.id,
    required this.title,
    required this.brand,
    required this.price,
    required this.imageUrl,
    this.isUsed = false,
    this.placeholderIcon,
  });
}
