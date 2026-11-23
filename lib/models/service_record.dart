import 'package:flutter/material.dart';

class ServiceRecord {
  final String id;
  final String title;
  final String date;
  final int mileage;
  final String category; // 'Maintenance', 'Engine', 'Suspension'
  final String status;   // 'Completed', 'Scheduled'
  final String parts;
  final String shop;
  final double cost;
  final IconData icon;

  const ServiceRecord({
    required this.id,
    required this.title,
    required this.date,
    required this.mileage,
    required this.category,
    this.status = 'Completed',
    required this.parts,
    required this.shop,
    required this.cost,
    required this.icon,
  });

  // Зручний геттер для форматування пробігу (наприклад, 139000 -> "139,000 km")
  String get formattedMileage {
    final str = mileage.toString();
    final reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return '${str.replaceAllMapped(reg, (m) => '${m[1]},')} km';
  }
}