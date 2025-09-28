import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/models/status.dart';
import 'package:folk_robe/repositories/costumes_repository.dart';
import 'package:sqflite/sqflite.dart';

part 'costume_event.dart';
part 'costume_state.dart';

class CostumeBloc extends Bloc<CostumeEvent, CostumeState> {
  final Options selectedOption;
  final GenderType genderType;

  CostumeBloc({
    required this.selectedOption,
    required this.genderType,
  }) : super(CostumeState(
          nameTextController: TextEditingController(),
          quantityTextController: TextEditingController(),
          searchTextController: TextEditingController(),
        )) {
    on<InitDataEvent>(_onInitData);
    on<AddCostumeEvent>(_onAddCostume);
    on<UpdateCostumeEvent>(_onUpdateCostume);
    on<RemoveCostumeEvent>(_onRemoveCostume);
    on<OnNameChangedEvent>(_onNameChanged);
    on<OnQuantityChangedEvent>(_onQuantityChanged);
    on<OnNameClearEvent>(_onNameClear);
    on<OnQuantityClearEvent>(_onQuantityClear);
    on<OnCloseDialogEvent>(_onCloseDialog);
    on<SearchCostumeEvent>(_onSearchCostume);
    on<OnSearchClearEvent>(_onSearchClear);
  }

  @override
  Future<void> close() {
    state.nameTextController?.dispose();
    state.quantityTextController?.dispose();
    state.searchTextController?.dispose();
    return super.close();
  }

  Future<void> _onInitData(
    InitDataEvent event,
    Emitter<CostumeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final costumes = await CostumesRepository().read(
      option: selectedOption,
      gender: genderType,
    );

    emit(state.copyWith(
      allCostumesList: costumes,
      costumeFiltered: costumes,
      querySearch: "",
      isLoading: false,
    ));
  }

  Future<void> _onAddCostume(
    AddCostumeEvent event,
    Emitter<CostumeState> emit,
  ) async {
    try {
      final costume = Costume(
        title: event.title,
        quantity: int.tryParse(event.quantity ?? ''),
      );
      final newId = await CostumesRepository().add(
        item: costume,
        gender: genderType,
        option: selectedOption,
      );

      final costumeWithId = costume.copyWith(
        id: newId,
      );

      state.nameTextController?.clear();
      state.quantityTextController?.clear();

      emit(
        state.copyWith(
          costume: costumeWithId,
          status: Status.success,
          snackbarMessage: "Елементът е добавено успешно!",
          isNameNotEmpty: false,
          isQuantityNotEmpty: false,
        ),
      );
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

  Future<void> _onRemoveCostume(
    RemoveCostumeEvent event,
    Emitter<CostumeState> emit,
  ) async {
    try {
      await CostumesRepository().delete(
        option: selectedOption,
        id: event.id ?? 0,
        gender: genderType,
      );

      final updatedList = await CostumesRepository().read(
        option: selectedOption,
        gender: genderType,
      );

      emit(state.copyWith(
        allCostumesList: updatedList,
        id: event.id,
        status: Status.success,
        snackbarMessage: "Елементът е премахнат успешно!",
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

  Future<void> _onUpdateCostume(
    UpdateCostumeEvent event,
    Emitter<CostumeState> emit,
  ) async {
    try {
      final updatedCostume = Costume(
        id: event.id,
        title: event.title ?? '',
        quantity: int.tryParse(event.quantity ?? ''),
      );
      await CostumesRepository().update(
        id: event.id ?? 0,
        option: selectedOption,
        item: updatedCostume,
        gender: genderType,
      );

      final updatedList = await CostumesRepository().read(
        option: selectedOption,
        gender: genderType,
      );

      state.nameTextController?.clear();
      state.quantityTextController?.clear();

      emit(state.copyWith(
        allCostumesList: updatedList,
        costume: updatedCostume,
        status: Status.success,
        snackbarMessage: "Елементът е редактирано успешно!",
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

  void _onNameChanged(
    OnNameChangedEvent event,
    Emitter<CostumeState> emit,
  ) {
    emit(state.copyWith(
      isNameNotEmpty: event.text.isNotEmpty ? true : false,
    ));
  }

  void _onQuantityChanged(
    OnQuantityChangedEvent event,
    Emitter<CostumeState> emit,
  ) {
    emit(state.copyWith(
      isQuantityNotEmpty: event.number.isNotEmpty ? true : false,
    ));
  }

  void _onNameClear(
    OnNameClearEvent event,
    Emitter<CostumeState> emit,
  ) {
    final controller = event.textController;
    controller.clear();

    emit(state.copyWith(
      nameTextController: controller,
      isNameNotEmpty: false,
    ));
  }

  void _onQuantityClear(
    OnQuantityClearEvent event,
    Emitter<CostumeState> emit,
  ) {
    final controller = event.textController;
    controller.clear();

    emit(
      state.copyWith(
        quantityTextController: controller,
        isQuantityNotEmpty: false,
      ),
    );
  }

  void _onCloseDialog(
    OnCloseDialogEvent event,
    Emitter<CostumeState> emit,
  ) {
    state.nameTextController?.clear();
    state.quantityTextController?.clear();

    emit(state.copyWith(
      isNameNotEmpty: false,
      isQuantityNotEmpty: false,
    ));
  }

  FutureOr<void> _onSearchCostume(
    SearchCostumeEvent event,
    Emitter<CostumeState> emit,
  ) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(state.copyWith(
        costumeFiltered: null,
        querySearch: '',
      ));
    }

    final filtered = state.allCostumesList
        ?.where((costume) => costume.title.toLowerCase().contains(query))
        .toList();

    emit(state.copyWith(
      costumeFiltered: filtered,
      querySearch: query,
    ));
  }

  FutureOr<void> _onSearchClear(
    OnSearchClearEvent event,
    Emitter<CostumeState> emit,
  ) {
    final controller = event.textController;
    controller.clear();

    emit(state.copyWith(
      costumeFiltered: null,
      querySearch: '',
      searchTextController: controller,
    ));

    add(InitDataEvent());
  }
}
