import 'package:flutter/material.dart';

class UniFacultyEntity {
  final int id;
  final String name;
  final String location;
  final String minFees;
  final double minGrade;
  final List<String> requirements;
  final IconData icon;

  const UniFacultyEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.minFees,
    required this.minGrade,
    required this.requirements,
    required this.icon,
  });
}
