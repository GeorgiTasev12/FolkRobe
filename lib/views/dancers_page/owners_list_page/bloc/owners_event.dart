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

  StartEditOwnerEvent({required this.index});
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

  EditTemporaryOwnerEvent({
    required this.name,
    required this.title,
    required this.id,
  });
}

final class AddTemporaryOwnerEvent extends OwnersEvent {
  final String name;
  final String title;
  final int? id;

  AddTemporaryOwnerEvent({
    required this.name,
    required this.title,
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