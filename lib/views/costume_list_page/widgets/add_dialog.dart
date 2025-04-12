import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';

class ShowAddCostumeButton extends StatelessWidget {
  const ShowAddCostumeButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CostumeListBloc>();

    return BlocBuilder<CostumeListBloc, CostumeListState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.textController != current.textController ||
          previous.costumeList != current.costumeList,
      builder: (context, state) {
        return FloatingActionButton(
          backgroundColor: context.appTheme.colors.surfaceContainer,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Моля, въведете реквизит.'),
                  backgroundColor: context.appTheme.colors.surfaceContainer,
                  content: TextField(
                    controller: state.textController,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        state.textController?.clear();
                        locator<NavigationService>().pop();
                      },
                      child: Text(
                        'Затвори',
                        style:
                            TextStyle(color: context.appTheme.colors.secondary),
                      ),
                    ),
                    FilledButton(
                      onPressed: () {
                        bloc.add(AddCostumeEvent(
                            title: state.textController?.text ?? ""));
                        bloc.add(InitDataEvent());
                        locator<NavigationService>().pop();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: context.appTheme.colors.secondary,
                      ),
                      child: Text(
                        'Запази', // Save button
                        style: TextStyle(
                            color: context.appTheme.colors.surfaceContainer),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Icon(Icons.add),
        );
      },
    );
  }
}
