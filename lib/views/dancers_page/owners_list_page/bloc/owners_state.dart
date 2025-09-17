part of 'owners_bloc.dart';

final class OwnersState extends Equatable {
  final List<Owner>? allOwnersList;
  final List<Owner>? ownersFiltered;
  final Owner? owner;
  final int? id;
  final int pageIndex;
  final bool isRegionSelected;
  final bool isDancerSelected;
  final List<String>? dancersNames;
  final List<String>? costumesTitles;
  final PageController? pageController;
  final bool isFABVisible;
  final bool isLoading;
  final bool isOwnerEdit;
  final String? selectedDancerValue;
  final Options? selectedRegionValue;
  final int? editingOwnerIndex;
  final List<String>? selectedItems;
  final Set<int> checkedCostumeIndexes;
  final String? querySearch;
  final TextEditingController? searchTextController;
  final Status status;
  final String? snackbarMessage;
  final GenderType genderTypeValue;
  final String? selectedGenderStringValue;
  final bool isGenderSelected;
  final bool isCancelPressed;
  final GenderType filterGenderTypeValue;

  const OwnersState({
    this.allOwnersList,
    this.ownersFiltered,
    this.owner,
    this.id,
    this.pageIndex = 0,
    this.dancersNames,
    this.costumesTitles,
    this.isRegionSelected = false,
    this.isDancerSelected = false,
    this.pageController,
    this.isFABVisible = true,
    this.isLoading = true,
    this.isOwnerEdit = false,
    this.selectedRegionValue,
    this.selectedDancerValue,
    this.editingOwnerIndex,
    this.selectedItems,
    this.checkedCostumeIndexes = const {},
    this.querySearch,
    this.searchTextController,
    this.status = Status.initial,
    this.snackbarMessage,
    this.genderTypeValue = GenderType.none,
    this.selectedGenderStringValue,
    this.isGenderSelected = false,
    this.isCancelPressed = false,
    this.filterGenderTypeValue = GenderType.none,
  });

  OwnersState copyWith({
    List<Owner>? allOwnersList,
    List<Owner>? ownersFiltered,
    Owner? owner,
    int? id,
    int? pageIndex,
    Set<int>? checkedCostumeIndexes,
    List<String>? dancersNames,
    List<String>? costumesTitles,
    bool? isRegionSelected,
    bool? isDancerSelected,
    AnimationController? animationController,
    PageController? pageController,
    bool? isFABVisible,
    bool? isLoading,
    bool? isOwnerEdit,
    Options? selectedRegionValue,
    String? selectedDancerValue,
    int? editingOwnerIndex,
    List<String>? selectedItems,
    String? querySearch,
    TextEditingController? searchTextController,
    Status? status,
    String? snackbarMessage,
    GenderType? genderTypeValue,
    String? selectedGenderStringValue,
    bool? isGenderSelected,
    bool? isCancelPressed,
    GenderType? filterGenderTypeValue,
  }) {
    return OwnersState(
      allOwnersList: allOwnersList ?? this.allOwnersList,
      ownersFiltered: ownersFiltered ?? this.ownersFiltered,
      owner: owner ?? this.owner,
      id: id ?? this.id,
      pageIndex: pageIndex ?? this.pageIndex,
      dancersNames: dancersNames ?? this.dancersNames,
      costumesTitles: costumesTitles ?? this.costumesTitles,
      isRegionSelected: isRegionSelected ?? this.isRegionSelected,
      isDancerSelected: isDancerSelected ?? this.isDancerSelected,
      pageController: pageController ?? this.pageController,
      isFABVisible: isFABVisible ?? this.isFABVisible,
      isLoading: isLoading ?? this.isLoading,
      isOwnerEdit: isOwnerEdit ?? this.isOwnerEdit,
      selectedRegionValue: selectedRegionValue ?? this.selectedRegionValue,
      selectedDancerValue: selectedDancerValue ?? this.selectedDancerValue,
      editingOwnerIndex: editingOwnerIndex ?? this.editingOwnerIndex,
      selectedItems: selectedItems ?? this.selectedItems,
      checkedCostumeIndexes:
          checkedCostumeIndexes ?? this.checkedCostumeIndexes,
      querySearch: querySearch ?? this.querySearch,
      searchTextController: searchTextController ?? this.searchTextController,
      status: status ?? this.status,
      snackbarMessage: snackbarMessage ?? this.snackbarMessage,
      genderTypeValue: genderTypeValue ?? this.genderTypeValue,
      selectedGenderStringValue: selectedGenderStringValue ?? this.selectedGenderStringValue,
      isGenderSelected: isGenderSelected ?? this.isGenderSelected,
      isCancelPressed: isCancelPressed ?? this.isCancelPressed,
      filterGenderTypeValue: filterGenderTypeValue ?? this.filterGenderTypeValue,
    );
  }

  @override
  List<Object?> get props => [
        allOwnersList,
        ownersFiltered,
        owner,
        id,
        pageIndex,
        dancersNames,
        costumesTitles,
        isRegionSelected,
        isDancerSelected,
        pageController,
        isFABVisible,
        isLoading,
        isOwnerEdit,
        selectedRegionValue,
        selectedDancerValue,
        editingOwnerIndex,
        selectedItems,
        checkedCostumeIndexes,
        querySearch,
        searchTextController,
        status,
        snackbarMessage,
        genderTypeValue,
        selectedGenderStringValue,
        isGenderSelected,
        isCancelPressed,
        filterGenderTypeValue,
      ];
}
