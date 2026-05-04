import 'package:folk_robe/dao/dancer.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/repositories/base_repository.dart';
import 'package:folk_robe/service/database_dancers_helper.dart';

class DancersRepository extends BaseRepository<Dancer> {
  final _dancersDB = DatabaseDancersHelper();

  @override
  Future<int> add({
    required Dancer item,
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    try {
      return await _dancersDB.insert(
        item: item,
        gender: gender,
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
      return await _dancersDB.delete(
      id: id,
      gender: gender,
      age: age,
    );
    } catch(e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Dancer>> read({
    GenderType? gender,
    AgeGroup? ageGroup,
    Options? option,
  }) async {
    try {
      return await _dancersDB.getAll(
      gender: gender,
      age: ageGroup,
    );
    } catch(e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> update({
    required int id,
    required Dancer item,
    GenderType? gender,
    Options? option,
    AgeGroup? age,
  }) async {
    try {
      return await _dancersDB.update(
      item: item,
      gender: gender,
      id: id,
      age: age,
    );
    } catch(e) {
      throw Exception(e);
    }
  }

  static Future<List<String>> getDancers({
    required GenderType gender,
    required AgeGroup ageGroup,
  }) async {
    try {
      return await DatabaseDancersHelper.getDancersNames(
      gender,
      ageGroup,
    );
    } catch(e) {
      throw Exception(e);
    }
  }

  static Future<List<Dancer>> getFilteredDancers({
    required GenderType gender,
    required AgeGroup ageGroup,
  }) async {
    try {
      return await DatabaseDancersHelper.getFilteredDancers(
        gender: gender,
        ageGroup: ageGroup,
      );
    } catch(e) {
      throw Exception(e);
    }
  }
}
