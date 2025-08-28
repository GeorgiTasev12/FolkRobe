part of 'dancers_bloc.dart';

final class DancersState extends Equatable {
  final Dancer? dancer;
  final List<Dancer>? allDancersList;
  final List<Dancer>? dancersFiltered;
  final int? id;
  final TextEditingController? nameTextController;
  final bool isNameNotEmpty;
  final String? querySearch;
  final TextEditingController? searchTextController;
  final bool isLoading;
  final Status status;
  final String? snackbarMessage;

  const DancersState({
    this.dancer,
    this.allDancersList,
    this.dancersFiltered,
    this.id,
    this.nameTextController,
    this.isNameNotEmpty = false,
    this.querySearch,
    this.searchTextController,
    this.isLoading = false,
    this.status = Status.initial,
    this.snackbarMessage,
  });

  DancersState copyWith({
    Dancer? dancer,
    List<Dancer>? allDancersList,
    List<Dancer>? dancersFiltered,
    int? id,
    TextEditingController? nameTextController,
    bool? isNameNotEmpty,
    String? querySearch,
    TextEditingController? searchTextController,
    bool? isLoading,
    Status? status,
    String? snackbarMessage,
  }) {
    return DancersState(
      dancer: dancer ?? this.dancer,
      allDancersList: allDancersList ?? this.allDancersList,
      dancersFiltered: dancersFiltered ?? this.dancersFiltered,
      id: id ?? this.id,
      nameTextController: nameTextController ?? this.nameTextController,
      isNameNotEmpty: isNameNotEmpty ?? this.isNameNotEmpty,
      querySearch: querySearch ?? this.querySearch,
      searchTextController: searchTextController ?? this.searchTextController,
      isLoading: isLoading ?? this.isLoading,
      status: status ?? this.status,
      snackbarMessage: snackbarMessage ?? this.snackbarMessage,
    );
  }

  @override
  List<Object?> get props => [
        dancer,
        allDancersList,
        dancersFiltered,
        id,
        nameTextController,
        isNameNotEmpty,
        querySearch,
        searchTextController,
        isLoading,
        status,
        snackbarMessage,
      ];
}
