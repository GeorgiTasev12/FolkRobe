import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/repositories/costumes_repository.dart';
import 'package:folk_robe/repositories/dancers_repository.dart';
import 'package:folk_robe/repositories/owners_repository.dart';

part 'owners_event.dart';
part 'owners_state.dart';

class OwnersBloc extends Bloc<OwnersEvent, OwnersState> {
  final GenderType genderType;

  OwnersBloc({
    required this.genderType,
  }) : super(OwnersState(
          pageController: PageController(initialPage: 0),
        )) {
    on<InitOwnersEvent>(_onInit);
    on<AddTemporaryOwnerEvent>(_onAddTemporaryOwner);
    on<EditTemporaryOwnerEvent>(_onEditTemporaryOwner);
    on<RemoveTemporaryOwnerEvent>(_onRemoveTemporaryOwner);
    on<SelectedRegionEvent>(_onSelectedRegion);
    on<SelectedDancerEvent>(_onSelectedDancer);
    on<StartEditOwnerEvent>(_onStartEditOwner);
    on<SwitchPageEvent>(_onSwitchPage);
    on<ToggleCheckEvent>(_onToggleCheck);
  }

  bool buildWhen(OwnersState previous, OwnersState current) =>
      previous.isLoading != current.isLoading ||
      previous.pageIndex != current.pageIndex ||
      previous.isRegionSelected != current.isRegionSelected ||
      previous.isDancerSelected != current.isDancerSelected ||
      previous.dancersNames != current.dancersNames ||
      previous.costumesTitles != current.costumesTitles ||
      previous.ownersList != current.ownersList ||
      previous.id != current.id;

  bool filledButtonBuildWhen(OwnersState previous, OwnersState current) =>
      previous.isOwnerEdit != current.isOwnerEdit ||
      previous.selectedDancerValue != current.selectedDancerValue ||
      previous.selectedRegionValue != current.selectedRegionValue ||
      previous.editingOwnerIndex != current.editingOwnerIndex ||
      previous.checkedCostumeIndexes != current.checkedCostumeIndexes ||
      previous.selectedItems != current.selectedItems;

  FutureOr<void> _onInit(
    InitOwnersEvent event,
    Emitter<OwnersState> emit,
  ) async {
    final names = await DancersRepository.getDancers(
      gender: genderType,
    );

    emit(state.copyWith(isLoading: true));
    final owners = await OwnersRepository().read(
      gender: genderType,
    );

    emit(
      state.copyWith(
        dancersNames: names,
        ownersList: owners,
        isLoading: false,
      ),
    );
  }

  @override
  Future<void> close() {
    state.pageController?.dispose();
    return super.close();
  }

  FutureOr<void> _onSwitchPage(
    SwitchPageEvent event,
    Emitter<OwnersState> emit,
  ) async {
    await state.pageController?.animateToPage(
      event.pageIndex,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );

    emit(
      state.copyWith(
        pageIndex: event.pageIndex,
        isFABVisible: event.pageIndex != 0 ? false : true,
        isOwnerEdit: event.isOwnerEdit,
      ),
    );
  }

  FutureOr<void> _onAddTemporaryOwner(
    AddTemporaryOwnerEvent event,
    Emitter<OwnersState> emit,
  ) async {
    final itemString = (state.selectedItems ?? []).join(', ');

    final owner = Owner(
      title: event.title,
      name: event.name,
      items: itemString,
    );

    final newId = await OwnersRepository().add(
      item: owner,
      gender: genderType,
    );

    emit(state.copyWith(
      owner: owner.copyWith(id: newId),
      selectedItems: [], // clear selection after adding
      checkedCostumeIndexes: {}, // reset checkboxes
    ));
  }

  FutureOr<void> _onEditTemporaryOwner(
    EditTemporaryOwnerEvent event,
    Emitter<OwnersState> emit,
  ) async {
    final ownerIndex = state.editingOwnerIndex ?? 0;
    final ownerToEdit = state.ownersList?[ownerIndex];

    if (ownerToEdit == null) return;

    // Build the Set of checked indexes based on the owner’s current items
    final Set<int> checkedIndexes = {};
    final ownerItems = ownerToEdit.items.split(', ').map((e) => e.trim());
    for (int i = 0; i < (state.costumesTitles?.length ?? 0); i++) {
      if (ownerItems.contains(state.costumesTitles?[i])) {
        checkedIndexes.add(i);
      }
    }

    // Build the updated selectedItems from the checked indexes
    final selectedItems = state.checkedCostumeIndexes
        .map((i) => state.costumesTitles?[i] ?? '')
        .where((item) => item.isNotEmpty)
        .toList();

    final itemString = selectedItems.join(', ');

    final updatedOwner = Owner(
      id: event.id,
      name: event.name,
      title: event.title,
      items: itemString,
    );

    await OwnersRepository().update(
      id: event.id,
      item: updatedOwner,
      gender: genderType,
    );

    final updatedList = await OwnersRepository().read(gender: genderType);

    emit(state.copyWith(
      ownersList: updatedList,
      owner: updatedOwner,
      selectedItems: selectedItems,
      checkedCostumeIndexes: state.checkedCostumeIndexes,
    ));
  }

  FutureOr<void> _onRemoveTemporaryOwner(
    RemoveTemporaryOwnerEvent event,
    Emitter<OwnersState> emit,
  ) async {
    await OwnersRepository().delete(
      id: event.id,
      gender: genderType,
    );

    final updatedList = await OwnersRepository().read(
      gender: genderType,
    );

    emit(state.copyWith(
      ownersList: updatedList,
      id: event.id,
    ));
  }

  FutureOr<void> _onSelectedRegion(
    SelectedRegionEvent event,
    Emitter<OwnersState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedRegion: event.optionValue,
        isRegionSelected: true,
        isLoading: true,
      ),
    );

    final costumes = await CostumesRepository.getCostumes(
      gender: genderType,
      option: event.optionValue,
    );

    emit(
      state.copyWith(
        costumesTitles: costumes,
        isLoading: false,
        selectedRegionValue: event.optionValue,
      ),
    );
  }

  FutureOr<void> _onStartEditOwner(
    StartEditOwnerEvent event,
    Emitter<OwnersState> emit,
  ) {
    emit(state.copyWith(
      editingOwnerIndex: event.index,
    ));
  }

  FutureOr<void> _onSelectedDancer(
    SelectedDancerEvent event,
    Emitter<OwnersState> emit,
  ) {
    emit(
      state.copyWith(
        isDancerSelected: true,
        selectedDancerValue: event.dancerValue,
      ),
    );
  }

  FutureOr<void> _onToggleCheck(
    ToggleCheckEvent event,
    Emitter<OwnersState> emit,
  ) {
    final newSet = Set<int>.from(state.checkedCostumeIndexes);

    if (newSet.contains(event.index)) {
      newSet.remove(event.index);
    } else {
      newSet.add(event.index);
    }

    // Build the selectedItems list from the checked indexes
    final selectedItems = newSet
        .map((i) => state.costumesTitles?[i] ?? '')
        .where((item) => item.isNotEmpty)
        .toList();

    emit(state.copyWith(
      checkedCostumeIndexes: newSet,
      selectedItems: selectedItems,
    ));
  }
}
