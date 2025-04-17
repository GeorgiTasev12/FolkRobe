import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CommonListTile extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? contentPadding;
  final List<Widget>? suffixWidgets;

  const CommonListTile({
    super.key,
    required this.title,
    this.contentPadding,
    this.suffixWidgets,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: context.appTheme.textStyles.titleMedium.copyWith(
          fontWeight: FontWeight.w300,
          color: context.appTheme.colors.onSurfaceContainer,
        ),
      ),
      contentPadding: contentPadding ?? EdgeInsets.zero,
      tileColor: context.appTheme.colors.surfaceContainer,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: suffixWidgets ?? [],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
