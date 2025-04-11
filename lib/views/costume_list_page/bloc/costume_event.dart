part of 'costume_bloc.dart';

abstract class CostumeListEvent {}

final class InitDataEvent extends CostumeListEvent {}

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