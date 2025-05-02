import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/bloc/costume_bloc.dart';
import 'package:folk_robe/views/costume_list_page/page.dart';
import 'package:folk_robe/views/costumes_type_page/widgets/costume_type_item.dart';

class CostumesTypePage extends StatelessWidget {
  final GenderType genderType;

  const CostumesTypePage({
    super.key,
    required this.genderType,
  });

  @override
  Widget build(BuildContext context) {
    final options = Options.values;

    return CorePage(
      appBarTitle: 'Изберете фолклорната област',
      child: ListView.separated(
      itemCount: options.length,
      separatorBuilder: (context, index) => const SizedBox(height: 6),
      itemBuilder: (context, index) {
        final option = options[index];

        return CostumeTypeItem(
          title: option.optionName,
          onTap: () => locator<NavigationService>().push(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (_) => CostumeListBloc(
                  selectedOption: option,
                  genderType: genderType,
                ),
                child: const CostumeListPage(),
              ),
            ),
          ),
        );
      },
    ),
    );
  }
}