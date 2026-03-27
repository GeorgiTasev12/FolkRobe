import 'package:folk_robe/app_database.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/helpers/database_helper.dart';
import 'package:folk_robe/models/options.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCostumeHelper extends DatabaseHelper<Costume> {
  @override
  Future<Database> get database async => await AppDatabase.getInstance();

  @override
  String getTableName({
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) =>
      option?.tableCostumeName(gender, age) ??
      Options.none.tableCostumeName(gender, age);

  @override
  Costume fromMap(Map<String, dynamic> map) => Costume.fromMap(map);

  @override
  Map<String, dynamic> toMap(Costume costume) => costume.toMap();

  @override
  Future<List<Costume>> getAll({
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    final db = await database;

    final result = await db.query(
      getTableName(
        gender: gender,
        option: option,
        age: age,
      ),
    );

    return result.map((map) => fromMap(map)).toList();
  }

  // Fetch costume titles
  static Future<List<String>> getCostumes(
    GenderType? gender,
    Options option,
  ) async {
    final prefix = gender == GenderType.female ? 'female' : 'male';
    final tableName = '${prefix}_costume_${option.name}';
    final tableAlterName = '${Options.other.name}_costume';

    try {
      final result = await AppDatabase.getInstance().then(
        (db) => db.rawQuery(
            'SELECT title FROM ${option != Options.other ? tableName : tableAlterName}'),
      );

      return result.map((costume) => costume['title'] as String).toList();
    } catch (e) {
      throw Exception('Failed to fetch costumes from $tableName: $e');
    }
  }
}
