import 'package:folk_robe/app_database.dart';
import 'package:folk_robe/dao/dancer.dart';
import 'package:folk_robe/helpers/database_helper.dart';
import 'package:folk_robe/models/options.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDancersHelper extends DatabaseHelper<Dancer> {
  @override
  Future<Database> get database async => await AppDatabase.getInstance();

  @override
  Dancer fromMap(Map<String, dynamic> map) => Dancer.fromMap(map);

  @override
  Map<String, dynamic> toMap(Dancer dancer) => dancer.toMap();

  @override
  String getTableName({required GenderType gender, Options? option}) =>
      tableDancerName(gender);

  static Future<List<String>> getDancersNames(GenderType gender) async {
    final prefix = gender == GenderType.female ? 'female' : 'male';

    try {
      final result = await AppDatabase.getInstance().then(
        (db) => db.rawQuery('SELECT name FROM ${prefix}_dancer'),
      );

      return result.map((dancer) => dancer['name'] as String).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
