part of 'owners_bloc.dart';

sealed class OwnersEvent {
  const OwnersEvent();
}

final class InitOwnersEvent extends OwnersEvent {
  final AgeGroup ageGroup;

  const InitOwnersEvent({
    required this.ageGroup
  });
}

final class SelectedRegionEvent extends OwnersEvent {
  final Options optionValue;

  const SelectedRegionEvent({
    required this.optionValue,
  });
}

final class SelectedDancerEvent extends OwnersEvent {
  final String dancerValue;

  const SelectedDancerEvent({required this.dancerValue});
}

final class StartEditOwnerEvent extends OwnersEvent {
  final int index;

  const StartEditOwnerEvent({
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
  final AgeGroup ageGroup;

  OnFilterOwnersEvent({required this.genderType, required this.ageGroup,});
}

final class ModifyQuantityEvent extends OwnersEvent {
  final GenderType genderType;
  final AgeGroup ageGroup;
  final ModifyQuantity modifyQuantity;
  final List<String>? items;

  ModifyQuantityEvent({
    required this.ageGroup,
    required this.genderType,
    required this.modifyQuantity,
    required this.items,
  });
}

final class IndividualToggleCheckEvent extends OwnersEvent {
  final int index;

  IndividualToggleCheckEvent({required this.index});
}