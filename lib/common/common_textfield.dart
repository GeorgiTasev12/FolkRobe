import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folk_robe/helpers/regex_helper.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CommonTextfield extends StatelessWidget {
  final TextEditingController textController;
  final void Function(String)? onChanged;
  final void Function()? onIconButtonPress;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;
  final bool isClearIconVisible;

  const CommonTextfield({
    super.key,
    required this.textController,
    this.onChanged,
    this.onIconButtonPress,
    this.keyboardType,
    this.formatters,
    this.isClearIconVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
        onChanged: onChanged,
        controller: textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: context.appTheme.colors.primary,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: context.appTheme.colors.secondary,
              width: 2,
            ),
          ),
          suffixIcon: isClearIconVisible
              ? IconButton(
                  onPressed: onIconButtonPress,
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: context.appTheme.colors.onSurfaceContainer,
                  ),
                )
              : null,
        ),
        cursorColor: context.appTheme.colors.secondary,
        keyboardType: keyboardType ?? TextInputType.text,
        inputFormatters: formatters ??
            [
              FilteringTextInputFormatter.allow(RegexHelper.wordsOnly),
            ],
      );
  }
}
