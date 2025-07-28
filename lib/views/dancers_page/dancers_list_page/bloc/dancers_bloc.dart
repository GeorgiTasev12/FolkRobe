import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/dao/dancer.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/database_dancers_helper.dart';

part 'dancers_event.dart';
part 'dancers_state.dart';

class DancersBloc extends Bloc<DancersEvent, DancersState> {
  final GenderType genderType;

  DancersBloc({
    required this.genderType,
  }) : super(DancersState(nameTextController: TextEditingController())) {
    on<InitDancersEvent>(_onInitData);
    on<AddDancerEvent>(_onAddDancer);
    on<UpdateDancerEvent>(_onUpdateDancer);
    on<RemoveDancerEvent>(_onRemoveDancer);
    on<OnNameChangedEvent>(_onNameChanged);
    on<OnNameClearEvent>(_onNameClear);
    on<OnCloseDialogEvent>(_onCloseDialog);
  }

  FutureOr<void> _onInitData(
      InitDancersEvent event, Emitter<DancersState> emit) async {
    final dancers = await DatabaseDancersHelper().getAll(gender: genderType);

    emit(state.copyWith(
      dancersList: dancers,
    ));
  }

  FutureOr<void> _onAddDancer(
      AddDancerEvent event, Emitter<DancersState> emit) async {
    final dancer = Dancer(name: event.name);

    final newId =
        await DatabaseDancersHelper().insert(item: dancer, gender: genderType);

    final dancerWithId = dancer.copyWith(id: newId);

    emit(state.copyWith(
      dancer: dancerWithId,
    ));
  }

  FutureOr<void> _onUpdateDancer(
      UpdateDancerEvent event, Emitter<DancersState> emit) async {
    final updatedDancer = Dancer(
      id: event.id,
      name: event.name ?? '',
    );

    await DatabaseDancersHelper().update(
      item: updatedDancer,
      gender: genderType,
      id: event.id ?? 0,
    );

    final updatedList =
        await DatabaseDancersHelper().getAll(gender: genderType);

    emit(state.copyWith(
      dancersList: updatedList,
      dancer: updatedDancer,
    ));
  }

  FutureOr<void> _onRemoveDancer(
      RemoveDancerEvent event, Emitter<DancersState> emit) async {
    await DatabaseDancersHelper().delete(
      id: event.id ?? 0,
      gender: genderType,
    );

    final updatedList = await DatabaseDancersHelper().getAll(gender: genderType);

    emit(state.copyWith(
      dancersList: updatedList,
      id: event.id,
    ));
  }

  void _onNameChanged(OnNameChangedEvent event, Emitter<DancersState> emit) {
    emit(state.copyWith(
      isNameNotEmpty: event.text.isNotEmpty ? true : false,
    ));
  }

  void _onNameClear(OnNameClearEvent event, Emitter<DancersState> emit) {
    final controller = event.textController;
    controller.clear();

    emit(state.copyWith(
      nameTextController: controller,
      isNameNotEmpty: false,
    ));
  }

  void _onCloseDialog(OnCloseDialogEvent event, Emitter<DancersState> emit) {
    state.nameTextController?.clear();

    emit(state.copyWith(
      isNameNotEmpty: false,
    ));
  }
}
