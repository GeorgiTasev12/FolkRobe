import 'package:flutter/material.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costumes_type_page/widgets/costume_type_item.dart';
import 'package:folk_robe/views/gender_page/page.dart';

class CostumesTypePage extends StatelessWidget {
  const CostumesTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Costume> costumes = [
      Costume(title: 'Шопски'),
    ];

    return CorePage(
      appBarTitle: 'Изберете флоклорната област',
      child: ListViewOfCostumes(costumes: costumes),
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
      itemBuilder: (context, index) => CostumeTypeItem(
        title: costumes[index].title,
        onTap: () => locator<NavigationService>().push(
            MaterialPageRoute(builder: (context) => GenderPage())
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: costumes.length,
    );
  }
}