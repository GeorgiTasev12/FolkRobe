import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/database_helper.dart';

part 'costume_event.dart';
part 'costume_state.dart';

class CostumeBloc extends Bloc<CostumeEvent, CostumeState> {
  final Options selectedOption;
  final GenderType genderType;

  CostumeBloc({
    required this.selectedOption,
    required this.genderType,
  }) : super(CostumeState(
          textController: TextEditingController(),
        )) {
    on<InitDataEvent>(_onInitData);
    on<AddCostumeEvent>(_onAddCostume);
    on<UpdateCostumeEvent>(_onUpdateCostume);
    on<RemoveCostumeEvent>(_onRemoveCostume);
  }

  @override
  Future<void> close() {
    state.textController?.dispose();
    return super.close();
  }

  Future<void> _onInitData(
      InitDataEvent event, Emitter<CostumeState> emit) async {
    final costumes =
        await DatabaseHelper().queryData(selectedOption, genderType);
    emit(state.copyWith(
        costumeList: costumes.map((e) => Costume.fromMap(e)).toList()));
  }

  bool buildWhen(CostumeState previous, CostumeState current) =>
      previous.costumeList != current.costumeList ||
      previous.textController != current.textController;

  Future<void> _onAddCostume(
      AddCostumeEvent event, Emitter<CostumeState> emit) async {
    final costume = Costume(title: event.title);
    final newId = await DatabaseHelper()
        .insertCostume(selectedOption, costume, genderType);

    final costumeWithId = costume.copyWith(
      id: newId,
    );

    emit(state.copyWith(costume: costumeWithId));
  }

  Future<void> _onRemoveCostume(
      RemoveCostumeEvent event, Emitter<CostumeState> emit) async {
    await DatabaseHelper().deleteCostume(
      selectedOption,
      event.id ?? 0,
      genderType,
    );

    final updatedList =
        await DatabaseHelper().getAllCostumes(selectedOption, genderType);

    emit(state.copyWith(
      costumeList: updatedList,
      id: event.id,
    ));
  }

  FutureOr<void> _onUpdateCostume(
      UpdateCostumeEvent event, Emitter<CostumeState> emit) async {
    final updatedCostume = Costume(id: event.id, title: event.title ?? '');
    await DatabaseHelper()
        .updateCostume(selectedOption, updatedCostume, genderType);

    final updatedList =
        await DatabaseHelper().getAllCostumes(selectedOption, genderType);

    emit(state.copyWith(
      costumeList: updatedList,
      costume: updatedCostume,
    ));
  }
}
