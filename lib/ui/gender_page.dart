import 'package:flutter/material.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/ui/widgets/gender_card.dart';

class GenderPage extends StatelessWidget {
  const GenderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Изберете тип носии',
          softWrap: true,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Constants.fontSizeTitleAppBar,
            color: Colors.white,
          ),
        ),
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
      body: const Padding(
        padding: EdgeInsets.all(Constants.globalPadding),
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
          onTap: () => Navigator.of(context)
              .pushNamed(Constants.costumesListPageRouteString),
        ),
        const GenderCard(
          title: 'Женски',
          icon: Icons.female_rounded,
          onTap: null,
        ),
      ],
    );
  }
}
