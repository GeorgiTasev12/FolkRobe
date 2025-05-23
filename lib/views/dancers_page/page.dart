import 'package:flutter/material.dart';
import 'package:folk_robe/common/common_main_options_card.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';

class DancersPage extends StatelessWidget {
  const DancersPage({super.key});

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
              child: CommonMainOptionCard(
                title: 'Добави танцьори',
                icon: Icon(
                  Icons.person_add,
                  size: 60,
                  color: context.appTheme.colors.onSurfaceContainer,
                ),
                onTap: null,
              ),
            ),
            Flexible(
              child: CommonMainOptionCard(
                title: 'Назначи отговорник',
                icon: Icon(
                  Icons.edit_note,
                  size: 60,
                  color: context.appTheme.colors.onSurfaceContainer,
                ),
                onTap: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}