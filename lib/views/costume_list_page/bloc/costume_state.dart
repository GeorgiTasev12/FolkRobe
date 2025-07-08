part of 'costume_bloc.dart';

final class CostumeState extends Equatable {
  final Costume? costume;
  final List<Costume>? costumeList;
  final int? id;
  final TextEditingController? nameTextController;
  final TextEditingController? quantityTextController;
  final bool isNameNotEmpty;
  final bool isQuantityNotEmpty;

  const CostumeState({
    this.costume,
    this.costumeList,
    this.id,
    this.nameTextController,
    this.quantityTextController,
    this.isNameNotEmpty = false,
    this.isQuantityNotEmpty = false,
  });

  CostumeState copyWith({
    Costume? costume,
    List<Costume>? costumeList,
    int? id,
    bool? isNameNotEmpty,
    bool? isQuantityNotEmpty,
    TextEditingController? nameTextController,
    TextEditingController? quantityTextController,
    List<Map<String, dynamic>>? listMapOfCostumes,
  }) {
    return CostumeState(
      costume: costume ?? this.costume,
      costumeList: costumeList ?? this.costumeList,
      id: id ?? this.id,
      nameTextController: nameTextController ?? this.nameTextController,
      quantityTextController:
          quantityTextController ?? this.quantityTextController,
      isNameNotEmpty: isNameNotEmpty ?? this.isNameNotEmpty,
      isQuantityNotEmpty: isQuantityNotEmpty ?? this.isQuantityNotEmpty,
    );
  }

  @override
  List<Object?> get props => [
        costume,
        costumeList,
        id,
        isNameNotEmpty,
        isQuantityNotEmpty,
        nameTextController,
        quantityTextController,
      ];
}
