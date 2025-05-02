import 'package:flutter/material.dart';

class Destination {
  Destination({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;
}

List<Destination> destinations = [
  Destination(label: 'Overview', icon: Icons.description_outlined),
  Destination(label: 'Categories', icon: Icons.category_outlined),
  Destination(label: 'Statistic', icon: Icons.query_stats),
];
