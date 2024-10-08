import 'package:flutter/material.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/providers/costumesList_provider.dart';
import 'package:folk_robe/ui/widgets/costume_item.dart';
import 'package:provider/provider.dart';

class CostumeListPage extends StatefulWidget {
  const CostumeListPage({super.key});

  @override
  State<CostumeListPage> createState() => _CostumeListPageState();
}

class _CostumeListPageState extends State<CostumeListPage> {
  TextEditingController controller = TextEditingController();

  CostumesListProvider? costumesListProvider;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      costumesListProvider = Provider.of<CostumesListProvider>(context, listen: false);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    costumesListProvider?.dispose();
    costumesListProvider = null;
  }

  @override
  Widget build(BuildContext context) {
    final costumesListProvider = Provider.of<CostumesListProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Моля, въведете реквизит.'),
              content: TextField(
                controller: controller,
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
                      setState(() {
                        costumesListProvider.addListItem(controller.text, controller);
                        Navigator.pop(context);
                      });
                    },
                    child: const Text(
                      'Запази',
                      style: TextStyle(color: Colors.lightBlue),
                    )),
              ],
            ),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.circularRadius),
        ),
        child: const Icon(Icons.add),
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
      body: costumesListProvider.costumesList.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(Constants.globalPadding),
              child: Center(
                child: Column(
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
                ),
              ),
            )
          : ListView.separated(
              itemCount: costumesListProvider.costumesList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return CostumeItem(
                  title: costumesListProvider.costumesList[index].title,
                  onTap: null,
                );
              },
            ),
    );
  }
}
