import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/common/common_main_options_card.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/dancers_page/dancers_list_page/bloc/dancers_bloc.dart';
import 'package:folk_robe/views/dancers_page/dancers_list_page/page.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/page.dart';

class DancersPage extends StatelessWidget {
  final AgeGroup ageGroup;

  const DancersPage({
    super.key,
    required this.ageGroup,
  });

  @override
  Widget build(BuildContext context) {
    return CorePage(
      appBarTitle: 'Моля изберете опция',
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              child: CommonOptionCard(
                title: 'Добави танцьор',
                icon: Icon(
                  Icons.person_add,
                  size: 60,
                  color: context.appTheme.colors.onSurfaceContainer,
                ),
                onTap: () => locator<NavigationService>().push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => DancersBloc(ageGroup: ageGroup),
                      child: DancersListPage(ageGroup: ageGroup),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: CommonOptionCard(
                title: 'Назначи отговорник',
                icon: Icon(
                  Icons.edit_note,
                  size: 60,
                  color: context.appTheme.colors.onSurfaceContainer,
                ),
                onTap: () => locator<NavigationService>().push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => OwnersBloc(),
                      child: OwnersListPage(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
