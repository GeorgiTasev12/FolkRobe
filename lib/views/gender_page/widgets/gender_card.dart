import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class GenderCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final void Function()? onTap;

  const GenderCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 180,
        height: 180,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
            side: BorderSide(
              color: context.appTheme.colors.outline,
              width: 3,
            ),
          ),
          color: context.appTheme.colors.surfaceContainer,
          elevation: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 70,
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: context.appTheme.textStyles.titleMedium.copyWith(
                  color: context.appTheme.colors.onSurfaceContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}