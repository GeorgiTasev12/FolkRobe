import 'package:flutter/material.dart';
import 'package:folk_robe/helpers/screen_size_helper.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CommonListTile extends StatelessWidget {
  final String title;
  final String? quantity;
  final double? contentPadding;
  final List<Widget>? suffixWidgets;

  const CommonListTile({
    super.key,
    required this.title,
    this.quantity,
    this.contentPadding = 10,
    this.suffixWidgets,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasQuantity = (quantity ?? '').isNotEmpty;

    double mediumWidthSize() {
      return ScreenSizeHelper(context).isMedium ? 210 : 190;
    }

    return ListTile(
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasQuantity)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Бр: $quantity',
                  style: context.appTheme.textStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w400,
                    color: context.appTheme.colors.onSurfaceContainer,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          SizedBox(
            width: !hasQuantity 
              ? (!hasQuantity ? mediumWidthSize() : 130) 
              : ScreenSizeHelper(context).isSmall ? 130 : 150,
            child: Text(
              title,
              style: context.appTheme.textStyles.titleMedium.copyWith(
                fontWeight: FontWeight.w300,
                overflow: TextOverflow.ellipsis,
                color: context.appTheme.colors.onSurfaceContainer,
              ),
            ),
          ),
        ],
      ),
      contentPadding: (contentPadding != null)
          ? EdgeInsets.symmetric(horizontal: contentPadding ?? 0.0)
          : EdgeInsets.zero,
      tileColor: context.appTheme.colors.surfaceContainer,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: suffixWidgets ?? [],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
        side: BorderSide(
          color: context.appTheme.colors.outline,
          width: 1,
        ),
      ),
    );
  }
}
