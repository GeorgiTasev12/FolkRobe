import 'package:folk_robe/constants.dart';
import 'package:folk_robe/models/costume.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, Constants.databaseName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE ${Constants.tableName} ('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'title TEXT'
            ')');
      }
    );
    return _database!;
  }

  Future<int> insertCostume(Costume costume) async {
    final db = await database;

    return await db.insert(Constants.tableName, costume.toMap());
  }

  Future<List<Map<String, dynamic>>> queryData() async {
    final db = await database;
    return await db.query(Constants.tableName);
  }

  Future<void> close() async {
    if (_database != null) {
      await _database?.close();
      _database = null;
    }
  }
}
