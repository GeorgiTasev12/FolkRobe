import 'package:folk_robe/constants.dart';
import 'package:folk_robe/models/options.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _database;

  /// Returns the shared database instance
  static Future<Database> getInstance() async {
    if (_database != null && _database!.isOpen) return _database!;

    final path = join(await getDatabasesPath(), Constants.databaseName);
    _database = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await _createTables(db);
      },
    );

    return _database!;
  }

  /// Creates all tables (Costumes, Owners, Dancers)
  static Future<void> _createTables(Database db) async {
    // Costume tables
    for (var gender in GenderType.values) {
      for (var option in Options.values) {
        final table = option.tableCostumeName(gender);

        if (table.isEmpty) continue; // Skip invalid table names

        await db.execute('''
          CREATE TABLE IF NOT EXISTS $table (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            quantity INTEGER NULL
          )
        ''');
      }
    }

    // Owner tables
    await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Constants.ownersTableName} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          name TEXT,
          items TEXT NULL,
          quantity INTEGER NULL,
          gender TEXT
        )
      ''');

    // Dancer tables
    await db.execute('''
        CREATE TABLE IF NOT EXISTS ${Constants.dancersTableName} (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          age INTEGER NULL,
          gender TEXT
        )
      ''');
  }

  /// Close the database
  static Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }

  // static Future<void> deleteCurrentDatabase() async {
  //   final path = join(await getDatabasesPath(), Constants.databaseName);
  //   await deleteDatabase(path);
  // }
}
