import 'package:folk_robe/app_database.dart';
import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/helpers/database_helper.dart';
import 'package:folk_robe/models/options.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseOwnersHelper extends DatabaseHelper<Owner> {
  @override
  Future<Database> get database async => await AppDatabase.getInstance();

  @override
  Owner fromMap(Map<String, dynamic> map) => Owner.fromMap(map);

  @override
  String getTableName({required GenderType gender, Options? option}) =>
      tableOwnersName(gender);

  @override
  Map<String, dynamic> toMap(Owner owner) => owner.toMap();
}
