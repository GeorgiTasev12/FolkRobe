import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CostumeTypeItem extends StatelessWidget {
  final String title;
  final void Function()? onTap;

  const CostumeTypeItem({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: context.appTheme.colors.surfaceContainer,
          ),
          child: Center(
            child: Text(
              title,
              style: context.appTheme.textStyles.titleLarge.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: context.appTheme.colors.onSurfaceContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
