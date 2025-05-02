part of 'costume_bloc.dart';

abstract class CostumeListEvent {}

final class InitDataEvent extends CostumeListEvent {
  final Options? options;

  InitDataEvent({
    this.options,
  });

  InitDataEvent copyWith({
    Options? options,
  }) {
    return InitDataEvent(options: options ?? this.options);
  }
}

final class AddCostumeEvent extends CostumeListEvent {
  final Costume? costume;
  final String title;

  AddCostumeEvent({
    this.costume,
    required this.title,
  });

  AddCostumeEvent copyWith({
    Costume? costume,
    String? title,
  }) {
    return AddCostumeEvent(
      costume: costume ?? this.costume,
      title: title ?? this.title,
    );
  }
}

class UpdateCostumeEvent extends CostumeListEvent {
  final String? title;
  final int? id;

  UpdateCostumeEvent({
    this.title,
    this.id,
  });

  UpdateCostumeEvent copyWith({
    String? title,
    int? id,
  }) {
    return UpdateCostumeEvent(
      title: title ?? this.title,
      id: id ?? this.id,
    );
  }
}

final class RemoveCostumeEvent extends CostumeListEvent {
  final int? id;

  RemoveCostumeEvent({
    this.id,
  });

  RemoveCostumeEvent copyWith({
    int? id,
  }) {
    return RemoveCostumeEvent(
      id: id ?? this.id,
    );
  }
}
