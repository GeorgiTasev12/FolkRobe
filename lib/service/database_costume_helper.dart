import 'package:folk_robe/constants.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/helpers/database_helper.dart';
import 'package:folk_robe/models/options.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseCostumeHelper extends DatabaseHelper<Costume> {
  static Database? _database;

  // static Future<void> deleteDatabaseFile() async {
  //   final databasesPath = await getDatabasesPath();
  //   final path = join(databasesPath, Constants.databaseName);

  //   await deleteDatabase(path);
  //   _database = null; // Reset cached instance
  // }

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, Constants.databaseName);

    _database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await Future.wait(
          GenderType.values.expand((gender) => Options.values.map((option) {
                final tableName = option.tableCostumeName(gender);

                return db.execute('CREATE TABLE IF NOT EXISTS $tableName ('
                    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                    'title TEXT,'
                    'quantity INTEGER NULL'
                    ')');
              })),
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await Future.wait(
          GenderType.values.expand((gender) => Options.values.map((option) {
                final tableName = option.tableCostumeName(gender);

                return db.execute('CREATE TABLE IF NOT EXISTS $tableName ('
                    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                    'title TEXT'
                    ')');
              })),
        );
      },
    );

    return _database!;
  }

  @override
  String getTableName({required GenderType gender, Options? option}) {
    return option?.tableCostumeName(gender) ?? Options.shopska.name;
  }

  @override
  Costume fromMap(Map<String, dynamic> map) => Costume.fromMap(map);

  @override
  Map<String, dynamic> toMap(Costume costume) => costume.toMap();

  Future<void> close() async {
    if (_database != null) {
      await _database?.close();
      _database = null;
    }
  }
}
