import 'package:flutter/material.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final AppColors colors;
  final AppTextStyles textStyles;

  const AppTheme({
    required this.colors,
    this.textStyles = const AppTextStyles(),
  });

  @override
  AppTheme copyWith({
    AppColors? colors,
    AppTextStyles? textStyles,
  }) {
    return AppTheme(
      colors: colors ?? this.colors,
      textStyles: textStyles ?? this.textStyles,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;

    return AppTheme(
      colors: AppColors.lerp(colors, other.colors, t),
    );
  }

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Color(0xFFCECECE),
        selectionHandleColor: Color(0xFF0055FF),
        cursorColor: Color(0xFF0055FF),
      ),
      extensions: [
        AppTheme(
          colors: AppColors(
            background: Color(0xFF607D8B),
            surfaceContainer: Color(0xFFFFFFFF),
            primary: Color(0xF8FFFFFF),
            outline: Color(0xFF2E2E2E),
            onSurfaceContainer: Color(0xFF000000),
            warning: Color(0xFFD9AA01),
            error: Color(0xFFFF0000),
            secondary: Color(0xFF0055FF),
          ),
        ),
      ],
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Color(0xFF808080),
        selectionHandleColor: Color(0xFF82B1FF),
        cursorColor: Color(0xFF82B1FF),
      ),
      extensions: [
        AppTheme(
          colors: AppColors(
            background: Color(0xFF323232),
            surfaceContainer: Color(0xFF1E1E1E),
            primary: Color(0xFFF4F4F4),
            outline: Color(0xFFBDBDBD),
            onSurfaceContainer: Color(0xFFFFFFFF),
            warning: Color(0xFFDBC060),
            error: Color(0xFFFF6B6B),
            secondary: Color(0xFF82B1FF),
          ),
        ),
      ],
    );
  }
}
