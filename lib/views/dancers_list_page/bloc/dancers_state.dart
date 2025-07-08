part of 'dancers_bloc.dart';

final class DancersState extends Equatable {
  final Dancer? dancer;
  final List<Dancer>? dancersList;
  final int? id;
  final TextEditingController? nameTextController;
  final bool isNameNotEmpty;

  const DancersState({
    this.dancer,
    this.dancersList,
    this.id,
    this.nameTextController,
    this.isNameNotEmpty = false,
  });

  DancersState copyWith({
    Dancer? dancer,
    List<Dancer>? dancersList,
    int? id,
    TextEditingController? nameTextController,
    bool? isNameNotEmpty,
  }) {
    return DancersState(
      dancer: dancer ?? this.dancer,
      dancersList: dancersList ?? this.dancersList,
      id: id ?? this.id,
      nameTextController: nameTextController ?? this.nameTextController,
      isNameNotEmpty: isNameNotEmpty ?? this.isNameNotEmpty,
    );
  }

  @override
  List<Object?> get props => [
        dancer,
        dancersList,
        id,
        nameTextController,
        isNameNotEmpty
      ];
}
