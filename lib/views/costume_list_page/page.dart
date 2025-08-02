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
import 'package:folk_robe/views/costume_list_page/widgets/empty_info_text.dart';

class CostumeListPage extends HookWidget {
  const CostumeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CostumeBloc>();

    useEffect(() {
      bloc.add(InitDataEvent(options: Options.shopski));
      return null;
    }, const []);

    return BlocBuilder<CostumeBloc, CostumeState>(
      buildWhen: (previous, current) =>
          previous.costumeList != current.costumeList ||
          previous.id != current.id,
      builder: (context, state) {
        return CorePage(
          hasFAB: true,
          onFABPressed: () => showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: bloc,
                child: BlocBuilder<CostumeBloc, CostumeState>(
                  buildWhen: (previous, current) => previous.nameTextController != current.nameTextController ||
                      previous.quantityTextController != current.quantityTextController ||
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
          child: state.costumeList?.isEmpty ?? false
              ? EmptyInfoText()
              : BlocBuilder<CostumeBloc, CostumeState>(
                  bloc: bloc,
                  buildWhen: (previous, current) =>
                      previous.costumeList != current.costumeList ||
                      previous.id != current.id,
                  builder: (context, state) {
                    return ListView.separated(
                      itemCount: state.costumeList?.length ?? 0,
                      separatorBuilder: (_, index) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        return CommonListTile(
                          title: state.costumeList?[index].title ?? '',
                          quantity: state.costumeList?[index].quantity != null
                              ? state.costumeList![index].quantity.toString()
                              : null,
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
                                            id: state.costumeList?[index].id,
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
                                            previous.costumeList !=
                                                current.costumeList,
                                        builder: (context, state) {
                                          if (state.costumeList == null ||
                                              index >=
                                                  state.costumeList!.length) {
                                            return const SizedBox.shrink();
                                          }
                                          return CommonDeleteDialog(
                                            index:
                                                state.costumeList![index].id ??
                                                    0,
                                            onDeletePressed: () {
                                              bloc.add(RemoveCostumeEvent(
                                                id: state.costumeList![index]
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
