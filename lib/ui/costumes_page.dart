import 'package:flutter/material.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/models/costume.dart';
import 'package:folk_robe/ui/widgets/costume_item.dart';

class CostumesPage extends StatelessWidget {
  const CostumesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Costume> costumes = [
      Costume(title: 'Шопски'),
      Costume(title: 'Тракийски'),
      Costume(title: 'Северняшки'),
      Costume(title: 'Пирински'),
      Costume(title: 'Странджански'),
      Costume(title: 'Добруджански'),
      Costume(title: 'Родопска'),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Изберете флоклорната област за \nмъжките носии',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Constants.fontSizeTitleAppBar,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: ListViewOfCostumes(costumes: costumes),
    );
  }
}

class ListViewOfCostumes extends StatelessWidget {
  const ListViewOfCostumes({
    super.key,
    required this.costumes,
  });

  final List<Costume> costumes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => CostumeItem(
        title: costumes[index].title,
        onTap: () => Navigator.of(context).pushNamed(
          Constants.genderPageRouteString,
        ),
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(height: Constants.sizedBoxHeight),
      itemCount: costumes.length,
    );
  }
}
