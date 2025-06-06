import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/database_costume_helper.dart';

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
  }

  @override
  Future<void> close() {
    state.nameTextController?.dispose();
    return super.close();
  }

  Future<void> _onInitData(
      InitDataEvent event, Emitter<CostumeState> emit) async {
    final costumes =
        await DatabaseCostumeHelper().queryData(selectedOption, genderType);
    emit(state.copyWith(
        costumeList: costumes.map((e) => Costume.fromMap(e)).toList()));
  }

  Future<void> _onAddCostume(
      AddCostumeEvent event, Emitter<CostumeState> emit) async {
    final costume = Costume(
      title: event.title,
      quantity: int.tryParse(event.quantity ?? ''),
    );
    final newId = await DatabaseCostumeHelper()
        .insertCostume(selectedOption, costume, genderType);

    final costumeWithId = costume.copyWith(
      id: newId,
    );

    emit(
      state.copyWith(
        costume: costumeWithId,
      ),
    );
  }

  Future<void> _onRemoveCostume(
      RemoveCostumeEvent event, Emitter<CostumeState> emit) async {
    await DatabaseCostumeHelper().deleteCostume(
      selectedOption,
      event.id ?? 0,
      genderType,
    );

    final updatedList = await DatabaseCostumeHelper()
        .getAllCostumes(selectedOption, genderType);

    emit(state.copyWith(
      costumeList: updatedList,
      id: event.id,
    ));
  }

  Future<void> _onUpdateCostume(
      UpdateCostumeEvent event, Emitter<CostumeState> emit) async {
    final updatedCostume = Costume(
      id: event.id,
      title: event.title ?? '',
      quantity: int.tryParse(event.quantity ?? ''),
    );
    await DatabaseCostumeHelper()
        .updateCostume(selectedOption, updatedCostume, genderType);

    final updatedList = await DatabaseCostumeHelper()
        .getAllCostumes(selectedOption, genderType);

    emit(state.copyWith(
      costumeList: updatedList,
      costume: updatedCostume,
    ));
  }

  void _onNameChanged(OnNameChangedEvent event, Emitter<CostumeState> emit) {
    emit(state.copyWith(
      isNameNotEmpty: event.text.isNotEmpty ? true : false,
    ));
  }

  void _onQuantityChanged(
      OnQuantityChangedEvent event, Emitter<CostumeState> emit) {
    emit(state.copyWith(
      isQuantityNotEmpty: event.number.isNotEmpty ? true : false,
    ));
  }

  void _onNameClear(OnNameClearEvent event, Emitter<CostumeState> emit) {
    final controller = event.textController;
    controller.clear();

    emit(state.copyWith(
      nameTextController: controller,
      isNameNotEmpty: false,
    ));
  }

  void _onQuantityClear(
      OnQuantityClearEvent event, Emitter<CostumeState> emit) {
    final controller = event.textController;
    controller.clear();

    emit(
      state.copyWith(
        quantityTextController: controller,
        isQuantityNotEmpty: false,
      ),
    );
  }

  void _onCloseDialog(OnCloseDialogEvent event, Emitter<CostumeState> emit) {
    state.nameTextController?.clear();
    state.quantityTextController?.clear();

    emit(state.copyWith(
      isNameNotEmpty: false,
      isQuantityNotEmpty: false,
    ));
  }
}