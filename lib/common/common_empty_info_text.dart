import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CommonEmptyInfoText extends StatelessWidget {
  final bool isDancer;

  const CommonEmptyInfoText({
    super.key,
    required this.isDancer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isDancer
                  ? "Няма налични танцьори"
                  : 'Няма налични реквизити',
              softWrap: true,
              textAlign: TextAlign.center,
              style: context.appTheme.textStyles.bodyLarge.copyWith(
                color: context.appTheme.colors.primary,
              ),
            ),
            SizedBox(height: 15),
            Icon(
              Icons.add,
              color: context.appTheme.colors.primary,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }
}
