import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/models/costume.dart';
import 'package:folk_robe/providers/costumes_list_provider.dart';
import 'package:folk_robe/ui/widgets/costume_item.dart';


class CostumeListPage extends StatelessWidget {
  const CostumeListPage({super.key});

  @override
  Widget build(BuildContext context) => ProviderScope(
        child: _CostumeListPageState(),
      );
}

class _CostumeListPageState extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final costumes = ref.watch(costumesProvider);
    final addCostume = ref.watch(costumesProvider.notifier);

    return Scaffold(
      floatingActionButton: ShowAddCostumeButton(
        costumes: addCostume,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: costumes.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(Constants.globalPadding),
              child: Center(
                child: FloatingButtonWidget(),
              ),
            )
          : ListViewOfCostumeItems(costumes: costumes),
    );
  }
}

class ShowAddCostumeButton extends StatelessWidget {
  final CostumesListProvider costumes;

  const ShowAddCostumeButton({
    super.key,
    required this.costumes,
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
            content: TextField(
              controller: costumes.textController,
            ),
            actions: _alertDialogTextButtons(
              context,
              costumes.textController,
              costumes,
            ),
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

List<Widget> _alertDialogTextButtons(
  BuildContext context,
  TextEditingController controller,
  CostumesListProvider costumes,
) {
  return [
    TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text(
          'Затвори',
          style: TextStyle(color: Colors.lightBlue),
        )),
    TextButton(
      onPressed: () {
        costumes.addCostume(controller.text);
        Navigator.pop(context);
      },
      child: const Text(
        'Запази',
        style: TextStyle(color: Colors.lightBlue),
      ),
    ),
  ];
}

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Имате празен инвентар от риквизити, моля добавте като натискате:',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white54,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 15),
        Icon(
          Icons.add,
          color: Colors.white54,
          size: 32,
        ),
      ],
    );
  }
}

class ListViewOfCostumeItems extends StatelessWidget {
  final List<Costume> costumes;

  const ListViewOfCostumeItems({
    super.key,
    required this.costumes,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: costumes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return CostumeItem(
          title: costumes[index].title,
          onTap: null,
        );
      },
    );
  }
}
