import 'package:flutter/material.dart';

class CommonCircleComponentButton extends StatelessWidget {
  final int index;
  final Icon icon;
  final void Function() onTap;
  final Color? backgroundColor;

  const CommonCircleComponentButton({
    required this.index,
    required this.onTap,
    required this.icon,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor,
        child: IconButton(
          onPressed: onTap,
          icon: icon,
        ),
      ),
    );
  }
}
