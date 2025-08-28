import 'package:flutter/material.dart';
import 'package:folk_robe/models/status.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

void showCommonSnackbar({
  required BuildContext context,
  required String? message,
  Status status = Status.initial,
}) {
  final snackbar = SnackBar(
    content: Text(
      message ?? 'Missing Text',
      textAlign: TextAlign.left,
      style: context.appTheme.textStyles.bodyLarge.copyWith(
        color: status != Status.success
            ? context.appTheme.colors.surfaceContainer
            : context.appTheme.colors.onSurfaceContainer,
      ),
    ),
    duration: Duration(seconds: 5),
    backgroundColor: status != Status.success
        ? context.appTheme.colors.error
        : context.appTheme.colors.surfaceContainer,
    elevation: 2,
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
