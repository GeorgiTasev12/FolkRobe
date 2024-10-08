import 'package:flutter/cupertino.dart';
import 'package:folk_robe/models/costume.dart';

class CostumesListProvider extends ChangeNotifier {
  final List<Costume> _costumesList = [];
  List<Costume> get costumesList => _costumesList;

  void addListItem(String text, TextEditingController controller) {
    _costumesList.add(Costume(title: text));
    controller.clear();
  }
}