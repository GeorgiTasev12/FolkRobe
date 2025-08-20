import 'package:folk_robe/constants.dart';
import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/helpers/database_helper.dart';
import 'package:folk_robe/models/options.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseOwnersHelper extends DatabaseHelper<Owner> {
  static Database? _database;

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, Constants.databaseName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        try {
          await Future.wait(
            GenderType.values.map(
              (gender) {
                final table = tableOwnersName(gender);

                return db.execute('CREATE TABLE IF NOT EXISTS $table ('
                    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                    'title TEXT,'
                    'name TEXT,'
                    'items TEXT NULL,'
                    'quantity INTEGER NULL'
                    ')');
              },
            ),
          );
        } on DatabaseException catch (e) {
          throw Exception(e);
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        try {
          await Future.wait(
            GenderType.values.map(
              (gender) {
                final table = tableOwnersName(gender);

                return db.execute('CREATE TABLE IF NOT EXISTS $table ('
                    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                    'title TEXT,'
                    'name TEXT,'
                    'quantity INTEGER NULL'
                    ')');
              },
            ),
          );
        } on DatabaseException catch (e) {
          throw Exception(e);
        }
      },
    );

    return _database!;
  }

  @override
  Owner fromMap(Map<String, dynamic> map) => Owner.fromMap(map);

  @override
  String getTableName({required GenderType gender, Options? option}) =>
      tableOwnersName(gender);

  @override
  Map<String, dynamic> toMap(Owner owner) => owner.toMap();

  Future<void> close() async {
    if (_database != null) {
      await _database?.close();
      _database = null;
    }
  }
}
