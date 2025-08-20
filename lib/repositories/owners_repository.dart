
import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/repositories/base_repository.dart';
import 'package:folk_robe/service/database_owners_helper.dart';

class OwnersRepository extends BaseRepository<Owner> {
  final _ownersDB = DatabaseOwnersHelper();

  @override
  Future<int> add({
    required Owner item,
    required GenderType gender,
    Options? option,
  }) async {
    try {
      return await _ownersDB.insert(
        gender: gender,
        item: item,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> delete({
    required int id,
    required GenderType gender,
    Options? option,
  }) async {
    try {
      return await _ownersDB.delete(
        gender: gender,
        id: id,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Owner>> read({
    required GenderType gender,
    Options? option,
  }) async {
    try {
      return await _ownersDB.getAll(gender: gender);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<int> update({
    required int id,
    required Owner item,
    required GenderType gender,
    Options? option,
  }) async {
    try {
      return await _ownersDB.update(
        id: id,
        item: item,
        gender: gender,
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> close() async {
    await DatabaseOwnersHelper().close();
  }
}
