import 'package:folk_robe/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:folk_robe/models/options.dart';

abstract class DatabaseHelper<T> {
  Future<Database> get database => _DatabaseManager().database;

  String getTableName({required GenderType gender, Options? option});

  T fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap(T item);

  Future<int> insert({
    required GenderType gender,
    required T item,
    Options? option,
  }) async {
    final db = await database;

    return await db.insert(
        getTableName(
          gender: gender,
          option: option,
        ),
        toMap(item));
  }

  Future<List<T>> getAll({
    required GenderType gender,
    Options? option,
  }) async {
    final db = await database;
    final result = await db.query(getTableName(
      gender: gender,
      option: option,
    ));

    return result.map((map) => fromMap(map)).toList();
  }

  Future<int> update({
    required GenderType gender,
    required T item,
    Options? option,
    required int id,
  }) async {
    final db = await database;

    return await db.update(
      getTableName(gender: gender, option: option),
      toMap(item),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete({
    required GenderType gender,
    Options? option,
    required int id,
  }) async {
    final db = await database;
    
    return await db.delete(
      getTableName(gender: gender, option: option),
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
        final table = option.tableCostumeName(gender);
        await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            quantity INTEGER
          )
        ''');
      }
    }
  }

  Future<void> _createOwnerTables(Database db) async {
    for (var gender in GenderType.values) {
      final table = tableOwnersName(gender);
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          name TEXT,
          items TEXT,
          quantity INTEGER
        )
      ''');
    }
  }

  Future<void> _createDancerTables(Database db) async {
    for (var gender in GenderType.values) {
      final table = tableDancerName(gender);
      await db.execute('''
        CREATE TABLE IF NOT EXISTS $table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT
        )
      ''');
    }
  }
}
