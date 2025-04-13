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
      extensions: [
        AppTheme(
          colors: AppColors(
            background: Color(0xFF607D8B),
            surfaceContainer: Color(0xFFFFFFFF),
            primary: Color(0xF8FFFFFF),
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
      extensions: [
        AppTheme(
          colors: AppColors(
            background:Color(0xFF323232),
            surfaceContainer:Color(0xFF1E1E1E), 
            primary: Color(0xFFF4F4F4),
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
