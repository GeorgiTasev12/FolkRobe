import 'package:flutter/cupertino.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';

class DancersListPage extends StatelessWidget {
  final GenderType genderType;

  const DancersListPage({
    super.key,
    required this.genderType,
  });

  @override
  Widget build(BuildContext context) {
    return CorePage(
      child: Center(
        child: genderType != GenderType.male
            ? Text(
                "Женски танцьорки!",
                style: context.appTheme.textStyles.titleLarge.copyWith(
                  color: context.appTheme.colors.onSurfaceContainer,
                ),
              )
            : Text(
                "Мъжки танцьори!",
                style: context.appTheme.textStyles.titleLarge.copyWith(
                  color: context.appTheme.colors.onSurfaceContainer,
                ),
              ),
      ),
    );
  }
}
