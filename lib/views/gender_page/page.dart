import 'package:flutter/material.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costumes_type_page/page.dart';
import 'package:folk_robe/views/gender_page/widgets/gender_card.dart';

class GenderPage extends StatelessWidget {
  const GenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CorePage(
      appBarTitle: "Изберете тип носии",
      child: const Padding(
        padding: EdgeInsets.all(8),
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
          onTap: () => locator<NavigationService>().push(
            MaterialPageRoute(
              builder: (context) => CostumesTypePage(genderType: GenderType.male,),
            ),
          ),      
        ),
        GenderCard(
          title: 'Женски',
          icon: Icons.female_rounded,
          onTap: () => locator<NavigationService>().push(
            MaterialPageRoute(
              builder: (context) => CostumesTypePage(genderType: GenderType.female),
            ),
          ),
        ),
      ],
    );
  }
}