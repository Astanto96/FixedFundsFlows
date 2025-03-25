import 'package:flutter/material.dart';

class SheetHeader extends StatelessWidget {
  final String title;

  const SheetHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          Positioned(
            right: 0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
