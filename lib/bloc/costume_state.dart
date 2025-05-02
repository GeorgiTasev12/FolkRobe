part of 'costume_bloc.dart';

final class CostumeState extends Equatable {
  final Costume? costume;
  final List<Costume>? costumeList;
  final int? id;
  final TextEditingController? textController;

  const CostumeState({
    this.costume,
    this.costumeList,
    this.id,
    this.textController,
  });

  CostumeState copyWith({
    Costume? costume,
    List<Costume>? costumeList,
    int? id,
    TextEditingController? textController,
    List<Map<String, dynamic>>? listMapOfCostumes,
  }) {
    return CostumeState(
      costume: costume ?? this.costume,
      costumeList: costumeList ?? this.costumeList,
      id: id ?? this.id,
      textController: textController ?? this.textController,
    );
  }

  @override
  List<Object?> get props => [
        costume,
        costumeList,
        id,
        textController,
      ];
}
