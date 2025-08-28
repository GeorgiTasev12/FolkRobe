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
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(8),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
