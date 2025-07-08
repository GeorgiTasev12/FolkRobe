import 'package:folk_robe/dao/dancer.dart';
import 'package:folk_robe/helpers/database_helper.dart';
import 'package:folk_robe/models/options.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseDancersHelper extends DatabaseHelper<Dancer> {
  static Database? _database;

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'dancers_database.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await Future.wait(
          GenderType.values.map(
            (gender) {
              final table = tableDancerName(gender);

              return db.execute('CREATE TABLE IF NOT EXISTS $table ('
                  'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                  'name TEXT'
                  ')');
            },
          ),
        );
      },
    );

    return _database!;
  }

  @override
  Dancer fromMap(Map<String, dynamic> map) => Dancer.fromMap(map);

  @override
  Map<String, dynamic> toMap(Dancer dancer) => dancer.toMap();

  @override
  String getTableName({required GenderType gender, Options? option}) =>
      tableDancerName(gender);

  Future<void> close() async {
    if (_database != null) {
      await _database?.close();
      _database = null;
    }
  }
}
