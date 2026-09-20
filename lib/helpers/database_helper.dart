import 'package:folk_robe/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:folk_robe/models/options.dart';

abstract class DatabaseHelper<T> {
  Future<Database> get database => _DatabaseManager().database;

  String getTableName({
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  });

  T fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap(T item);

  Future<int> insert({
    required T item,
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    final db = await database;

    return await db.insert(
        getTableName(
          gender: gender,
          option: option,
          age: age,
        ),
        toMap(item));
  }

  Future<List<T>> getAll({
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    final db = await database;

    List<String> whereClauses = [];
    List<dynamic> whereArgs = [];

    if (gender != null && gender != GenderType.none) {
      whereClauses.add('gender = ?');
      whereArgs.add(gender.name); // or your mapping
    }

    if (age != null) {
      whereClauses.add('ageGroup = ?');
      whereArgs.add(age.name); // IMPORTANT: must match stored value
    }

    final result = await db.query(
      getTableName(
        gender: gender,
        option: option,
        age: age,
      ),
      where: whereClauses.isNotEmpty ? whereClauses.join(' AND ') : null,
      whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
    );

    return result.map((map) => fromMap(map)).toList();
  }

  Future<int> update({
    required T item,
    required int id,
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    final db = await database;

    return await db.update(
      getTableName(
        gender: gender,
        option: option,
        age: age,
      ),
      toMap(item),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete({
    required int id,
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    final db = await database;

    return await db.delete(
      getTableName(
        gender: gender,
        option: option,
        age: age,
      ),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

class _DatabaseManager {
  static final _DatabaseManager _instance = _DatabaseManager._internal();
  factory _DatabaseManager() => _instance;
  _DatabaseManager._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    final path = join(await getDatabasesPath(), Constants.databaseName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // Create all tables
        await _createCostumeTables(db);
        await _createOwnerTables(db);
        await _createDancerTables(db);
      },
    );

    return _database!;
  }

  Future<void> close() async {
    if (_database != null) {
      await _database?.close();
      _database = null;
    }
  }

  Future<void> _createCostumeTables(Database db) async {
    for (var gender in GenderType.values) {
      for (var option in Options.values) {
        for (var age in AgeGroup.values) {
          final table = option.tableCostumeName(gender, age);

          await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            quantity INTEGER,
            itemCheck INTEGER NULL
          )
        ''');
        }
      }
    }
  }

  Future<void> _createOwnerTables(Database db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Constants.ownersTableName} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          name TEXT,
          items TEXT,
          gender TEXT,
          quantity INTEGER,
          ageGroup TEXT
        )
      ''');
  }

  Future<void> _createDancerTables(Database db) async {
    await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Constants.dancersTableName} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          gender TEXT,
          ageGroup TEXT
        )
      ''');
  }
}
