import 'package:flutter/material.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/select_age_page/page.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/common/common_main_options_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CorePage(
      hasAppBar: false,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: CommonOptionCard(
                    title: 'Костюми',
                    imagePath: "assets/folklore_dress.png",
                    onTap: () => locator<NavigationService>().push(
                      MaterialPageRoute(
                        builder: (context) => SelectAgePage(pageSource: PageSource.costumes),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: CommonOptionCard(
                    title: 'Танцьори',
                    imagePath: "assets/folklore_dancers.png",
                    onTap: () => locator<NavigationService>().push(
                      MaterialPageRoute(
                        builder: (context) => SelectAgePage(pageSource: PageSource.dancers)
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
