part of 'owners_bloc.dart';

sealed class OwnersEvent {
  const OwnersEvent();
}

final class InitOwnersEvent extends OwnersEvent {}

final class SelectedRegionEvent extends OwnersEvent {
  final Options optionValue;

  SelectedRegionEvent({
    required this.optionValue,
  });
}

final class SelectedDancerEvent extends OwnersEvent {
  final String dancerValue;

  SelectedDancerEvent({required this.dancerValue});
}

final class StartEditOwnerEvent extends OwnersEvent {
  final int index;

  StartEditOwnerEvent({
    required this.index,
  });
}

final class SelectedGenderEvent extends OwnersEvent {
  final GenderType genderTypeValue;

  SelectedGenderEvent({required this.genderTypeValue});
}

final class SwitchPageEvent extends OwnersEvent {
  final int pageIndex;
  final bool isOwnerEdit;

  SwitchPageEvent({
    required this.pageIndex,
    required this.isOwnerEdit,
  });
}

final class EditTemporaryOwnerEvent extends OwnersEvent {
  final int id;
  final String name;
  final String title;
  final String gender;

  EditTemporaryOwnerEvent({
    required this.name,
    required this.title,
    required this.id,
    required this.gender,
  });
}

final class AddTemporaryOwnerEvent extends OwnersEvent {
  final String name;
  final String title;
  final int? id;
  final String gender;

  AddTemporaryOwnerEvent({
    required this.name,
    required this.title,
    required this.gender,
    this.id,
  });
}

final class ToggleCheckEvent extends OwnersEvent {
  final int index;

  ToggleCheckEvent({required this.index});
}

final class RemoveTemporaryOwnerEvent extends OwnersEvent {
  final int id;

  RemoveTemporaryOwnerEvent({required this.id});
}

final class SearchOwnerEvent extends OwnersEvent {
  final String query;

  SearchOwnerEvent({
    required this.query,
  });
}

final class OnSearchClearEvent extends OwnersEvent {
  final TextEditingController textController;

  OnSearchClearEvent({
    required this.textController,
  });
}

final class OnFilterOwnersEvent extends OwnersEvent {
  final GenderType genderType;

  OnFilterOwnersEvent({required this.genderType});
}