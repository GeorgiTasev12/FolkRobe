import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/dao/dancer.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/models/status.dart';
import 'package:folk_robe/repositories/dancers_repository.dart';
import 'package:sqflite/sqlite_api.dart';

part 'dancers_event.dart';
part 'dancers_state.dart';

class DancersBloc extends Bloc<DancersEvent, DancersState> {
  DancersBloc()
      : super(DancersState(
          nameTextController: TextEditingController(),
          searchTextController: TextEditingController(),
        )) {
    on<InitDancersEvent>(_onInitData);
    on<AddDancerEvent>(_onAddDancer);
    on<UpdateDancerEvent>(_onUpdateDancer);
    on<RemoveDancerEvent>(_onRemoveDancer);
    on<OnNameChangedEvent>(_onNameChanged);
    on<OnNameClearEvent>(_onNameClear);
    on<OnCloseDialogEvent>(_onCloseDialog);
    on<SearchDancerEvent>(_onSearchDancer);
    on<OnSearchClearEvent>(_onSearchClear);
    on<OnSelectedGenderEvent>(_onSelectedGender);
    on<OnOpenDialogEvent>(_onOpenDialog);
    on<OnFilterDancersEvent>(_onFilterDancers);
  }

  FutureOr<void> _onInitData(
    InitDancersEvent event,
    Emitter<DancersState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final dancers = await DancersRepository().read();

    emit(state.copyWith(
      allDancersList: dancers,
      dancersFiltered: dancers,
      querySearch: "",
      isLoading: false,
    ));
  }

  @override
  Future<void> close() {
    state.nameTextController?.dispose();
    return super.close();
  }

  FutureOr<void> _onAddDancer(
    AddDancerEvent event,
    Emitter<DancersState> emit,
  ) async {
    try {
      final dancer = Dancer(
        name: event.name,
        gender: event.gender,
      );

      final newId = await DancersRepository().add(item: dancer);

      final dancerWithId = dancer.copyWith(id: newId);

      state.nameTextController?.clear();

      emit(state.copyWith(
        dancer: dancerWithId,
        status: Status.success,
        snackbarMessage: "Танцьорът е добавен успешно!",
        isNameNotEmpty: false,
        genderStringValue: event.gender,
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
    ));
  }

  FutureOr<void> _onUpdateDancer(
    UpdateDancerEvent event,
    Emitter<DancersState> emit,
  ) async {
    try {
      final updatedDancer = Dancer(
        id: event.id,
        name: event.name ?? '',
        gender: event.gender ?? '',
      );

      await DancersRepository().update(
        item: updatedDancer,
        id: event.id ?? 0,
      );

      final updatedList = await DancersRepository().read();

      state.nameTextController?.clear();

      emit(state.copyWith(
        allDancersList: updatedList,
        dancer: updatedDancer,
        status: Status.success,
        snackbarMessage: "Танцьорът е редактиран успешно!",
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
    ));
  }

  FutureOr<void> _onRemoveDancer(
    RemoveDancerEvent event,
    Emitter<DancersState> emit,
  ) async {
    try {
      await DancersRepository().delete(
        id: event.id ?? 0,
      );

      final updatedList = await DancersRepository().read();

      emit(state.copyWith(
          allDancersList: updatedList,
          id: event.id,
          status: Status.success,
          snackbarMessage: "Танцьорът е премахнат успешно!"));
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

  void _onNameChanged(
    OnNameChangedEvent event,
    Emitter<DancersState> emit,
  ) {
    emit(state.copyWith(
      isNameNotEmpty: event.text.isNotEmpty ? true : false,
    ));
  }

  void _onNameClear(
    OnNameClearEvent event,
    Emitter<DancersState> emit,
  ) {
    final controller = event.textController;
    controller.clear();

    emit(state.copyWith(
      nameTextController: controller,
      isNameNotEmpty: false,
    ));
  }

  void _onCloseDialog(
    OnCloseDialogEvent event,
    Emitter<DancersState> emit,
  ) {
    state.nameTextController?.clear();

    emit(state.copyWith(
      isNameNotEmpty: false,
    ));
  }

  FutureOr<void> _onSearchDancer(
    SearchDancerEvent event,
    Emitter<DancersState> emit,
  ) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(
        dancersFiltered: null,
        querySearch: '',
      ));
    }

    final filtered = state.allDancersList
        ?.where((dancer) => dancer.name.toLowerCase().contains(query))
        .toList();

    emit(state.copyWith(
      dancersFiltered: filtered,
      querySearch: query,
    ));
  }

  FutureOr<void> _onSearchClear(
    OnSearchClearEvent event,
    Emitter<DancersState> emit,
  ) {
    final controller = event.textController;
    controller.clear();

    emit(state.copyWith(
      dancersFiltered: null,
      querySearch: '',
      searchTextController: controller,
    ));

    add(InitDancersEvent());
  }

  FutureOr<void> _onSelectedGender(
    OnSelectedGenderEvent event,
    Emitter<DancersState> emit,
  ) {
    emit(state.copyWith(
      genderStringValue: event.gender.name,
      genderTypeValue: event.gender,
    ));
  }

  FutureOr<void> _onOpenDialog(
    OnOpenDialogEvent event,
    Emitter<DancersState> emit,
  ) {
    if (state.isDancerEdit) {
      final dancer = state.allDancersList?[state.dancer?.id ?? 0];

      if (dancer != null) {
        emit(state.copyWith(
          isDancerEdit: true,
          genderTypeValue: event.genderType,
          genderStringValue: dancer.gender,
        ));
      } else {
        emit(state.copyWith(
          isDancerEdit: false,
          genderStringValue: null,
          genderTypeValue: null,
        ));
      }
    }

    emit(state.copyWith(
      isDancerEdit: false,
    ));
  }

  FutureOr<void> _onFilterDancers(
    OnFilterDancersEvent event,
    Emitter<DancersState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final filteredDancers = await DancersRepository.getFilteredDancers(
      gender: event.genderType,
    );

    emit(state.copyWith(
      filterGenderTypeValue: event.genderType,
      allDancersList: filteredDancers,
      dancersFiltered: filteredDancers,
      isLoading: false,
    ));
  }
}
