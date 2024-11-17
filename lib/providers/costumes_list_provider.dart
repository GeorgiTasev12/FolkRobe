import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folk_robe/models/costume.dart';
import 'package:folk_robe/service/database_helper.dart';

final costumesProvider = StateNotifierProvider<CostumesListProvider, List<Costume>>((ref) {
  return CostumesListProvider(ref.read(databaseHelperProvider));
});

final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper();
});

class CostumesListProvider extends StateNotifier<List<Costume>> {
  final DatabaseHelper _database;

  CostumesListProvider(this._database) : super([]) {
    _initData();
  }

  Future<void> _initData() async {
    try {
      final costumes = await _database.queryData();
      state = costumes.map((e) => Costume.fromMap(e)).toList();
    } on Exception catch(e) {
      if (kDebugMode) print("Error loading costumes: $e");
    }
  }

  Future<void> addCostume(String text) async {
    try {
      final costume = Costume(title: text);
      await _database.insertCostume(costume);
      state = List.from(state)..add(costume); // Update state with new list
    } on Exception catch (e) {
      if (kDebugMode) print("Error adding costume: $e");
    }
  }
}
