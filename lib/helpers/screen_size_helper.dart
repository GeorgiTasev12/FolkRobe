import 'package:flutter/material.dart';

class ScreenSizeHelper {
  final BuildContext context;

  ScreenSizeHelper(this.context);

  double get width => MediaQuery.of(context).size.width;

  bool get isSmall => width < 390;
  bool get isMedium => width >= 390 && width < 800;
  bool get isLarge => width >= 800;

  double get horizontalPadding {
    if (isSmall) return 8;
    if (isMedium) return 12;
    if (isLarge) return 16;

    return 32;
  }
}
