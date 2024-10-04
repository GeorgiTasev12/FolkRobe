import 'package:flutter/material.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/ui/widgets/gender_card.dart';

import 'costumes_page.dart';

class GenderPage extends StatelessWidget {
  const GenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: Padding(
        padding: const EdgeInsets.all(Constants.globalPadding),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GenderCard(
                      title: 'Мъжки носии',
                      icon: Icons.male_rounded,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CostumesPage(),
                        ),
                      ),
                    ),
                    const GenderCard(
                      title: 'Женски носии',
                      icon: Icons.female_rounded,
                      onTap: null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
