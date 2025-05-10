import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/bloc/costume_bloc.dart';
import 'package:folk_robe/common/common_textfield.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CommonDialog extends StatelessWidget {
  final void Function() onPressed;

  const CommonDialog({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CostumeBloc>();

    return BlocBuilder<CostumeBloc, CostumeState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.textController != current.textController ||
          previous.costumeList != current.costumeList,
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Моля, въведете реквизит.'),
          backgroundColor: context.appTheme.colors.surfaceContainer,
          content: BlocProvider.value(
            value: bloc,
            child: CommonTextfield(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                state.textController?.clear();
                locator<NavigationService>().pop();
              },
              child: Text(
                'Затвори',
                style: TextStyle(color: context.appTheme.colors.secondary),
              ),
            ),
            FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                backgroundColor: context.appTheme.colors.secondary,
              ),
              child: Text(
                'Запази',
                style:
                    TextStyle(color: context.appTheme.colors.surfaceContainer),
              ),
            ),
          ],
        );
      },
    );
  }
}
