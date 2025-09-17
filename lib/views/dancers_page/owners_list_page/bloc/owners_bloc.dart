import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/models/status.dart';
import 'package:folk_robe/repositories/costumes_repository.dart';
import 'package:folk_robe/repositories/dancers_repository.dart';
import 'package:folk_robe/repositories/owners_repository.dart';
import 'package:sqflite/sqflite.dart';

part 'owners_event.dart';
part 'owners_state.dart';

class OwnersBloc extends Bloc<OwnersEvent, OwnersState> {
  // final GenderType genderType;

  OwnersBloc()
      : super(OwnersState(
          pageController: PageController(initialPage: 0),
          searchTextController: TextEditingController(),
        )) {
    on<InitOwnersEvent>(_onInit);
    on<AddTemporaryOwnerEvent>(_onAddTemporaryOwner);
    on<EditTemporaryOwnerEvent>(_onEditTemporaryOwner);
    on<RemoveTemporaryOwnerEvent>(_onRemoveTemporaryOwner);
    on<SelectedRegionEvent>(_onSelectedRegion);
    on<SelectedDancerEvent>(_onSelectedDancer);
    on<SelectedGenderEvent>(_onSelectedGender);
    on<StartEditOwnerEvent>(_onStartEditOwner);
    on<SwitchPageEvent>(_onSwitchPage);
    on<ToggleCheckEvent>(_onToggleCheck);
    on<SearchOwnerEvent>(_onSearchOwners);
    on<OnSearchClearEvent>(_onSearchClear);
    on<OnFilterOwnersEvent>(_onFilterOwners);
  }

  bool buildWhen(OwnersState previous, OwnersState current) =>
      previous.pageIndex != current.pageIndex ||
      previous.isFABVisible != current.isFABVisible ||
      previous.searchTextController != current.searchTextController ||
      previous.pageController != current.pageController ||
      previous.isLoading != current.isLoading ||
      previous.isOwnerEdit != current.isOwnerEdit ||
      previous.isRegionSelected != current.isRegionSelected ||
      previous.costumesTitles != current.costumesTitles ||
      previous.filterGenderTypeValue != current.filterGenderTypeValue;

  bool filledButtonBuildWhen(OwnersState previous, OwnersState current) =>
      previous.ownersFiltered != current.ownersFiltered ||
      previous.allOwnersList != current.allOwnersList ||
      previous.checkedCostumeIndexes != current.checkedCostumeIndexes ||
      previous.isOwnerEdit != current.isOwnerEdit ||
      previous.editingOwnerIndex != current.editingOwnerIndex ||
      previous.selectedDancerValue != current.selectedDancerValue ||
      previous.selectedRegionValue != current.selectedRegionValue ||
      previous.selectedGenderStringValue != current.selectedGenderStringValue ||
      previous.pageIndex != current.pageIndex;

  FutureOr<void> _onInit(
    InitOwnersEvent event,
    Emitter<OwnersState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final owners = await OwnersRepository().read();

    emit(
      state.copyWith(
        allOwnersList: owners,
        ownersFiltered: owners,
        filterGenderTypeValue: GenderType.none,
        isLoading: false,
        querySearch: "",
      ),
    );
  }

