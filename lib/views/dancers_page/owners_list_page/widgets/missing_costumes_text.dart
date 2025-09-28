import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class MissingCostumesText extends StatelessWidget {
  const MissingCostumesText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
          'За момента, нямате записана информация при костюмите, моля добавете костюм и се върнете обратно.',
          textAlign: TextAlign.center,
          style: context.appTheme.textStyles.bodyLarge
              .copyWith(
            color: context.appTheme.colors.primary,
          ),
        ),
      );
  }
}