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

  CostumesListProvider(this._database) : super([]);

  Future<void> addCostume(String text) async {
    final costume = Costume(title: text);
    await _database.insertCostume(costume);
    state = [...state, costume]; // Update state with new list
  }
}