import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/dao/costume.dart';
import 'package:folk_robe/service/database_helper.dart';

part 'costume_event.dart';
part 'costume_state.dart';

class CostumeListBloc extends Bloc<CostumeListEvent, CostumeListState> {
  CostumeListBloc() : super(CostumeListState(
    textController: TextEditingController(),
  )) {
    on<InitDataEvent>(_onInitData);
    on<AddCostumeEvent>(_onAddCostume);
    on<RemoveCostumeEvent>(_onRemoveCostume);
  }

  @override
  Future<void> close() {
    state.textController?.dispose();
    return super.close();
  }

  Future<void> _onInitData(InitDataEvent event, Emitter<CostumeListState> emit) async {
    final costumes = await DatabaseHelper().queryData();

    emit(state.copyWith(
      costumeList: costumes.map((e) => Costume.fromMap(e)).toList()
    ));
  }

  Future<void> _onAddCostume(AddCostumeEvent event, Emitter<CostumeListState> emit) async {
    final costume = Costume(title: event.title);
    final newId = await DatabaseHelper().insertCostume(costume);

    final costumeWithId = costume.copyWith(
      id: newId,
    );

    emit(state.copyWith(costume: costumeWithId));
  }

  Future<void> _onRemoveCostume(RemoveCostumeEvent event, Emitter<CostumeListState> emit) async {
    await DatabaseHelper().deleteCostume(event.id ?? 0);

    final updatedList = await DatabaseHelper().getAllCostumes();

    emit(state.copyWith(
      costumeList: updatedList,
      id: event.id,
    ));
  }
}
