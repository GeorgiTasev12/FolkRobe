import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:folk_robe/common/common_divider.dart';
import 'package:folk_robe/common/common_snackbar.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/models/status.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/owner_dropdown_menu.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/missing_costumes_text.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/owner_listtitle.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/owners_listview.dart';

class OwnersListPage extends HookWidget {
  const OwnersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OwnersBloc>();

    useEffect(() {
      bloc.add(InitOwnersEvent());
      return;
    }, []);

    return BlocListener<OwnersBloc, OwnersState>(
      bloc: bloc,
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.snackbarMessage != current.snackbarMessage,
      listener: (context, state) {
        if (state.status == Status.success || state.status == Status.error) {
          showCommonSnackbar(
            context: context,
            message: state.snackbarMessage,
            status: state.status,
          );
        }
      },
      child: BlocBuilder<OwnersBloc, OwnersState>(
        bloc: bloc,
        buildWhen: (previous, current) => bloc.buildWhen(previous, current),
        builder: (context, state) => CorePage(
          hasAppBarTitle: true,
          appBarTitle: "Отговорници",
          hasFAB: state.isFABVisible,
          onFABPressed: () => bloc.add(
            SwitchPageEvent(
              pageIndex: 1,
              isOwnerEdit: false,
            ),
          ),
          onPopPressed: () => state.pageIndex == 1
              ? bloc.add(
                  SwitchPageEvent(
                    pageIndex: 0,
                    isOwnerEdit: false,
                  ),
                )
              : locator<NavigationService>().pop(),
          hasSearchBar: state.pageIndex != 0 ? false : true,
          hasFilterMenu: true,
          initialFilterValue: state.filterGenderTypeValue,
          onSelectedFilter: (genderFilter) {
            bloc.add(
              OnFilterOwnersEvent(
                genderType: genderFilter ?? GenderType.none,
              ),
            );
          },
          onSearchChanged: (value) => bloc.add(SearchOwnerEvent(query: value)),
          searchTextController: state.searchTextController,
          isSuffixIconVisible:
              state.searchTextController?.text.isNotEmpty ?? false,
          onSuffixPressed: () => bloc.add(
            OnSearchClearEvent(
              textController:
                  state.searchTextController ?? TextEditingController(),
            ),
          ),
          child: PageView(
            controller: state.pageController,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              OwnersListView(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BlocBuilder<OwnersBloc, OwnersState>(
                    bloc: bloc,
                    buildWhen: (previous, current) =>
                        previous.genderTypeValue != current.genderTypeValue,
                    builder: (context, state) => OwnerDropdownMenu<GenderType?>(
                      entries: GenderType.values
                          .where((gender) => gender != GenderType.none)
                          .map((gender) => DropdownMenuEntry<GenderType>(
                                value: gender,
                                label: gender.genderName,
                              ))
                          .toList(),
                      text: 'Пол:',
                      initialSelection: state.genderTypeValue,
                      onSelected: (genderValue) {
                        final selectedGender = genderValue ?? GenderType.none;
                        bloc.add(
                          SelectedGenderEvent(genderTypeValue: selectedGender),
                        );
                      },
                    ),
                  ),
                  BlocBuilder<OwnersBloc, OwnersState>(
                    bloc: bloc,
                    buildWhen: (previous, current) =>
                        previous.dancersNames != current.dancersNames ||
                        previous.isGenderSelected != current.isGenderSelected ||
                        previous.selectedDancerValue !=
                            current.selectedDancerValue,
                    builder: (context, state) => OwnerDropdownMenu(
                      valueKey: ValueKey(state.genderTypeValue),
                      entries: (state.dancersNames ?? []).map((entry) {
                        return DropdownMenuEntry<String>(
                          value: entry,
                          label: entry,
                        );
                      }).toList(),
                      text: 'Танцьор:',
                      enabled: state.isGenderSelected == true,
                      initialSelection: state.selectedDancerValue,
                      onSelected: (dancerValue) {
                        bloc.add(SelectedDancerEvent(
                            dancerValue: dancerValue ?? ''));
                      },
                    ),
                  ),
                  BlocBuilder<OwnersBloc, OwnersState>(
                    bloc: bloc,
                    buildWhen: (previous, current) =>
                        previous.isDancerSelected != current.isDancerSelected ||
                        previous.selectedRegionValue !=
                            current.selectedRegionValue,
                    builder: (context, state) => OwnerDropdownMenu(
                      valueKey: ValueKey(state.selectedDancerValue),
                      entries: Options.values
                          .where((option) => option != Options.none)
                          .map((option) {
                        return DropdownMenuEntry<Options>(
                          value: option,
                          label: option.optionName,
                        );
                      }).toList(),
                      text: 'Област:',
                      enabled: state.isDancerSelected == true,
                      initialSelection: state.selectedRegionValue,
                      onSelected: (optionValue) {
                        if (optionValue != null) {
                          bloc.add(
                              SelectedRegionEvent(optionValue: optionValue));
                        }
                      },
                    ),
                  ),
                  CommonDivider(),
                  const SizedBox(height: 10),
                  Expanded(
                    child: state.isLoading
                        ? state.isRegionSelected == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: context.appTheme.colors.primary,
                                ),
                              )
                            : const SizedBox.shrink()
                        : state.isRegionSelected == true
                            ? (state.costumesTitles?.isNotEmpty ?? false)
                                ? ListView.separated(
                                    itemCount:
                                        state.costumesTitles?.length ?? 0,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 12),
                                    itemBuilder: (context, index) =>
                                        OwnersListTile(
                                      index: index,
                                    ),
                                  )
                                : MissingCostumesText()
                            : const SizedBox.shrink(),
                  ),
                  if (state.isRegionSelected == true) ...[
                    CommonDivider(),
                    const SizedBox(height: 10),
                    SafeArea(
                      bottom: true,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => bloc.add(
                                SwitchPageEvent(
                                  pageIndex: 0,
                                  isOwnerEdit: false,
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: context.appTheme.colors.primary,
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: context.appTheme.textStyles.bodyLarge
                                    .copyWith(
                                  color: context.appTheme.colors.primary,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: BlocBuilder<OwnersBloc, OwnersState>(
                              buildWhen: (previous, current) =>
                                  bloc.filledButtonBuildWhen(previous, current),
                              builder: (context, state) {
                                final displayList = state.ownersFiltered ??
                                    state.allOwnersList ??
                                    [];

                                return FilledButton(
                                  onPressed: state
                                          .checkedCostumeIndexes.isNotEmpty
                                      ? () {
                                          if (state.isOwnerEdit) {
                                            final editingOwnerId = displayList[
                                                    state.editingOwnerIndex ??
                                                        0]
                                                .id;

                                            bloc.add(EditTemporaryOwnerEvent(
                                              id: editingOwnerId ?? 0,
                                              name: state.selectedDancerValue ??
                                                  '',
                                              title: state.selectedRegionValue
                                                      ?.optionName ??
                                                  '',
                                              gender: state
                                                      .selectedGenderStringValue ??
                                                  '',
                                            ));
                                          } else {
                                            bloc.add(AddTemporaryOwnerEvent(
                                                name:
                                                    state.selectedDancerValue ??
                                                        '',
                                                title: state.selectedRegionValue
                                                        ?.optionName ??
                                                    '',
                                                gender: state
                                                        .selectedGenderStringValue ??
                                                    ''));
                                          }

                                          bloc.add(SwitchPageEvent(
                                            pageIndex: 0,
                                            isOwnerEdit: false,
                                          ));
                                          bloc.add(InitOwnersEvent());
                                        }
                                      : null,
                                  style: FilledButton.styleFrom(
                                    backgroundColor: context
                                        .appTheme.colors.surfaceContainer,
                                  ),
                                  child: Text(
                                    state.isOwnerEdit ? 'Save' : 'Add',
                                    style: context.appTheme.textStyles.bodyLarge
                                        .copyWith(
                                      color: context
                                          .appTheme.colors.onSurfaceContainer,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
