import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/helpers/screen_size_helper.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/models/page_source.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costumes_type_page/page.dart';
import 'package:folk_robe/views/dancers_page/dancers_list_page/page.dart';
import 'package:folk_robe/views/dancers_page/dancers_list_page/bloc/dancers_bloc.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';
import 'package:folk_robe/views/gender_page/widgets/gender_card.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/page.dart';

class GenderPage extends StatelessWidget {
  final PageSource pageSource;

  const GenderPage({super.key, required this.pageSource});

  @override
  Widget build(BuildContext context) {
    return CorePage(
      appBarTitle: pageSource == PageSource.homePage
          ? "Изберете тип носии"
          : pageSource == PageSource.dancersPage
              ? "Изберете тип танцьори"
              : pageSource == PageSource.ownersPage
                  ? "Изберете тип отговорници"
                  : "",
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
                      onTap: () {
                        switch (pageSource) {
                          case PageSource.homePage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => CostumesTypePage(
                                  genderType: GenderType.male,
                                ),
                              ),
                            );
                            break;
                          case PageSource.dancersPage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      DancersBloc(genderType: GenderType.male),
                                  child: DancersListPage(
                                    genderType: GenderType.male,
                                  ),
                                ),
                              ),
                            );
                            break;
                          case PageSource.ownersPage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => OwnersBloc(
                                    genderType: GenderType.male,
                                  ),
                                  child: OwnersListPage(
                                    genderType: GenderType.male,
                                  ),
                                ),
                              ),
                            );
                            break;
                        }
                      },
                    ),
                    GenderCard(
                      title: 'Женски',
                      icon: Icons.female_rounded,
                      onTap: () {
                        switch (pageSource) {
                          case PageSource.homePage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => CostumesTypePage(
                                  genderType: GenderType.female,
                                ),
                              ),
                            );
                          case PageSource.dancersPage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => DancersBloc(
                                      genderType: GenderType.female),
                                  child: DancersListPage(
                                    genderType: GenderType.female,
                                  ),
                                ),
                              ),
                            );
                          case PageSource.ownersPage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => OwnersBloc(
                                    genderType: GenderType.female,
                                  ),
                                  child: OwnersListPage(
                                    genderType: GenderType.female,
                                  ),
                                ),
                              ),
                            );
                        }
                      },
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GenderCard(
                      title: 'Мъжки',
                      icon: Icons.male_rounded,
                      onTap: () {
                        switch (pageSource) {
                          case PageSource.homePage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => CostumesTypePage(
                                  genderType: GenderType.male,
                                ),
                              ),
                            );
                            break;
                          case PageSource.dancersPage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) =>
                                      DancersBloc(genderType: GenderType.male),
                                  child: DancersListPage(
                                    genderType: GenderType.male,
                                  ),
                                ),
                              ),
                            );
                            break;
                          case PageSource.ownersPage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => OwnersBloc(
                                    genderType: GenderType.male,
                                  ),
                                  child: OwnersListPage(
                                    genderType: GenderType.male,
                                  ),
                                ),
                              ),
                            );
                            break;
                        }
                      },
                    ),
                    GenderCard(
                      title: 'Женски',
                      icon: Icons.female_rounded,
                      onTap: () {
                        switch (pageSource) {
                          case PageSource.homePage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => CostumesTypePage(
                                  genderType: GenderType.female,
                                ),
                              ),
                            );
                          case PageSource.dancersPage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => DancersBloc(
                                      genderType: GenderType.female),
                                  child: DancersListPage(
                                    genderType: GenderType.female,
                                  ),
                                ),
                              ),
                            );
                          case PageSource.ownersPage:
                            locator<NavigationService>().push(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => OwnersBloc(
                                    genderType: GenderType.female,
                                  ),
                                  child: OwnersListPage(
                                    genderType: GenderType.female,
                                  ),
                                ),
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
