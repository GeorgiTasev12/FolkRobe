import 'package:folk_robe/models/options.dart';

abstract class BaseRepository<T> {
  Future<int> add({
    required T item,
    required GenderType gender,
    Options? option,
  });

  Future<List<T>> read({
    required GenderType gender,
    Options? option,
  });

  Future<int> update({
    required int id,
    required T item,
    required GenderType gender,
    Options? option,
  });

  Future<int> delete({
    required int id,
    required GenderType gender,
    Options? option,
  });
}