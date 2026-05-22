import 'package:flutter/material.dart';

class UniFacultyEntity {
  final String name;
  final IconData icon;
  final String minFees;
  final double minGrade;
  final List<String> requirements;
  final bool isExpanded;

  const UniFacultyEntity({
    required this.name,
    required this.icon,
    required this.minFees,
    required this.minGrade,
    required this.requirements,
    this.isExpanded = false,
  });
}
