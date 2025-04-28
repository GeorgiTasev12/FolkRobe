import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';
import 'package:folk_robe/views/costume_list_page/page.dart';
import 'package:folk_robe/views/costumes_type_page/widgets/costume_type_item.dart';

class CostumesTypePage extends StatelessWidget {
  const CostumesTypePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CorePage(
      appBarTitle: 'Изберете флоклорната област',
      child: ListViewOfCostumes(
        options: [
          Options.shopski,
          Options.trakiski,
        ],
      ),
    );
  }
}

class ListViewOfCostumes extends StatelessWidget {
  final List<Options> options;

  const ListViewOfCostumes({
    super.key,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => CostumeTypeItem(
        title: options[index].optionName,
        onTap: () => locator<NavigationService>().push(
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => CostumeListBloc(
                  selectedOption:
                      index == 0 ? Options.shopski : Options.trakiski),
              child: CostumeListPage(),
            ),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: options.length,
    );
  }
}
