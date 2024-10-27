import 'package:flutter/material.dart';
import 'package:folk_robe/models/costume.dart';
import 'package:folk_robe/service/database_helper.dart';

class CostumesListProvider extends ChangeNotifier {
  final _database = DatabaseHelper();

  final List<Costume> _costumesList = [];
  List<Costume> get costumesList => _costumesList;

  Future<void> addListItem(String text, TextEditingController controller) async {
    final costume = Costume(title: text);

    await _database.insertCostume(costume);
    _costumesList.add(costume);
    controller.clear();
    notifyListeners();
  }
}