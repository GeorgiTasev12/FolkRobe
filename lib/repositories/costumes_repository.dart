import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/repositories/base_repository.dart';
import 'package:folk_robe/service/database_costume_helper.dart';

class CostumesRepository extends BaseRepository<Costume> {
  final _costumesDB = DatabaseCostumeHelper();

  @override
  Future<int> add({
    required Costume item,
    required GenderType gender,
    Options? option,
    AgeGroup? age,
  }) async {
    return await _costumesDB.insert(
      item: item,
      gender: gender,
      option: option,
      age: age,
    );
  }

  @override
  Future<int> delete({
    required int id,
    required GenderType gender,
    Options? option,
    AgeGroup? age,
  }) async {
    return await _costumesDB.delete(
      option: option,
      id: id,
      gender: gender,
      age: age,
    );
  }

  @override
  Future<List<Costume>> read({
    required GenderType gender,
    AgeGroup? ageGroup,
    Options? option,
  }) async {
    return await _costumesDB.getAll(
      option: option,
      gender: gender,
      age: ageGroup,
    );
  }

  @override
  Future<int> update({
    required int id,
    required Costume item,
    required GenderType gender,
    Options? option,
    AgeGroup? age,
  }) async {
    return await _costumesDB.update(
      id: id,
      option: option,
      item: item,
      gender: gender,
      age: age,
    );
  }

  static Future<List<String>> getCostumes({
    required Options option,
    GenderType? gender,
    required AgeGroup? ageGroup,
  }) async {
    return await DatabaseCostumeHelper.getCostumes(
        gender, 
        option, 
        ageGroup,
      );
  }

  static Future<void> modifyQuantityCostumes({
    required Options option,
    required AgeGroup? ageGroup,
    required String quantityAdded,
    GenderType? gender,
    List<String>? items,
  }) async {
    return await DatabaseCostumeHelper().modifyQuantityCostumes(
      quantityAdded: quantityAdded,
      options: option,
      ageGroup: ageGroup,
      genderType: gender,
      items: items
    );
  }
}
