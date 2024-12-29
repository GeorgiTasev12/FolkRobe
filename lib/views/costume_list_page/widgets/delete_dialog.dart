import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/costume.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/costume_list_page/providers/costumes_list_provider.dart';

class DeleteDialog extends StatelessWidget {
  final List<Costume> costumes;
  final WidgetRef widgetRef;
  final int index;

  const DeleteDialog({
    super.key,
    required this.costumes,
    required this.widgetRef,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text("Внимание"),
      content: Text("Вие сте на път да премахнете определен елемент на костюма. След това няма да можете да го върнете. Желаете ли да продължите с операцията ?"),
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
            widgetRef.watch(costumesProvider.notifier).deleteCostume(costumes[index].id ?? index);
            locator<NavigationService>().pop();
          },
          child: Text(
              "Да",
              style: TextStyle(color: Colors.lightBlue)
          ),
        ),
      ],
    );
  }
}
