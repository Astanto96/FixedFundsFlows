import 'package:flutter/material.dart';

class ContractBottomsheetHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onDelete;

  const ContractBottomsheetHeader({
    super.key,
    required this.title,
    this.onDelete,
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
          if (onDelete != null) ...{
            Positioned(
              left: 0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () {
                  onDelete?.call();
                },
                icon: const Icon(Icons.delete),
              ),
            ),
          } else ...{
            Positioned(
              right: 0,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ),
          },
        ],
      ),
    );
  }
}
