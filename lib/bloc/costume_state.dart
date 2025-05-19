part of 'costume_bloc.dart';

final class CostumeState extends Equatable {
  final Costume? costume;
  final List<Costume>? costumeList;
  final int? id;
  final TextEditingController? nameTextController;
  final TextEditingController? quantityTextController;

  const CostumeState({
    this.costume,
    this.costumeList,
    this.id,
    this.nameTextController,
    this.quantityTextController,
  });

  CostumeState copyWith({
    Costume? costume,
    List<Costume>? costumeList,
    int? id,
    TextEditingController? nameTextController,
    TextEditingController? quantityTextController,
    List<Map<String, dynamic>>? listMapOfCostumes,
  }) {
    return CostumeState(
      costume: costume ?? this.costume,
      costumeList: costumeList ?? this.costumeList,
      id: id ?? this.id,
      nameTextController: nameTextController ?? this.nameTextController,
      quantityTextController: quantityTextController ?? this.quantityTextController,
    );
  }

  @override
  List<Object?> get props => [
        costume,
        costumeList,
        id,
        nameTextController,
        quantityTextController,
      ];
}
