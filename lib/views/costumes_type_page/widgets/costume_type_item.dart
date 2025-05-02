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
    return ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: context.appTheme.colors.outline,
          width: 1,
        ),
      ),
      tileColor: context.appTheme.colors.surfaceContainer,
      title: Center(
        child: Text(
          title,
          style: context.appTheme.textStyles.titleLarge.copyWith(
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: context.appTheme.colors.onSurfaceContainer,
          ),
        ),
      ),
    );
  }
}
