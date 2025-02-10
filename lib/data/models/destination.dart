import 'package:flutter/material.dart';

class Destination {
  const Destination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}

const destinations = [
  Destination(label: 'Overview', icon: Icons.description_outlined),
  Destination(label: 'Categorys', icon: Icons.category_outlined),
];
