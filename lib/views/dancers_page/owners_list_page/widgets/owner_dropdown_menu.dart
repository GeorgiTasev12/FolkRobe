import 'package:flutter/material.dart';
import 'package:folk_robe/helpers/screen_size_helper.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class OwnerDropdownMenu<T> extends StatelessWidget {
  final List<DropdownMenuEntry<T>> entries;
  final String text;
  final void Function(T?)? onSelected;
  final bool enabled;
  final T? initialSelection;
  final Key? valueKey;

  const OwnerDropdownMenu({
    super.key,
    required this.entries,
    required this.text,
    required this.initialSelection,
    required this.onSelected,
    this.enabled = true,
    this.valueKey,
  });

  @override
  Widget build(BuildContext context) {
    final double spacing = 7;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            text,
            style: context.appTheme.textStyles.bodyLarge.copyWith(
              color: context.appTheme.colors.primary,
            ),
          ),
          SizedBox(width: spacing),
          Theme(
            data: Theme.of(context).copyWith(
              dropdownMenuTheme: DropdownMenuThemeData(
                menuStyle: MenuStyle(
                  backgroundColor: WidgetStateProperty.all(
                    context.appTheme.colors.surfaceContainer,
                  ),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                    ),
                  ),
                  minimumSize: WidgetStateProperty.all(
                    Size(
                      ScreenSizeHelper(context).width * 0.6,
                      40,
                    ),
                  ),
                  maximumSize: WidgetStateProperty.all(
                    Size(
                      ScreenSizeHelper(context).width * 0.8,
                      double.infinity,
                    ),
                  ),
                ),
              ),
            ),
            child: DropdownMenu<T>(
              key: valueKey,
              dropdownMenuEntries: entries,
              enabled: enabled,
              onSelected: onSelected,
              width: ScreenSizeHelper(context).getX(spacing: spacing),
              initialSelection: initialSelection,
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                filled: true,
                fillColor: context.appTheme.colors.surfaceContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
