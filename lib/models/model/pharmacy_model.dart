import 'package:flutter/material.dart';

class PharmacyModel {
  final String name;
  final String address;
  final IconData icon;
  final String? imageUrl;
  final bool isInStock;

  const PharmacyModel({
    required this.name,
    required this.address,
    required this.icon,
    this.imageUrl,
    this.isInStock = true,
  });
}
