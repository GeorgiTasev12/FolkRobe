import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/repositories/base_repository.dart';
import 'package:folk_robe/service/database_owners_helper.dart';

class OwnersRepository extends BaseRepository<Owner> {
  final _ownersDB = DatabaseOwnersHelper();

  @override
  Future<int> add({
    required Owner item,
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    try {
      return await _ownersDB.insert(
        gender: gender,
        item: item,
        age: age,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> delete({
    required int id,
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    try {
      return await _ownersDB.delete(
        gender: gender,
        id: id,
        age: age,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Owner>> read({
    GenderType? gender,
    AgeGroup? ageGroup,
    Options? option,
  }) async {
    try {
      return await _ownersDB.getAll(
        gender: gender,
        age: ageGroup,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> update({
    required int id,
    required Owner item,
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    try {
      return await _ownersDB.update(
        id: id,
        item: item,
        gender: gender,
        age: age,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<List<Owner>> getFilteredDancersName({
    required GenderType gender,
    required AgeGroup ageGroup,
  }) async {
    return await DatabaseOwnersHelper.getFilteredOwners(
      gender: gender, 
      ageGroup: ageGroup.name,
    );
  }
}
