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

final class OnNameChangedEvent extends CostumeEvent {
  final String text;

  OnNameChangedEvent({
    required this.text,
  });

  OnNameChangedEvent copyWith({String? text}) {
    return OnNameChangedEvent(text: text ?? this.text);
  }
}

final class OnQuantityChangedEvent extends CostumeEvent {
  final String number;

  OnQuantityChangedEvent({
    required this.number,
  });

  OnQuantityChangedEvent copyWith({String? number}) {
    return OnQuantityChangedEvent(number: number ?? this.number);
  }
}

final class OnNameClearEvent extends CostumeEvent {
  final TextEditingController textController;

  OnNameClearEvent({required this.textController});

  OnNameClearEvent copyWith({TextEditingController? textController}) {
    return OnNameClearEvent(
        textController: textController ?? this.textController);
  }
}

final class OnQuantityClearEvent extends CostumeEvent {
  final TextEditingController textController;

  OnQuantityClearEvent({
    required this.textController,
  });

  OnQuantityClearEvent copyWith({
    TextEditingController? textController,
  }) {
    return OnQuantityClearEvent(
      textController: textController ?? this.textController,
    );
  }
}

final class OnCloseDialogEvent extends CostumeEvent {}

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

final class SearchCostumeEvent extends CostumeEvent {
  final String query;

  SearchCostumeEvent({required this.query});
}

final class OnSearchClearEvent extends CostumeEvent {
  final TextEditingController textController;

  OnSearchClearEvent({
    required this.textController,
  });
}