  @override
  Future<void> close() {
    state.pageController?.dispose();
    state.searchTextController?.dispose();
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

    if (state.pageIndex != 1) {
      if (event.isOwnerEdit) {
        final owner = state.allOwnersList?[state.editingOwnerIndex ?? 0];

        if (owner != null) {
          final region = Options.values.firstWhere(
            (option) => option.optionName == owner.title,
            orElse: () => Options.none,
          );

          final genderType = GenderType.values.firstWhere(
            (gender) => gender.name == owner.gender,
            orElse: () => GenderType.none,
          );

          // Filter dancers by gender
          final filteredDancers = (await DancersRepository.getDancers(
            gender: genderType,
          ))
              .where((name) => name.isNotEmpty)
              .toList();

          // Ensure the owner's name exists in the filtered list
          final selectedName =
              filteredDancers.contains(owner.name) ? owner.name : null;

          emit(state.copyWith(
            pageIndex: event.pageIndex,
            isFABVisible: event.pageIndex != 0 ? false : true,
            isOwnerEdit: event.isOwnerEdit,
            selectedDancerValue: selectedName,
            dancersNames: filteredDancers,
            selectedRegionValue:
                (state.dancersNames?.isEmpty ?? false) ? Options.none : region,
            selectedGenderStringValue: owner.gender,
            genderTypeValue: genderType,
            isDancerSelected: true,
            isRegionSelected: true,
            isGenderSelected: true,
            isCancelPressed: false,
          ));

          add(SelectedRegionEvent(optionValue: region));
          return;
        }
      }
    }

    emit(
      state.copyWith(
        pageIndex: event.pageIndex,
        isFABVisible: event.pageIndex != 0 ? false : true,
        isOwnerEdit: event.isOwnerEdit,
        selectedDancerValue: '',
        dancersNames: [],
        genderTypeValue: GenderType.none,
        selectedRegionValue: Options.none,
        selectedGenderStringValue: null,
        isDancerSelected: false,
        isRegionSelected: false,
        isGenderSelected: false,
        editingOwnerIndex: null,
        isCancelPressed: false,
      ),
    );
  }

  FutureOr<void> _onAddTemporaryOwner(
    AddTemporaryOwnerEvent event,
    Emitter<OwnersState> emit,
  ) async {
    try {
      final itemString = (state.selectedItems ?? []).join(', ');

      final owner = Owner(
        title: event.title,
        name: event.name,
        gender: event.gender,
        items: itemString,
      );

      final newId = await OwnersRepository().add(
        item: owner,
      );

      emit(state.copyWith(
        owner: owner.copyWith(id: newId),
        selectedItems: [], // clear selection after adding
        checkedCostumeIndexes: {}, // reset checkboxes
        isCancelPressed: false,
        status: Status.success,
        snackbarMessage: "Елементът е добавено успешно!",
      ));
    } on DatabaseException catch (dbError) {
      emit(state.copyWith(
        status: Status.error,
        snackbarMessage: "Възникна грешка: ${dbError.toString()}",
      ));

      throw Exception(dbError);
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        snackbarMessage: "Възникна грешка, моля опитайте по-късно.",
      ));

