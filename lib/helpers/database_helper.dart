import 'package:sqflite/sqflite.dart';
import 'package:folk_robe/models/options.dart';

abstract class DatabaseHelper<T> {
  Future<Database> get database;

  String getTableName({required GenderType gender, Options? option});

  T fromMap(Map<String, dynamic> map);

  Map<String, dynamic> toMap(T item);

  Future<int> insert({
    required GenderType gender,
    Options? option,
    required T item,
  }) async {
    final db = await database;
    return await db.insert(getTableName(gender: gender, option: option), toMap(item));
  }

  Future<List<T>> getAll({
    required GenderType gender,
    Options? option,
  }) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query(getTableName(gender: gender, option: option));
    return result.map(fromMap).toList();
  }

  Future<int> update({
    required GenderType gender,
    Options? option,
    required T item,
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