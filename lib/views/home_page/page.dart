import 'package:flutter/material.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costumes_type_page/page.dart';
import 'package:folk_robe/views/home_page/widgets/main_options_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CorePage(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: RowOfCustomCards(),
            ),
          ],
        ),
      ),
    );
  }
}

class RowOfCustomCards extends StatelessWidget {
  const RowOfCustomCards({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MainOptionCard(
          title: 'Костюми',
          imagePath: "assets/folklore_dress.png",
          onTap: () => locator<NavigationService>().push(
              MaterialPageRoute(builder: (context) => CostumesTypePage())),
        ),
        MainOptionCard(
          title: 'Танцьори',
          imagePath: "assets/folklore_dancers.png",
          onTap: () {},
        ),
      ],
    );
  }
}