part of 'costume_bloc.dart';

final class CostumeState extends Equatable {
  final Costume? costume;
  final List<Costume>? allCostumesList;
  final List<Costume>? costumeFiltered;
  final int? id;
  final TextEditingController? nameTextController;
  final TextEditingController? quantityTextController;
  final bool isNameNotEmpty;
  final bool isQuantityNotEmpty;
  final String? querySearch;
  final TextEditingController? searchTextController;
  final bool isLoading;
  final Status status;
  final String? snackbarMessage;

  const CostumeState({
    this.costume,
    this.allCostumesList,
    this.id,
    this.nameTextController,
    this.quantityTextController,
    this.isNameNotEmpty = false,
    this.isQuantityNotEmpty = false,
    this.querySearch,
    this.costumeFiltered,
    this.searchTextController,
    this.isLoading = false,
    this.status = Status.initial,
    this.snackbarMessage,
  });

  CostumeState copyWith({
    Costume? costume,
    List<Costume>? allCostumesList,
    List<Costume>? costumeFiltered,
    int? id,
    bool? isNameNotEmpty,
    bool? isQuantityNotEmpty,
    TextEditingController? nameTextController,
    TextEditingController? quantityTextController,
    List<Map<String, dynamic>>? listMapOfCostumes,
    String? querySearch,
    TextEditingController? searchTextController,
    bool? isLoading,
    Status? status,
    String? snackbarMessage
  }) {
    return CostumeState(
      costume: costume ?? this.costume,
      allCostumesList: allCostumesList ?? this.allCostumesList,
      costumeFiltered: costumeFiltered ?? this.costumeFiltered,
      id: id ?? this.id,
      nameTextController: nameTextController ?? this.nameTextController,
      quantityTextController:
          quantityTextController ?? this.quantityTextController,
      isNameNotEmpty: isNameNotEmpty ?? this.isNameNotEmpty,
      isQuantityNotEmpty: isQuantityNotEmpty ?? this.isQuantityNotEmpty,
      querySearch: querySearch ?? this.querySearch,
      searchTextController: searchTextController ?? this.searchTextController,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      snackbarMessage: snackbarMessage ?? this.snackbarMessage,
    );
  }

  @override
  List<Object?> get props => [
        costume,
        allCostumesList,
        costumeFiltered,
        id,
        isNameNotEmpty,
        isQuantityNotEmpty,
        nameTextController,
        quantityTextController,
        querySearch,
        searchTextController,
        isLoading,
        status,
        snackbarMessage,
      ];
}
