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
  final Icon? prefixIcon;
  final IconButton? suffixIconButton;
  final String? hintText;
  final bool isSearchTextField;

  const CommonTextfield({
    super.key,
    required this.textController,
    this.onChanged,
    this.onIconButtonPress,
    this.keyboardType,
    this.formatters,
    this.isClearIconVisible = false,
    this.prefixIcon,
    this.suffixIconButton,
    this.hintText,
    this.isSearchTextField = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: textController,
      textCapitalization: TextCapitalization.sentences,
      decoration: !isSearchTextField
          ? InputDecoration(
              filled: true,
              fillColor: context.appTheme.colors.surfaceContainer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.appTheme.colors.primary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: context.appTheme.colors.secondary, width: 2),
              ),
              suffixIcon: isClearIconVisible
                  ? IconButton(
                      onPressed: onIconButtonPress,
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: context.appTheme.colors.onSurfaceContainer,
                      ),
                    )
                  : suffixIconButton,
            )
          : InputDecoration(
              prefixIcon: prefixIcon,
              hintText: hintText,
              hintStyle: context.appTheme.textStyles.bodyLarge
                  .copyWith(color: context.appTheme.colors.onSurfaceContainer),
              suffixIcon: isClearIconVisible
                  ? IconButton(
                      onPressed: onIconButtonPress,
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: context.appTheme.colors.onSurfaceContainer,
                      ),
                    )
                  : suffixIconButton,
              contentPadding: EdgeInsets.only(top: 11),
              filled: true,
              fillColor:
                  context.appTheme.colors.surfaceContainer.withAlpha(150),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: context.appTheme.colors.primary,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: context.appTheme.colors.primary,
                ),
              ),
            ),
      cursorColor: context.appTheme.colors.secondary,
      keyboardType: keyboardType ?? TextInputType.text,
      inputFormatters: formatters ??
          [
            FilteringTextInputFormatter.allow(RegexHelper.everyCharacter),
          ],
    );
  }
}
