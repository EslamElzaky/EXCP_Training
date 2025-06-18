import 'package:flutter/material.dart';

class CustomIcons extends StatelessWidget {
  CustomIcons({super.key, this.onTap, required this.icon});
  Icon icon;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 46,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IconButton(
        iconSize: 30,
        onPressed: onTap,
        icon: icon,
        color: Colors.white,
      ),
    );
  }
}
