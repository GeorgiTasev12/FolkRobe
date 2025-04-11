import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';

class DeleteDialog extends StatelessWidget {
  final int index;

  const DeleteDialog({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CostumeListBloc>();

    return BlocBuilder<CostumeListBloc, CostumeListState>(
      bloc: bloc,
      buildWhen: (previous, current) => previous.id != current.id,
      builder: (context, state) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text("Внимание"),
          content: Text(
              "Вие сте на път да премахнете определен елемент на костюма. След това няма да можете да го върнете. Желаете ли да продължите с операцията ?"),
          actions: [
            TextButton(
              onPressed: () => locator<NavigationService>().pop(),
              child: Text(
                  "Не",
                  style: TextStyle(color: Colors.lightBlue)
              ),
            ),
            TextButton(
              onPressed: () {
                bloc.add(RemoveCostumeEvent(id: index));
                bloc.add(InitDataEvent());
                locator<NavigationService>().pop();
              },
              child: Text(
                  "Да",
                  style: TextStyle(color: Colors.lightBlue)
              ),
            ),
          ],
        );
      },
    );
  }
}
