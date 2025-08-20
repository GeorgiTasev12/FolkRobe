import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class EmptyInfoText extends StatelessWidget {
  final String genderText;

  const EmptyInfoText({
    super.key,
    required this.genderText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'В момент нямате $genderText, за да добавите на танциорите дадени реквизити, моля натиснете:',
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
        ),
      ],
    );
  }
}
