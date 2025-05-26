import 'package:flutter/material.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';

class OwnersListPage extends StatelessWidget {
  final GenderType genderType;

  const OwnersListPage({
    super.key,
    required this.genderType,
  });

  @override
  Widget build(BuildContext context) {
    return CorePage(
      child: Center(
        child: genderType != GenderType.male
            ? Text(
                "Женски отговорнички!",
                style: context.appTheme.textStyles.titleLarge.copyWith(
                  color: context.appTheme.colors.primary,
                ),
              )
            : Text(
                "Мъжки отговорници!",
                style: context.appTheme.textStyles.titleLarge.copyWith(
                  color: context.appTheme.colors.primary,
                ),
              ),
      ),
    );
  }
}
