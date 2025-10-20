import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/delete_owner_dialog.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/modal_bottom_sheet.dart';

class TempOwnerListTile extends StatelessWidget {
  final int index;

  const TempOwnerListTile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OwnersBloc>();

    return BlocBuilder<OwnersBloc, OwnersState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.allOwnersList != current.allOwnersList ||
          previous.id != current.id ||
          previous.selectedItems != current.selectedItems ||
          previous.ownersFiltered != current.ownersFiltered ||
          previous.querySearch != current.querySearch ||
          previous.genderTypeValue != current.genderTypeValue ||
          previous.pageIndex != current.pageIndex ||
          previous.isOwnerEdit != current.isOwnerEdit ||
          previous.genderTypeValue != current.genderTypeValue,
      builder: (context, state) {
        final displayList = state.ownersFiltered ?? state.allOwnersList ?? [];
        final owner = displayList[index];

        return ListTile(
          onTap: () => showOwnersBottomsheet(
              context: context, 
              allOwnersList: state.allOwnersList, 
              index: index,
            ),
          title: Text(
            owner.name,
            style: context.appTheme.textStyles.titleLarge.copyWith(
              color: context.appTheme.colors.onSurfaceContainer,
            ),
          ),
          subtitle: Text(
            'Носия: ${owner.title}',
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
                    bloc.add(StartEditOwnerEvent(index: index));
                    bloc.add(
                      SwitchPageEvent(
                        pageIndex: 1,
                        isOwnerEdit: true,
                      ),
                    );
                    break;

                  case 2:
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider.value(
                        value: bloc,
                        child: DeleteOwnerDialog(
                          onDeletePressed: () {
                            bloc.add(
                                RemoveTemporaryOwnerEvent(id: owner.id ?? 0));
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
