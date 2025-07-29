import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:folk_robe/common/common_circle_iconbutton.dart';
import 'package:folk_robe/common/common_delete_dialog.dart';
import 'package:folk_robe/common/common_dialog.dart';
import 'package:folk_robe/common/common_list_tile.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costume_list_page/widgets/empty_info_text.dart';
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
      context.read<DancersBloc>().add(InitDancersEvent());
      return;
    }, const []);

    return CorePage(
      hasFAB: true,
      onFABPressed: () => showDialog(
        context: context,
        builder: (context) {
          return BlocProvider.value(
            value: bloc,
            child: BlocBuilder<DancersBloc, DancersState>(
              buildWhen: (previous, current) =>
                  previous.nameTextController != current.nameTextController ||
                  previous.isNameNotEmpty != current.isNameNotEmpty,
              builder: (context, state) {
                return CommonDialog(
                  onSavePressed: () {
                    bloc.add(AddDancerEvent(
                      name: state.nameTextController?.text ?? "",
                    ));
                    bloc.add(InitDancersEvent());
                    locator<NavigationService>().pop();
                  },
                  onClosedPressed: () {
                    bloc.add(OnCloseDialogEvent());
                    locator<NavigationService>().pop();
                  },
                  onNameClearPressed: () => bloc.add(
                    OnNameClearEvent(
                      textController:
                          state.nameTextController ?? TextEditingController(),
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
      child: BlocBuilder<DancersBloc, DancersState>(
        buildWhen: (previous, current) =>
            previous.dancer != current.dancer ||
            previous.dancersList != current.dancersList ||
            previous.nameTextController != current.nameTextController ||
            previous.isNameNotEmpty != current.isNameNotEmpty,
        builder: (BuildContext context, state) {
          return state.dancersList?.isEmpty ?? false
              ? const EmptyInfoText()
              : ListView.separated(
                  itemCount: state.dancersList?.length ?? 0,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return CommonListTile(
                      title: state.dancersList?[index].name ?? '',
                      suffixWidgets: [
                        CommonCircleIconButton(
                          index: index,
                          icon: Icon(
                            Icons.edit,
                            color: context.appTheme.colors.surfaceContainer,
                          ),
                          backgroundColor: context.appTheme.colors.warning,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (_) => BlocProvider.value(
                              value: bloc,
                              child: BlocBuilder<DancersBloc, DancersState>(
                                builder: (context, state) {
                                  return CommonDialog(
                                    onSavePressed: () {
                                      bloc.add(UpdateDancerEvent(
                                        id: state.dancersList?[index].id,
                                        name: state.nameTextController?.text ??
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
                                    onNameChanged: (String name) => bloc.add(
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
                          ),
                        ),
                        const SizedBox(width: 16),
                        CommonCircleIconButton(
                          index: index,
                          icon: Icon(
                            Icons.delete,
                            color: context.appTheme.colors.surfaceContainer,
                          ),
                          backgroundColor: context.appTheme.colors.error,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => BlocProvider.value(
                              value: bloc,
                              child: BlocBuilder<DancersBloc, DancersState>(
                                buildWhen: (previous, current) =>
                                    previous.id != current.id ||
                                    previous.dancersList != current.dancersList,
                                builder: (context, state) {
                                  if (state.dancersList == null ||
                                      index >=
                                          (state.dancersList?.length ?? 0)) {
                                    return const SizedBox.shrink();
                                  }
                                  return CommonDeleteDialog(
                                    index: state.dancersList?[index].id ?? 0,
                                    onDeletePressed: () {
                                      bloc.add(RemoveDancerEvent(
                                        id: state.dancersList?[index].id ?? 0,
                                      ));
                                      bloc.add(InitDancersEvent());
                                      locator<NavigationService>().pop();
                                    },
                                  );
                                },
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
  }
}
