import 'package:flutter/material.dart';
import 'package:folk_robe/models/costume.dart';
import 'package:folk_robe/ui/gender_page.dart';
import 'package:folk_robe/ui/widgets/costume_item.dart';

class CostumesPage extends StatelessWidget {
  const CostumesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Costume> costumes = [
      Costume(title: 'Шопски'),
      Costume(title: 'Тракийски'),
      Costume(title: 'Северняшки'),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        backgroundColor: Colors.blueGrey,
      ),
      backgroundColor: Colors.blueGrey,
      body: ListView.separated(
        itemBuilder: (context, index) => CostumeItem(
          title: costumes[index].title,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GenderPage()),
            );
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemCount: costumes.length,
      ),
    );
  }
}
