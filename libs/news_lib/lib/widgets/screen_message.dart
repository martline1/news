import 'dart:math';
import 'package:flutter/material.dart';

class ScreenMessage extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color labelColor;
  final Color iconColor;
  final double fontSize;

  const ScreenMessage({
    super.key,
    required this.label,
    required this.icon,
    required this.labelColor,
    required this.iconColor,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final logoSize = min(min(size.width, size.height) * 0.3, 200);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: logoSize.toDouble(),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: labelColor,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: fontSize,
            ),
          )
        ],
      ),
    );
  }
}
