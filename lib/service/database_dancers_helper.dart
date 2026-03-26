import 'package:folk_robe/app_database.dart';
import 'package:folk_robe/constants.dart';
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
  String getTableName({
    AgeGroup? age,
    GenderType? gender,
    Options? option,
  }) =>
      Constants.dancersTableName;

  static Future<List<String>> getDancersNames(
    GenderType gender,
    AgeGroup ageGroup,
  ) async {
    try {
      final db = await AppDatabase.getInstance();
      final result = await db.rawQuery(
        "SELECT name FROM ${Constants.dancersTableName} WHERE gender = ? AND ageGroup = ?",
        [
          gender.name,
          ageGroup.name,
        ],
      );

      return result.map((dancer) => dancer['name'] as String).toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Dancer>> getFilteredDancers({
    required GenderType gender,
    required AgeGroup ageGroup,
  }) async {
    try {
      final db = await AppDatabase.getInstance();
      Future<List<Map<String, Object?>>> result;

      switch (gender) {
        case GenderType.male:
          result = db.rawQuery(
            'SELECT * FROM ${Constants.dancersTableName} WHERE gender = ? AND ageGroup = ?',
            [GenderType.male.name, ageGroup.name],
          );
          break;
        case GenderType.female:
          result = db.rawQuery(
            'SELECT * FROM ${Constants.dancersTableName} WHERE gender = ? AND ageGroup = ?',
            [GenderType.female.name, ageGroup.name],
          );
          break;
        default:
          result = db.rawQuery(
              'SELECT * FROM ${Constants.dancersTableName} WHERE ageGroup = ?',
              [ageGroup.name]);
          break;
      }

      final dancersList = await result;
      return dancersList.map((dancerMap) => Dancer.fromMap(dancerMap)).toList();
    } on DatabaseException catch (dbError) {
      throw Exception(dbError);
    } catch (e) {
      throw Exception(e);
    }
  }
}
