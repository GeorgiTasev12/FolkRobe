part of 'costume_bloc.dart';

final class CostumeListState extends Equatable {
  final Costume? costume;
  final List<Costume>? costumeList;
  final int? id;
  final TextEditingController? textController;

  const CostumeListState({
    this.costume,
    this.costumeList,
    this.id,
    this.textController,
  });

  CostumeListState copyWith({
    Costume? costume,
    List<Costume>? costumeList,
    int? id,
    TextEditingController? textController,
    List<Map<String, dynamic>>? listMapOfCostumes,
  }) {
    return CostumeListState(
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