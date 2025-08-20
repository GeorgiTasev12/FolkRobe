part of 'owners_bloc.dart';

final class OwnersState extends Equatable {
  final List<Owner>? ownersList;
  final Owner? owner;
  final int? id;
  final Options? selectedRegion;
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

  const OwnersState({
    this.ownersList,
    this.owner,
    this.id,
    this.selectedRegion,
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
  });

  OwnersState copyWith({
    List<Owner>? ownersList,
    Owner? owner,
    int? id,
    Options? selectedRegion,
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
  }) {
    return OwnersState(
      ownersList: ownersList ?? this.ownersList,
      owner: owner ?? this.owner,
      id: id ?? this.id,
      selectedRegion: selectedRegion ?? this.selectedRegion,
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
    );
  }

  @override
  List<Object?> get props => [
        ownersList,
        owner,
        id,
        selectedRegion,
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
      ];
}
