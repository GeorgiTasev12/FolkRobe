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
  final GenderType genderType;

  DancersBloc({
    required this.genderType,
  }) : super(DancersState(
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
  }

  FutureOr<void> _onInitData(
    InitDancersEvent event,
    Emitter<DancersState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final dancers = await DancersRepository().read(gender: genderType);

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
      final dancer = Dancer(name: event.name);

      final newId =
          await DancersRepository().add(item: dancer, gender: genderType);

      final dancerWithId = dancer.copyWith(id: newId);

      emit(state.copyWith(
        dancer: dancerWithId,
        status: Status.success,
        snackbarMessage:
            "Успешно сте записали ${genderType == GenderType.male ? 'танцьорът' : 'танцьорката'} в списъка!",
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
      );

      await DancersRepository().update(
        item: updatedDancer,
        gender: genderType,
        id: event.id ?? 0,
      );

      final updatedList = await DancersRepository().read(gender: genderType);

      emit(state.copyWith(
        allDancersList: updatedList,
        dancer: updatedDancer,
        status: Status.success,
        snackbarMessage:
            "Успешно сте преименували ${genderType == GenderType.male ? 'танцьорът' : 'танцьорката'}!",
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
        gender: genderType,
      );

      final updatedList = await DancersRepository().read(gender: genderType);

      emit(state.copyWith(
          allDancersList: updatedList,
          id: event.id,
          status: Status.success,
          snackbarMessage:
              "Успешно сте премахнали ${genderType == GenderType.male ? 'танцьорът' : 'танцьорката'} от списъка!"));
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
}