      throw Exception(e);
    }

    emit(state.copyWith(
      status: Status.initial,
      snackbarMessage: null,
      selectedDancerValue: '',
      selectedRegionValue: Options.none,
      selectedGenderStringValue: '',
      genderTypeValue: null,
      isDancerSelected: false,
      isRegionSelected: false,
      isGenderSelected: false,
      editingOwnerIndex: null,
      dancersNames: [],
      costumesTitles: [],
      isCancelPressed: false,
    ));
  }

  FutureOr<void> _onEditTemporaryOwner(
    EditTemporaryOwnerEvent event,
    Emitter<OwnersState> emit,
  ) async {
    try {
      final ownerIndex = state.editingOwnerIndex ?? 0;
      final ownerToEdit = state.allOwnersList?[ownerIndex];

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
        gender: event.gender,
        items: itemString,
      );

      await OwnersRepository().update(
        id: event.id,
        item: updatedOwner,
      );

      final updatedList = await OwnersRepository().read();

      emit(state.copyWith(
        allOwnersList: updatedList,
        owner: updatedOwner,
        selectedItems: selectedItems,
        checkedCostumeIndexes: state.checkedCostumeIndexes,
        status: Status.success,
        snackbarMessage: "Елементът е редактиран успешно!",
        isCancelPressed: false,
      ));
    } on DatabaseException catch (dbError) {
      emit(state.copyWith(
        status: Status.error,
        snackbarMessage: "Възникна грешка, ${dbError.toString()}",
      ));

      throw Exception(dbError);
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        snackbarMessage: "Възникна грешка, моля опитайте по-късно.",
      ));

      throw Exception(e);
    }

    emit(state.copyWith(
      status: Status.initial,
      snackbarMessage: null,
      isCancelPressed: false,
    ));
  }

  FutureOr<void> _onRemoveTemporaryOwner(
    RemoveTemporaryOwnerEvent event,
    Emitter<OwnersState> emit,
  ) async {
    try {
      await OwnersRepository().delete(
        id: event.id,
      );

      final updatedList = await OwnersRepository().read();

      emit(state.copyWith(
          allOwnersList: updatedList,
          id: event.id,
          status: Status.success,
          snackbarMessage: "Елементът е премахнат успешно!"));

      add(InitOwnersEvent());
    } on DatabaseException catch (dbError) {
      emit(state.copyWith(
        status: Status.error,
        snackbarMessage: "Възникна грешка: ${dbError.toString()}",
      ));

      throw Exception(dbError);
    } catch (e) {
      emit(state.copyWith(
        status: Status.error,
        snackbarMessage: "Възникна грешка, моля опитайте по-късно.",
      ));

      throw Exception(e);
    }

    emit(state.copyWith(
      status: Status.initial,
      snackbarMessage: null,
    ));
  }

  FutureOr<void> _onSelectedGender(
    SelectedGenderEvent event,
    Emitter<OwnersState> emit,
  ) async {
    emit(
      state.copyWith(
        isGenderSelected: true,
        genderTypeValue: event.genderTypeValue,
        selectedGenderStringValue: event.genderTypeValue.name,
        selectedDancerValue: null,
        isDancerSelected: state.isOwnerEdit ? true : false,
        dancersNames: [],
      ),
    );

    final dancers = await DancersRepository.getDancers(
      gender: event.genderTypeValue,
    );

    emit(
      state.copyWith(
        dancersNames: dancers,
      ),
    );
  }

  FutureOr<void> _onSelectedRegion(
    SelectedRegionEvent event,
    Emitter<OwnersState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedRegionValue: event.optionValue,
        isRegionSelected: true,
        isLoading: true,
      ),
    );

    //Make sure on the gender to get the value from the state after selecting from the dropdown menu
    final costumes = await CostumesRepository.getCostumes(
      option: event.optionValue,
      gender: state.genderTypeValue,
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
  ) async {
    emit(
      state.copyWith(
        editingOwnerIndex: event.index,
      ),
    );
  }

  FutureOr<void> _onSelectedDancer(
    SelectedDancerEvent event,
    Emitter<OwnersState> emit,
  ) {
    emit(
      state.copyWith(
        isDancerSelected: true,
        selectedDancerValue: event.dancerValue,
        selectedRegionValue: null,
        isRegionSelected: state.isOwnerEdit ? true : false,
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

  FutureOr<void> _onSearchOwners(
    SearchOwnerEvent event,
    Emitter<OwnersState> emit,
  ) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(
        ownersFiltered: null,
        querySearch: '',
      ));
    }

    final filtered = state.allOwnersList
        ?.where((dancer) => dancer.name.toLowerCase().contains(query))
        .toList();

    emit(state.copyWith(
      ownersFiltered: filtered,
      querySearch: query,
    ));
  }

  FutureOr<void> _onSearchClear(
    OnSearchClearEvent event,
    Emitter<OwnersState> emit,
  ) {
    final controller = event.textController;
    controller.clear();

    emit(state.copyWith(
      ownersFiltered: null,
      querySearch: '',
      searchTextController: controller,
    ));

    add(InitOwnersEvent());
  }

  FutureOr<void> _onFilterOwners(
    OnFilterOwnersEvent event,
    Emitter<OwnersState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final filteredOwners = await OwnersRepository.getFilteredDancersName(
      gender: event.genderType,
    );

    emit(state.copyWith(
      filterGenderTypeValue: event.genderType,
      allOwnersList: filteredOwners,
      ownersFiltered: filteredOwners,
      isLoading: false,
    ));
  }
}
