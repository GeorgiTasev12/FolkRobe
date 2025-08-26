import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:folk_robe/common/common_dialog.dart';
import 'package:folk_robe/common/common_list_tile.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';
import 'package:folk_robe/common/common_delete_dialog.dart';
import 'package:folk_robe/common/common_empty_info_text.dart';

class CostumeListPage extends HookWidget {
  const CostumeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CostumeBloc>();

    useEffect(() {
      bloc.add(InitDataEvent(options: Options.shopska));
      return null;
    }, const []);

    return BlocBuilder<CostumeBloc, CostumeState>(
      buildWhen: (previous, current) =>
          previous.id != current.id ||
          previous.allCostumesList != current.allCostumesList ||
          previous.costumeFiltered != current.costumeFiltered ||
          previous.searchTextController != current.searchTextController,
      builder: (context, state) {
        return CorePage(
          hasFAB: true,
          hasAppBarTitle: true,
          appBarTitle: 'Костюми',
          onFABPressed: () => showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: bloc,
                child: BlocBuilder<CostumeBloc, CostumeState>(
                  buildWhen: (previous, current) =>
                      previous.nameTextController !=
                          current.nameTextController ||
                      previous.quantityTextController !=
                          current.quantityTextController ||
                      previous.isNameNotEmpty != current.isNameNotEmpty ||
                      previous.isQuantityNotEmpty != current.isQuantityNotEmpty,
                  builder: (context, state) {
                    return CommonDialog(
                      dialogTitle: 'Моля, въведете реквизит.',
                      onSavePressed: () {
                        bloc.add(AddCostumeEvent(
                          title: state.nameTextController?.text ?? "",
                          quantity: state.quantityTextController?.text,
                        ));
                        bloc.add(InitDataEvent());
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
                      onQuantityClearPressed: () => bloc.add(
                        OnQuantityClearEvent(
                          textController: state.quantityTextController ??
                              TextEditingController(),
                        ),
                      ),
                      onNameChanged: (String name) => bloc.add(
                        OnNameChangedEvent(text: name),
                      ),
                      onNumberChanged: (String number) => bloc.add(
                        OnQuantityChangedEvent(number: number),
                      ),
                      nameTextController:
                          state.nameTextController ?? TextEditingController(),
                      quantityTextController: state.quantityTextController ??
                          TextEditingController(),
                      isNameNotEmpty: state.isNameNotEmpty,
                      isQuantityNotEmpty: state.isQuantityNotEmpty,
                    );
                  },
                ),
              );
            },
          ),
          hasSearchBar: true,
          onSearchChanged: (value) =>
              bloc.add(SearchCostumeEvent(query: value)),
          searchTextController: state.searchTextController,
          isSuffixIconVisible: state.querySearch?.isNotEmpty,
          onSuffixPressed: () => bloc.add(
            OnSearchClearEvent(
              textController:
                  state.searchTextController ?? TextEditingController(),
            ),
          ),
          child: state.allCostumesList?.isEmpty ?? false
              ? CommonEmptyInfoText(isDancer: false)
              : BlocBuilder<CostumeBloc, CostumeState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      previous.allCostumesList != current.allCostumesList ||
                      previous.id != current.id ||
                      previous.costumeFiltered != current.costumeFiltered,
                  builder: (context, state) {
                    final displayList =
                        state.costumeFiltered ?? state.allCostumesList ?? [];

                    if (displayList.isEmpty) {
                      return Text(
                        'Няма резултати..',
                        style: context.appTheme.textStyles.titleMedium.copyWith(
                          color: context.appTheme.colors.primary,
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: displayList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final costume = displayList[index];

                        return CommonListTile(
                          title: costume.title,
                          quantity: costume.quantity.toString(),
                          suffixWidgets: [
                            ClipOval(
                              child: Material(
                                color: context.appTheme.colors.warning,
                                child: IconButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) => BlocProvider.value(
                                      value: bloc,
                                      child: CommonDialog(
                                        dialogTitle: 'Моля, въведете реквизит.',
                                        onSavePressed: () {
                                          bloc.add(UpdateCostumeEvent(
                                            id: costume.id,
                                            title: state
                                                    .nameTextController?.text ??
                                                "",
                                            quantity: state
                                                .quantityTextController?.text,
                                          ));
                                          bloc.add(InitDataEvent());
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
                                        onQuantityClearPressed: () => bloc.add(
                                          OnQuantityClearEvent(
                                            textController:
                                                state.quantityTextController ??
                                                    TextEditingController(),
                                          ),
                                        ),
                                        onNameChanged: (String name) =>
                                            bloc.add(
                                          OnNameChangedEvent(text: name),
                                        ),
                                        onNumberChanged: (String number) =>
                                            bloc.add(
                                          OnQuantityChangedEvent(
                                              number: number),
                                        ),
                                        isNameNotEmpty: state.isNameNotEmpty,
                                        isQuantityNotEmpty:
                                            state.isQuantityNotEmpty,
                                        nameTextController:
                                            state.nameTextController ??
                                                TextEditingController(),
                                        quantityTextController:
                                            state.quantityTextController,
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.edit,
                                    color: context
                                        .appTheme.colors.surfaceContainer,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ClipOval(
                              child: Material(
                                color: context.appTheme.colors.error,
                                child: IconButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => BlocProvider.value(
                                      value: bloc,
                                      child: BlocBuilder<CostumeBloc,
                                          CostumeState>(
                                        buildWhen: (previous, current) =>
                                            previous.id != current.id ||
                                            previous.allCostumesList !=
                                                current.allCostumesList ||
                                            previous.costumeFiltered !=
                                                current.costumeFiltered,
                                        builder: (context, state) {
                                          if (state.allCostumesList == null ||
                                              index >=
                                                  state.allCostumesList!
                                                      .length) {
                                            return const SizedBox.shrink();
                                          }
                                          return CommonDeleteDialog(
                                            index: state.allCostumesList![index]
                                                    .id ??
                                                0,
                                            onDeletePressed: () {
                                              bloc.add(RemoveCostumeEvent(
                                                id: state
                                                        .allCostumesList![index]
                                                        .id ??
                                                    0,
                                              ));
                                              bloc.add(InitDataEvent());
                                              locator<NavigationService>()
                                                  .pop();
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  icon: Icon(
                                    Icons.delete,
                                    color: context
                                        .appTheme.colors.surfaceContainer,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
