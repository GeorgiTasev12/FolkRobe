import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';

class UpdateDialog extends StatelessWidget {
  final int index;

  const UpdateDialog({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CostumeListBloc, CostumeListState>(
      builder: (context, state) {
        final bloc = context.read<CostumeListBloc>();

        return AlertDialog(
          title: const Text('Моля, въведете реквизит за промяна.'),
          backgroundColor: context.appTheme.colors.surfaceContainer,
          content: TextField(
            controller: state.textController,
            onChanged: (text) => state.textController?.text = text,
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
              onPressed: () {
                bloc.add(UpdateCostumeEvent(
                    title: state.textController?.text ?? "", id: index));
                bloc.add(InitDataEvent());
                locator<NavigationService>().pop();
              },
              style: FilledButton.styleFrom(
                backgroundColor: context.appTheme.colors.secondary,
              ),
              child: Text(
                'Запази', // Save button
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
