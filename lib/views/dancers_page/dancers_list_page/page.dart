import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:folk_robe/common/common_circle_iconbutton.dart';
import 'package:folk_robe/common/common_delete_dialog.dart';
import 'package:folk_robe/common/common_dialog.dart';
import 'package:folk_robe/common/common_list_tile.dart';
import 'package:folk_robe/common/common_snackbar.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/models/status.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/common/common_empty_info_text.dart';
import 'package:folk_robe/views/dancers_page/dancers_list_page/bloc/dancers_bloc.dart';

class DancersListPage extends HookWidget {
  final GenderType genderType;

  const DancersListPage({
    super.key,
    required this.genderType,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<DancersBloc>();

    useEffect(() {
      bloc.add(InitDancersEvent());
      return;
    }, const []);

    return BlocListener<DancersBloc, DancersState>(
      listener: (context, state) {
        if (state.status == Status.success || state.status == Status.error) {
          showCommonSnackbar(
            context: context,
            message: state.snackbarMessage,
            status: state.status,
          );
        }
      },
      child: BlocBuilder<DancersBloc, DancersState>(
        buildWhen: (previous, current) =>
            previous.allDancersList != current.allDancersList ||
            previous.nameTextController != current.nameTextController ||
            previous.isNameNotEmpty != current.isNameNotEmpty ||
            previous.searchTextController != current.searchTextController ||
            previous.querySearch != current.querySearch,
        builder: (context, state) => CorePage(
          hasFAB: true,
          hasAppBarTitle: true,
          appBarTitle: 'Танцьори',
          onFABPressed: () => showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: bloc,
                child: BlocBuilder<DancersBloc, DancersState>(
                  buildWhen: (previous, current) =>
                      previous.nameTextController !=
                          current.nameTextController ||
                      previous.isNameNotEmpty != current.isNameNotEmpty,
                  builder: (context, state) {
                    return CommonDialog(
                      dialogTitle: 'Моля, въведете име на танцьора',
                      isEnabled:
                          state.nameTextController?.text.isNotEmpty ?? false,
                      onSavePressed: () {
                        bloc.add(AddDancerEvent(
                          name: state.nameTextController?.text ?? "",
                        ));
                        bloc.add(InitDancersEvent());
                        bloc.add(OnCloseDialogEvent());
                        locator<NavigationService>().pop();
                      },
                      onClosedPressed: () {
                        bloc.add(OnCloseDialogEvent());
                        locator<NavigationService>().pop();
                      },
                      onNameClearPressed: () => bloc.add(
                        OnNameClearEvent(
                          textController: state.nameTextController ??
                              TextEditingController(),
                        ),
                      ),
                      onNameChanged: (String name) => bloc.add(
                        OnNameChangedEvent(text: name),
                      ),
                      nameTextController:
                          state.nameTextController ?? TextEditingController(),
                      isNameNotEmpty: state.isNameNotEmpty,
                    );
                  },
                ),
              );
            },
          ),
          hasSearchBar: true,
          onSearchChanged: (value) => bloc.add(SearchDancerEvent(query: value)),
          searchTextController: state.searchTextController,
          isSuffixIconVisible: state.searchTextController?.text.isNotEmpty,
          onSuffixPressed: () => bloc.add(
            OnSearchClearEvent(
              textController:
                  state.searchTextController ?? TextEditingController(),
            ),
          ),
          child: state.allDancersList?.isEmpty ?? false
              ? const CommonEmptyInfoText(
                  isDancer: true,
                )
              : BlocBuilder<DancersBloc, DancersState>(
                  buildWhen: (previous, current) =>
                      previous.allDancersList != current.allDancersList ||
                      previous.dancersFiltered != current.dancersFiltered ||
                      previous.isLoading != current.isLoading,
                  builder: (context, state) {
                    final displayList =
                        state.dancersFiltered ?? state.allDancersList ?? [];

                    if (state.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: context.appTheme.colors.primary,
                        ),
                      );
                    }

                    if (displayList.isEmpty) {
                      return Center(
                        child: Text(
                          'Няма резултати..',
                          style:
                              context.appTheme.textStyles.titleMedium.copyWith(
                            color: context.appTheme.colors.primary,
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: displayList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final dancer = displayList[index];

                        return CommonListTile(
                          title: dancer.name,
                          suffixWidgets: [
                            CommonCircleIconButton(
                              index: index,
                              icon: Icon(
                                Icons.edit,
                                color: context.appTheme.colors.surfaceContainer,
                              ),
                              backgroundColor: context.appTheme.colors.warning,
                              onPressed: () {
                                if (dancer.id != null) {
                                  state.nameTextController?.text = dancer.name;
                                } else {
                                  state.nameTextController?.clear();
                                }

                                showDialog(
                                  context: context,
                                  builder: (_) => BlocProvider.value(
                                    value: bloc,
                                    child:
                                        BlocBuilder<DancersBloc, DancersState>(
                                      builder: (context, state) {
                                        return CommonDialog(
                                          dialogTitle:
                                              'Моля, въведете име на танцьора',
                                          isEnabled: state.nameTextController
                                                  ?.text.isNotEmpty ??
                                              false,
                                          onSavePressed: () {
                                            bloc.add(UpdateDancerEvent(
                                              id: dancer.id,
                                              name: state.nameTextController
                                                      ?.text ??
                                                  "",
                                            ));
                                            bloc.add(InitDancersEvent());
                                            locator<NavigationService>().pop();
                                          },
                                          onClosedPressed: () {
                                            bloc.add(OnCloseDialogEvent());
                                            locator<NavigationService>().pop();
                                          },
                                          onNameClearPressed: () =>
                                              bloc.add(OnNameClearEvent(
                                            textController:
                                                state.nameTextController ??
                                                    TextEditingController(),
                                          )),
                                          onNameChanged: (String name) =>
                                              bloc.add(
                                            OnNameChangedEvent(text: name),
                                          ),
                                          isNameNotEmpty: state.isNameNotEmpty,
                                          nameTextController:
                                              state.nameTextController ??
                                                  TextEditingController(),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 16),
                            CommonCircleIconButton(
                              index: index,
                              icon: Icon(Icons.delete,
                                  color:
                                      context.appTheme.colors.surfaceContainer),
                              backgroundColor: context.appTheme.colors.error,
                              onPressed: () {
                                final dancerToDelete = displayList[index];

                                showDialog(
                                  context: context,
                                  builder: (_) => CommonDeleteDialog(
                                    index: dancerToDelete.id ?? 0,
                                    onDeletePressed: () {
                                      bloc.add(RemoveDancerEvent(
                                          id: dancerToDelete.id ?? 0));
                                      bloc.add(InitDancersEvent());
                                      locator<NavigationService>().pop();
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
        ),
      ),
    );
  }
}
