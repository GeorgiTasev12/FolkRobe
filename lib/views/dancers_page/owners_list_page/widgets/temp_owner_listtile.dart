import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/common/common_divider.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/delete_owner_dialog.dart';

class TempOwnerListTile extends StatelessWidget {
  final int index;
  final GenderType genderType;

  const TempOwnerListTile({
    super.key,
    required this.index,
    required this.genderType,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OwnersBloc>();

    return BlocBuilder<OwnersBloc, OwnersState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.ownersList != current.ownersList ||
          previous.id != current.id ||
          previous.selectedItems != current.selectedItems,
      builder: (context, state) {
        return ListTile(
          title: Text(
            state.ownersList?[index].name ?? '',
            style: context.appTheme.textStyles.titleLarge.copyWith(
              color: context.appTheme.colors.onSurfaceContainer,
            ),
          ),
          subtitle: Text(
            'Носия: ${state.ownersList?[index].title}',
            style: context.appTheme.textStyles.bodyLarge.copyWith(
              color: context.appTheme.colors.onSurfaceContainer,
            ),
          ),
          tileColor: context.appTheme.colors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: context.appTheme.colors.outline,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.only(left: 15),
          trailing: Theme(
            data: Theme.of(context).copyWith(
              popupMenuTheme: PopupMenuThemeData(
                color: context.appTheme.colors.surfaceContainer,
                textStyle: context.appTheme.textStyles.labelMedium.copyWith(
                  color: context.appTheme.colors.onSurfaceContainer,
                ),
              ),
            ),
            child: PopupMenuButton(
              icon: Icon(
                Icons.more_vert,
                color: context.appTheme.colors.onSurfaceContainer,
              ),
              onSelected: (value) {
                switch (value) {
                  case 1:
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: context.appTheme.colors.surfaceContainer,
                      builder: (context) {
                        final ownersList = state.ownersList?[index];
                        final itemsList = (ownersList?.items.isEmpty ?? true)
                            ? []
                            : ownersList!.items.split(', ');

                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    state.ownersList?[index].name ??
                                        'Dancer not found.',
                                    style: context
                                        .appTheme.textStyles.titleLarge
                                        .copyWith(
                                      color: context
                                          .appTheme.colors.onSurfaceContainer,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton.filled(
                                    onPressed: () =>
                                        locator<NavigationService>().pop(),
                                    icon: Icon(
                                      Icons.close,
                                      color: context
                                          .appTheme.colors.surfaceContainer,
                                    ),
                                    style: IconButton.styleFrom(
                                      backgroundColor: context
                                          .appTheme.colors.onSurfaceContainer,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 2),
                            CommonDivider(),
                            const SizedBox(height: 5),
                            Text(
                              state.ownersList?[index].title ??
                                  'Missing region title.',
                              style: context.appTheme.textStyles.titleLarge
                                  .copyWith(
                                color:
                                    context.appTheme.colors.onSurfaceContainer,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: ListView.builder(
                                  itemCount: itemsList.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      itemsList[index] ?? '',
                                      style: context
                                          .appTheme.textStyles.bodyLarge
                                          .copyWith(
                                        color: context
                                            .appTheme.colors.onSurfaceContainer,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    break;

                  case 2:
                    bloc.add(StartEditOwnerEvent(index: index));
                    bloc.add(SwitchPageEvent(pageIndex: 1, isOwnerEdit: true));
                    break;

                  case 3:
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider.value(
                        value: bloc,
                        child: DeleteOwnerDialog(
                          onDeletePressed: () {
                            bloc.add(RemoveTemporaryOwnerEvent(
                                id: state.ownersList?[index].id ?? 0));
                            locator<NavigationService>().pop();
                          },
                        ),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(
                          Icons.remove_red_eye_rounded,
                          color: context.appTheme.colors.onSurfaceContainer,
                        ),
                        const SizedBox(width: 8),
                        Text('Преглед'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.edit_note_rounded,
                          color: context.appTheme.colors.warning,
                        ),
                        const SizedBox(width: 8),
                        Text('Промени'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.delete_rounded,
                          color: context.appTheme.colors.error,
                        ),
                        const SizedBox(width: 8),
                        Text('Изтрий'),
                      ],
                    ),
                  ),
                ];
              },
            ),
          ),
        );
      },
    );
  }
}
