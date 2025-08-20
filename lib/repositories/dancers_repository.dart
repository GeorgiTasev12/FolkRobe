import 'package:folk_robe/dao/dancer.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/repositories/base_repository.dart';
import 'package:folk_robe/service/database_dancers_helper.dart';

class DancersRepository extends BaseRepository<Dancer> {
  final _dancersDB = DatabaseDancersHelper();

  @override
  Future<int> add({
    required Dancer item,
    required GenderType gender,
    Options? option,
  }) async {
    return await _dancersDB.insert(item: item, gender: gender);
  }

  @override
  Future<int> delete({
    required int id,
    required GenderType gender,
    Options? option,
  }) async {
    return await _dancersDB.delete(
      id: id,
      gender: gender,
    );
  }

  @override
  Future<List<Dancer>> read({
    required GenderType gender,
    Options? option,
  }) async {
    return await _dancersDB.getAll(gender: gender);
  }

  @override
  Future<int> update({
    required int id,
    required Dancer item,
    required GenderType gender,
    Options? option,
  }) async {
    return await _dancersDB.update(
      item: item,
      gender: gender,
      id: id,
    );
  }

  static Future<List<String>> getDancers({required GenderType gender}) async {
    return await DatabaseDancersHelper.getDancersNames(gender);
  }
}
