import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:folk_robe/common/common_divider.dart';
import 'package:folk_robe/common/common_snackbar.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/models/status.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/owner_dropdown_menu.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/missing_costumes_text.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/owner_listtitle.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/owners_listview.dart';

class OwnersListPage extends HookWidget {
  final GenderType genderType;

  const OwnersListPage({
    super.key,
    required this.genderType,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OwnersBloc>();

    useEffect(() {
      bloc.add(InitOwnersEvent());
      return;
    }, []);

    return BlocListener<OwnersBloc, OwnersState>(
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
        builder: (context, state) {
          final displayList = state.ownersFiltered ?? state.allOwnersList ?? [];

          return CorePage(
            hasAppBarTitle: true,
            appBarTitle: "Отговорници",
            hasFAB: state.isFABVisible,
            onFABPressed: () => bloc.add(
              SwitchPageEvent(pageIndex: 1, isOwnerEdit: false),
            ),
            hasSearchBar: state.pageIndex != 0 ? false : true,
            onSearchChanged: (value) =>
                bloc.add(SearchOwnerEvent(query: value)),
            searchTextController: state.searchTextController,
            isSuffixIconVisible: state.searchTextController?.text.isNotEmpty,
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
                OwnersListView(genderType: genderType),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OwnerDropdownMenu(
                      entries: (state.dancersNames ?? []).map((entry) {
                        return DropdownMenuEntry<String>(
                          value: entry,
                          label: entry,
                        );
                      }).toList(),
                      text: 'Танцьор:',
                      onSelected: (dancerValue) {
                        bloc.add(SelectedDancerEvent(
                            dancerValue: dancerValue ?? ''));
                      },
                    ),
                    OwnerDropdownMenu(
                      entries: Options.values.map((option) {
                        return DropdownMenuEntry<Options>(
                          value: option,
                          label: option.optionName,
                        );
                      }).toList(),
                      text: 'Област:',
                      enabled: state.isDancerSelected == true,
                      onSelected: (optionValue) {
                        if (optionValue != null) {
                          bloc.add(
                              SelectedRegionEvent(optionValue: optionValue));
                        }
                      },
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
                                      itemCount: state.costumesTitles!.length,
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
                                buildWhen: (previous, current) => bloc
                                    .filledButtonBuildWhen(previous, current),
                                builder: (context, state) {
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
                                                name:
                                                    state.selectedDancerValue ??
                                                        '',
                                                title: state.selectedRegionValue
                                                        ?.optionName ??
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
                                              ));
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
                                      style: context
                                          .appTheme.textStyles.bodyLarge
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
          );
        },
      ),
    );
  }
}
