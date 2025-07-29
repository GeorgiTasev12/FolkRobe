part of 'dancers_bloc.dart';

sealed class DancersEvent {
  const DancersEvent();
}

final class InitDancersEvent extends DancersEvent {}

final class AddDancerEvent extends DancersEvent {
  final Dancer? dancer;
  final String name;

  const AddDancerEvent({
    required this.name,
    this.dancer,
  });

  AddDancerEvent copyWith({
    Dancer? dancer,
    String? name,
  }) {
    return AddDancerEvent(
      dancer: dancer ?? this.dancer,
      name: name ?? this.name,
    );
  }
}

final class UpdateDancerEvent extends DancersEvent {
  final String? name;
  final int? id;

  UpdateDancerEvent({
    this.name,
    this.id,
  });

  UpdateDancerEvent copyWith({
    String? name,
    int? id,
  }) {
    return UpdateDancerEvent(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

final class RemoveDancerEvent extends DancersEvent {
  final int? id;

  const RemoveDancerEvent({
    this.id,
  });

  RemoveDancerEvent copyWith({int? id}) {
    return RemoveDancerEvent(
      id: id ?? this.id,
    );
  }
}

final class OnNameChangedEvent extends DancersEvent {
  final String text;

  const OnNameChangedEvent({
    required this.text,
  });

  OnNameChangedEvent copyWith({String? text}) {
    return OnNameChangedEvent(
      text: text ?? this.text,
    );
  }
}

final class OnNameClearEvent extends DancersEvent {
  final TextEditingController textController;

  const OnNameClearEvent({
    required this.textController,
  });

  OnNameClearEvent copyWith({TextEditingController? textController}) {
    return OnNameClearEvent(
      textController: textController ?? this.textController,
    );
  }
}

final class OnCloseDialogEvent extends DancersEvent {}