part of 'dancers_bloc.dart';

sealed class DancersEvent {
  const DancersEvent();
}

final class InitDancersEvent extends DancersEvent {}

final class AddDancerEvent extends DancersEvent {
  final Dancer? dancer;
  final String name;
  final String gender;

  const AddDancerEvent({
    required this.name,
    required this.gender,
    this.dancer,
  });

  AddDancerEvent copyWith({
    Dancer? dancer,
    String? name,
    String? gender,
  }) {
    return AddDancerEvent(
      dancer: dancer ?? this.dancer,
      name: name ?? this.name,
      gender: gender ?? this.gender,
    );
  }
}

final class UpdateDancerEvent extends DancersEvent {
  final String? name;
  final int? id;
  final String? gender;

  UpdateDancerEvent({
    this.name,
    this.id,
    this.gender,
  });

  UpdateDancerEvent copyWith({
    String? name,
    int? id,
    String? gender,
  }) {
    return UpdateDancerEvent(
      name: name ?? this.name,
      id: id ?? this.id,
      gender: gender ?? this.gender,
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

final class SearchDancerEvent extends DancersEvent {
  final String query;

  SearchDancerEvent({required this.query});
}

final class OnSearchClearEvent extends DancersEvent {
  final TextEditingController textController;

  OnSearchClearEvent({
    required this.textController,
  });
}

final class OnSelectedGenderEvent extends DancersEvent {
  final GenderType gender;

  OnSelectedGenderEvent({required this.gender});
}

final class OnOpenDialogEvent extends DancersEvent {
  final GenderType genderType;
  final String? genderStringValue;
  final bool isDancerEdit;

  OnOpenDialogEvent({
    required this.genderType,
    this.genderStringValue,
    this.isDancerEdit = false,
  });
}

final class OnFilterDancersEvent extends DancersEvent {
  final GenderType genderType;

  OnFilterDancersEvent({required this.genderType});
}
