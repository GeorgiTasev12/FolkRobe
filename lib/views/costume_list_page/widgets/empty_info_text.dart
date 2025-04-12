import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class EmptyInfoText extends StatelessWidget {
  const EmptyInfoText({
    super.key,
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
              'Имате празен инвентар от риквизити, моля добавте като натискате:',
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