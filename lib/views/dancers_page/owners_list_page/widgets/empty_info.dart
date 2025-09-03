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
          'Списъкът с отговорници е празен',
          softWrap: true,
          textAlign: TextAlign.center,
          style: context.appTheme.textStyles.bodyLarge.copyWith(
            color: context.appTheme.colors.primary,
          ),
        ),
      ],
    );
  }
}
