import 'package:flutter/material.dart';
import 'package:folk_robe/ui/widgets/gender_card.dart';

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
      body: const Flexible(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GenderCard(title: 'Мъжки носии', icon: Icons.male_rounded),
                GenderCard(title: 'Женски носии', icon: Icons.female_rounded),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
