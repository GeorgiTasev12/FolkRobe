part of 'costume_bloc.dart';

abstract class CostumeEvent {}

final class InitDataEvent extends CostumeEvent {
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

final class AddCostumeEvent extends CostumeEvent {
  final Costume? costume;
  final String title;
  final String? quantity;

  AddCostumeEvent({required this.title, this.costume, this.quantity});

  AddCostumeEvent copyWith({
    Costume? costume,
    String? title,
    String? quantity,
  }) {
    return AddCostumeEvent(
      costume: costume ?? this.costume,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
    );
  }
}

class UpdateCostumeEvent extends CostumeEvent {
  final String? title;
  final String? quantity;
  final int? id;

  UpdateCostumeEvent({
    this.title,
    this.quantity,
    this.id,
  });

  UpdateCostumeEvent copyWith({
    String? title,
    String? quantity,
    int? id,
  }) {
    return UpdateCostumeEvent(
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }
}

final class RemoveCostumeEvent extends CostumeEvent {
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
