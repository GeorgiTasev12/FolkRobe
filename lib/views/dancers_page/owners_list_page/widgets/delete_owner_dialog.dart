import 'package:flutter/material.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class DeleteOwnerDialog extends StatelessWidget {
  final VoidCallback onDeletePressed;

  const DeleteOwnerDialog({
    super.key,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: context.appTheme.colors.surfaceContainer,
      title: Text("Внимание"),
      content: Text(
        "Вие сте на път да премахнете определен отговорник от списъка. След това няма да можете да го върнете. Желаете ли да продължите с операцията ?",
        style: context.appTheme.textStyles.bodyLarge
            .copyWith(color: context.appTheme.colors.onSurfaceContainer),
      ),
      actions: [
        TextButton(
          onPressed: () => locator<NavigationService>().pop(),
          child: Text(
            "Не",
            style: context.appTheme.textStyles.labelMedium.copyWith(
              color: context.appTheme.colors.secondary,
            ),
          ),
        ),
        FilledButton(
          onPressed: onDeletePressed,
          style: FilledButton.styleFrom(
            backgroundColor: context.appTheme.colors.secondary,
          ),
          child: Text(
            "Да",
            style: context.appTheme.textStyles.labelMedium.copyWith(
              color: context.appTheme.colors.surfaceContainer,
            ),
          ),
        ),
      ],
    );
  }
}
