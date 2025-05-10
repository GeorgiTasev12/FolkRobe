import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class MainOptionCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final void Function()? onTap;

  const MainOptionCard({
    super.key,
    required this.title,
    required this.onTap,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(),
      child: SizedBox(
        width: 180,
        height: 360,
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
            children: [
              Image.asset(
                imagePath ?? "",
                errorBuilder: (context, object, stacktrace) {
                  return Icon(
                    Icons.error,
                    color: context.appTheme.colors.error,
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: context.appTheme.textStyles.titleMedium.copyWith(
                    color: context.appTheme.colors.onSurfaceContainer,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
