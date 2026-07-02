import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/common/common_circle_iconbutton.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/delete_owner_dialog.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/modal_bottom_sheet.dart';

class TempOwnerListTile extends StatelessWidget {
  final int index;
  final AgeGroup ageGroup;
  final GenderType genderType;

  const TempOwnerListTile({
    super.key,
    required this.index,
    required this.ageGroup,
    required this.genderType,
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
          previous.genderTypeValue != current.genderTypeValue ||
          previous.isIndividualItemChecked != current.isIndividualItemChecked,
      builder: (context, state) {
        final displayList = state.ownersFiltered ?? state.allOwnersList ?? [];
        final owner = displayList[index];

        return ListTile(
          onTap: () => showOwnersBottomsheet(
            context: context,
            bloc: bloc,
            allOwnersList: state.allOwnersList, 
            ownerIndex: index,
            deleteOwnerPressed: () => showDialog(
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
            ),
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
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: CommonCircleIconButton(
                index: index,
                icon: Icon(
                  Icons.edit_note_rounded,
                  color: context.appTheme.colors.onSurfaceContainer,
                ),
                backgroundColor: context.appTheme.colors.warning,
                onPressed: () {
                  bloc.add(StartEditOwnerEvent(index: index));
                  bloc.add(
                    SwitchPageEvent(
                      pageIndex: 1,
                      isOwnerEdit: true,
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
