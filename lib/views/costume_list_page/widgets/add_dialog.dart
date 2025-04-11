import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
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
      buildWhen: (previous, current) => previous.textController != current.textController
        || previous.costumeList != current.costumeList,
      builder: (context, state) {
        return FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Моля, въведете реквизит.'),
                  backgroundColor: Colors.white,
                  content: TextField(
                    controller: state.textController,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        state.textController?.clear();
                        locator<NavigationService>().pop();
                      },
                      child: const Text(
                        'Затвори',
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        bloc.add(AddCostumeEvent(title: state.textController?.text ?? ""));
                        bloc.add(InitDataEvent());
                        locator<NavigationService>().pop();
                      },
                      child: const Text(
                        'Запази', // Save button
                        style: TextStyle(color: Colors.lightBlue),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.circularRadius),
          ),
          child: const Icon(Icons.add),
        );
      },
    );
  }
}