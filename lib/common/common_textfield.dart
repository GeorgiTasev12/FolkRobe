import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/helpers/regex_helper.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/bloc/costume_bloc.dart';

class CommonTextfield extends StatelessWidget {
  final TextEditingController textController;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;

  const CommonTextfield({
    super.key,
    required this.textController,
    this.onChanged,
    this.keyboardType,
    this.formatters,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CostumeBloc, CostumeState>(
      builder: (context, state) => TextField(
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
        ),
        cursorColor: context.appTheme.colors.secondary,
        keyboardType: keyboardType ?? TextInputType.text,
        inputFormatters: formatters ??
            [
              FilteringTextInputFormatter.allow(RegexHelper.wordsOnly),
            ],
      ),
    );
  }
}
