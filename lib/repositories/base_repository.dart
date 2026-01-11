import 'package:folk_robe/models/options.dart';

abstract class BaseRepository<T> {
  Future<int> add({
    required T item,
    required GenderType gender,
    Options? option,
    AgeGroup? age,
  });

  Future<List<T>> read({
    required GenderType gender,
    AgeGroup? ageGroup,
    Options? option,
  });

  Future<int> update({
    required int id,
    required T item,
    required GenderType gender,
    Options? option,
    AgeGroup? age,
  });

  Future<int> delete({
    required int id,
    required GenderType gender,
    Options? option,
    AgeGroup? age,
  });
}
