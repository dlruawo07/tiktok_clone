import 'package:flutter/material.dart';

class FlashModeButton extends StatelessWidget {
  const FlashModeButton({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.onPressed,
  });

  final bool isSelected;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isSelected ? Colors.amber.shade200 : Colors.white,
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}
