import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/helpers/regex_helper.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/bloc/costume_bloc.dart';

class CommonTextfield extends StatelessWidget {
  final void Function(String)? onChanged;

  const CommonTextfield({
    super.key,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CostumeBloc, CostumeState>(
      builder: (context, state) => TextField(
        onChanged: onChanged,
        controller: state.textController,
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
        keyboardType: TextInputType.text,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegexHelper.wordsOnly),
        ],
      ),
    );
  }
}
