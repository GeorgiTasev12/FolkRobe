import 'package:flutter/material.dart';

class CommonCircleIconButton extends StatelessWidget {
  final int index;
  final Widget icon;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const CommonCircleIconButton({
    super.key,
    required this.index,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor,
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
        ),
      ),
    );
  }
}