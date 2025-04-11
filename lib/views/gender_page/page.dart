import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';
import 'package:folk_robe/views/costume_list_page/page.dart';
import 'package:folk_robe/views/gender_page/widgets/gender_card.dart';

class GenderPage extends StatelessWidget {
  const GenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CorePage(
      appBarTitle: "Изберете тип носии",
      child: const Padding(
        padding: EdgeInsets.all(Constants.globalPadding),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: RowOfGenderCards(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowOfGenderCards extends StatelessWidget {
  const RowOfGenderCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GenderCard(
          title: 'Мъжки',
          icon: Icons.male_rounded,
          onTap: () =>
              locator<NavigationService>().push(
                MaterialPageRoute(
                  builder: (context) =>
                      BlocProvider(
                        create: (context) => CostumeListBloc(),
                        child: CostumeListPage(),
                      ),
                ),
              ),
        ),
        const GenderCard(
          title: 'Женски',
          icon: Icons.female_rounded,
          onTap: null,
        ),
      ],
    );
  }
}