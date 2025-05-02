import 'package:folk_robe/constants.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/models/options.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get databaseTest async {
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
      },
    );
    return _database!;
  }

  static Future<Database> get database async {
    if (_database != null) return _database!;

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, Constants.databaseName);

    _database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await Future.wait(
          GenderType.values.expand((gender) => Options.values.map((option) {
                final tableName = option.tableName(gender);

                return db.execute('CREATE TABLE IF NOT EXISTS $tableName ('
                    'id INTEGER PRIMARY KEY AUTOINCREMENT,'
                    'title TEXT'
                    ')');
              })),
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await Future.wait(
          GenderType.values.expand((gender) => Options.values.map((option) {
                final tableName = option.tableName(gender);

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

  Future<int> insertCostume(
      Options option, Costume costume, GenderType gender) async {
    final db = await database;

    try {
      return await db.insert(option.tableName(gender), costume.toMap());
    } on DatabaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Map<String, dynamic>>> queryData(
      Options option, GenderType gender) async {
    final db = await database;

    try {
      return await db.query(option.tableName(gender));
    } on DatabaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<List<Costume>> getAllCostumes(
      Options option, GenderType gender) async {
    final List<Map<String, dynamic>> queries = await queryData(option, gender);

    try {
      return queries.map((e) => Costume.fromMap(e)).toList();
    } on DatabaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<int> updateCostume(
      Options option, Costume costume, GenderType gender) async {
    final db = await database;

    try {
      return await db.update(
        option.tableName(gender),
        costume.toMap(),
        where: 'id = ?',
        whereArgs: [costume.id],
      );
    } on DatabaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<int> deleteCostume(Options option, int id, GenderType gender) async {
    final db = await database;

    try {
      return await db.delete(
        option.tableName(gender),
        where: 'id = ?',
        whereArgs: [id],
      );
    } on DatabaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> close() async {
    if (_database != null) {
      await _database?.close();
      _database = null;
    }
  }
}
