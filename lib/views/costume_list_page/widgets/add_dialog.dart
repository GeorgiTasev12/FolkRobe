import 'package:flutter/material.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/views/costume_list_page/providers/costumes_list_provider.dart';

class ShowAddCostumeButton extends StatelessWidget {
  final CostumesListProvider? costumes;

  const ShowAddCostumeButton({
    super.key,
    this.costumes,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.white,
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Моля, въведете реквизит.'),
            backgroundColor: Colors.white,
            content: TextField(
              controller: costumes?.textController,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Затвори',
                    style: TextStyle(color: Colors.lightBlue),
                  )),
              TextButton(
                onPressed: () {
                  costumes?.addCostume(costumes?.textController.text ?? "");
                  Navigator.pop(context);
                },
                child: const Text(
                  'Запази',
                  style: TextStyle(color: Colors.lightBlue),
                ),
              ),
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.circularRadius),
      ),
      child: const Icon(Icons.add),
    );
  }
}