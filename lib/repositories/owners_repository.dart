import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/repositories/base_repository.dart';
import 'package:folk_robe/service/database_owners_helper.dart';

class OwnersRepository extends BaseRepository<Owner> {
  final _ownersDB = DatabaseOwnersHelper();

  final Map<GenderType, List<Owner>> _cachedOwners = {};

  @override
  Future<int> add({
    required Owner item,
    GenderType? gender,
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
    GenderType? gender,
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
    GenderType? gender,
    Options? option,
  }) async {
    try {
      if (_cachedOwners.containsKey(gender)) {
        return _cachedOwners[gender]!;
      } else {
        final owners = await _ownersDB.getAll(gender: gender);
        _cachedOwners[gender ?? GenderType.none] = owners;

        return owners;
      }
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

  static Future<List<Owner>> getFilteredDancersName({
    required GenderType gender,
  }) async {
    return await DatabaseOwnersHelper.getFilteredOwners(gender: gender);
  }
}
