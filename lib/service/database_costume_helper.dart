import 'package:folk_robe/app_database.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/helpers/database_helper.dart';
import 'package:folk_robe/models/modify_quantity.dart';
import 'package:folk_robe/models/options.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseCostumeHelper extends DatabaseHelper<Costume> {
  @override
  Future<Database> get database async => await AppDatabase.getInstance();

  @override
  String getTableName({
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) =>
      option?.tableCostumeName(gender, age) ??
      Options.none.tableCostumeName(gender, age);

  @override
  Costume fromMap(Map<String, dynamic> map) => Costume.fromMap(map);

  @override
  Map<String, dynamic> toMap(Costume costume) => costume.toMap();

  @override
  Future<List<Costume>> getAll({
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    final db = await database;

    final result = await db.query(
      getTableName(
        gender: gender,
        option: option,
        age: age,
      ),
    );

    return result.map((map) => fromMap(map)).toList();
  }

  // Fetch costume titles
  static Future<List<String>> getCostumes(
    GenderType? gender,
    Options option,
    AgeGroup? ageGroup,
  ) async {
    final tableCostumesName = option.tableCostumeName(gender, ageGroup);
    final tableAlterName = '${Options.other.name}_costume';

    try {
      final result = await AppDatabase.getInstance().then(
        (db) => db.rawQuery(
            'SELECT title FROM ${option != Options.other ? tableCostumesName : tableAlterName}'),
      );

      return result.map((costume) => costume['title'] as String).toList();
    } catch (e) {
      throw Exception('Failed to fetch costumes from $tableCostumesName: $e');
    }
  }

  // Return one quantiy
  Future<void> modifyQuantityCostumes({
    required String quantityAdded,
    GenderType? genderType,
    Options? options,
    AgeGroup? ageGroup,
    List<String>? items,
  }) async {
    if (items == null || items.isEmpty) return;

    // Ensure all titles are unique to match the SQL placeholders perfectly
    final uniqueItems = items.toSet().toList();

    final db = await database;
    final tableName = options?.tableCostumeName(genderType, ageGroup);
    
    if (tableName == null || tableName.isEmpty) {
      throw Exception("Database problem: Table name is empty for option: $options");
    }

    final placeholders = List.filled(uniqueItems.length, '?').join(', ');

    try {
      if (quantityAdded == ModifyQuantity.removed.name) {
        await db.rawUpdate(
          'UPDATE $tableName SET quantity = quantity - 1 WHERE title IN ($placeholders)',
          uniqueItems,
        );
      } else if (quantityAdded == ModifyQuantity.added.name) {
        await db.rawUpdate(
          'UPDATE $tableName SET quantity = quantity + 1 WHERE title IN ($placeholders)',
          uniqueItems,
        );
      }
    } catch (e) {
      throw Exception("Database problem, cannot update the quantity: $e");
    }
  }

  Future<void> saveCheckedItems({
    required int checkedIndividualId,
    required Options options,
    GenderType? genderType,
    AgeGroup? ageGroup,
  }) async {
    final db = await database;
    final tableName = options.tableCostumeName(genderType, ageGroup);
    
    try {
      db.rawUpdate(
        'UPDATE $tableName SET itemCheck = ?',
        [checkedIndividualId]
      );
    } catch (e) {
      throw Exception(e);
    }
  }
}
