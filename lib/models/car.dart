//import 'package:flutter/material.dart';

class Car {
  final String id;
  final String name;
  final String subtitle;       // 'Compact SUV • All-Wheel Drive'
  final String plateNumber;    // 'AB-1234-CE'
  final int mileage;           // 145000
  final String status;         // 'Active' або 'Idle'
  final String serviceMessage; // 'Service due in 500 km' або 'Inspected last month'
  final bool isServiceUrgent;  // true -> помаранчевий колір, false -> темний
  final String imageAsset;     // 'assets/images/car1.png'

  const Car({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.plateNumber,
    required this.mileage,
    required this.status,
    required this.serviceMessage,
    this.isServiceUrgent = false,
    required this.imageAsset,
  });

  // Форматування пробігу: 145000 -> "145,000 km"
  String get formattedMileage {
    final str = mileage.toString();
    final reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    return '${str.replaceAllMapped(reg, (m) => '${m[1]},')} km';
  }

  bool get isActive => status == 'Active';
}