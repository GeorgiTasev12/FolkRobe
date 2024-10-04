import 'package:flutter/material.dart';
import 'package:folk_robe/ui/gender_page.dart';
import 'package:folk_robe/ui/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomCard(
                      title: 'Костюми',
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const GenderPage(),
                        ),
                      ),
                    ),
                    CustomCard(
                      title: 'Танцьори',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}