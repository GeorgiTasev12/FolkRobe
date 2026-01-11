import 'package:flutter/material.dart';
import 'package:folk_robe/helpers/screen_size_helper.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costumes_type_page/page.dart';
import 'package:folk_robe/views/gender_page/widgets/gender_card.dart';

class GenderPage extends StatelessWidget {
  final AgeGroup age;

  const GenderPage({
    super.key,
    required this.age,
  });

  @override
  Widget build(BuildContext context) {
    return CorePage(
      appBarTitle: "Изберете тип носии за ${age.agesName}",
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Center(
          child: ScreenSizeHelper(context).isSmall
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GenderCard(
                      title: 'Мъжки',
                      icon: Icons.male_rounded,
                      onTap: () => locator<NavigationService>().push(
                        MaterialPageRoute(
                          builder: (context) => CostumesTypePage(
                            genderType: GenderType.male,
                            ageType: age,
                          ),
                        ),
                      ),
                    ),
                    GenderCard(
                      title: 'Женски',
                      icon: Icons.female_rounded,
                      onTap: () => locator<NavigationService>().push(
                        MaterialPageRoute(
                          builder: (context) => CostumesTypePage(
                            genderType: GenderType.female,
                            ageType: age,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: GenderCard(
                        title: 'Мъжки',
                        icon: Icons.male_rounded,
                        onTap: () => locator<NavigationService>().push(
                          MaterialPageRoute(
                            builder: (context) => CostumesTypePage(
                              genderType: GenderType.male,
                              ageType: age,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: GenderCard(
                        title: 'Женски',
                        icon: Icons.female_rounded,
                        onTap: () => locator<NavigationService>().push(
                          MaterialPageRoute(
                            builder: (context) => CostumesTypePage(
                              genderType: GenderType.female,
                              ageType: age,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
