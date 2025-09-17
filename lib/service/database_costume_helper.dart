import 'package:folk_robe/app_database.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/helpers/database_helper.dart';
import 'package:folk_robe/models/options.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCostumeHelper extends DatabaseHelper<Costume> {
  @override
  Future<Database> get database async => await AppDatabase.getInstance();

  @override
  String getTableName({GenderType? gender, Options? option}) =>
      option?.tableCostumeName(gender) ??
      Options.shopska.tableCostumeName(gender);

  @override
  Costume fromMap(Map<String, dynamic> map) => Costume.fromMap(map);

  @override
  Map<String, dynamic> toMap(Costume costume) => costume.toMap();

  /// Fetch costume titles
  static Future<List<String>> getCostumes(
    GenderType? gender,
    Options option,
  ) async {
    final prefix = gender == GenderType.female ? 'female' : 'male';
    final tableName = '${prefix}_costume_${option.name}';

    try {
      final result = await AppDatabase.getInstance().then(
        (db) => db.rawQuery('SELECT title FROM $tableName'),
      );

      return result.map((costume) => costume['title'] as String).toList();
    } catch (e) {
      throw Exception('Failed to fetch costumes from $tableName: $e');
    }
  }
}
