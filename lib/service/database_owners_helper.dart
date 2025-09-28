import 'package:folk_robe/app_database.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/helpers/database_helper.dart';
import 'package:folk_robe/models/options.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseOwnersHelper extends DatabaseHelper<Owner> {
  @override
  Future<Database> get database async => await AppDatabase.getInstance();

  @override
  Owner fromMap(Map<String, dynamic> map) => Owner.fromMap(map);

  @override
  String getTableName({GenderType? gender, Options? option}) =>
      Constants.ownersTableName;

  @override
  Map<String, dynamic> toMap(Owner owner) => owner.toMap();

  static Future<List<Owner>> getFilteredOwners({
    required GenderType gender,
  }) async {
    try {
      final db = await AppDatabase.getInstance();
      Future<List<Map<String, Object?>>> result;

      switch (gender) {
        case GenderType.male:
          result = db.rawQuery(
            'SELECT * FROM ${Constants.ownersTableName} WHERE gender = ?',
            [GenderType.male.name],
          );
          break;
        case GenderType.female:
          result = db.rawQuery(
            'SELECT * FROM ${Constants.ownersTableName} WHERE gender = ?',
            [GenderType.female.name],
          );
          break;
        default:
          result = db.rawQuery(
            'SELECT * FROM ${Constants.ownersTableName}',
          );
          break;
      }

      final ownersList = await result;
      return ownersList.map((ownerMap) => Owner.fromMap(ownerMap)).toList();
    } on DatabaseException catch (dbError) {
      throw Exception(dbError);
    } catch (e) {
      throw Exception(e);
    }
  }
}
