import 'package:flutter/material.dart';
import 'package:folk_robe/theme/app_theme.dart';

class AppColors {
  final Color? background;
  final Color? surfaceContainer;
  final Color? primary;
  final Color? warning;
  final Color? error;
  final Color? onSurfaceContainer;
  final Color? secondary;

  AppColors({
    this.background,
    this.surfaceContainer,
    this.primary,
    this.warning,
    this.error,
    this.onSurfaceContainer,
    this.secondary,
  });

  static AppColors lerp(AppColors a, AppColors b, double t) {
    return AppColors(
      background: Color.lerp(a.background, b.background, t),
      primary: Color.lerp(a.primary, b.primary, t),
      surfaceContainer: Color.lerp(a.surfaceContainer, b.surfaceContainer, t),
      warning: Color.lerp(a.warning, b.warning, t),
      error: Color.lerp(a.error, b.error, t),
      onSurfaceContainer:
          Color.lerp(a.onSurfaceContainer, b.onSurfaceContainer, t),
      secondary: Color.lerp(a.secondary, b.secondary, t),
    );
  }
}

class AppTextStyles {
  final TextStyle titleMedium;
  final TextStyle titleLarge;
  final TextStyle bodyLarge;
  final TextStyle labelMedium;

  const AppTextStyles(
      {this.titleMedium = const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w200,
      ),
      this.titleLarge = const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
      this.bodyLarge = const TextStyle(
        fontSize: 16,
        letterSpacing: 0.2,
        fontWeight: FontWeight.w300,
      ),
      this.labelMedium = const TextStyle(
        fontSize: 12,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w400,
      )});

  AppTextStyles copyWith({
    TextStyle? bodyLarge,
    TextStyle? titleMedium,
    TextStyle? titleLarge,
    TextStyle? labelMedium,
  }) {
    return AppTextStyles(
      bodyLarge: bodyLarge ?? this.bodyLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleLarge: titleLarge ?? this.titleLarge,
      labelMedium: labelMedium ?? this.labelMedium,
    );
  }

  static AppTextStyles lerp(AppTextStyles a, AppTextStyles b, double t) =>
      AppTextStyles();
}

extension AppThemeExtension on BuildContext {
  AppTheme get appTheme {
    final theme = Theme.of(this).extension<AppTheme>();

    if (theme == null) {
      throw Exception('AppTheme is not found in the theme context.');
    }

    return theme;
  }
}
