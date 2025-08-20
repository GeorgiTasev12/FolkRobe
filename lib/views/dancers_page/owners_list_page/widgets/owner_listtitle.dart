import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';

class OwnersListTile extends StatelessWidget {
  final int index;

  const OwnersListTile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<OwnersBloc>();

    return BlocBuilder<OwnersBloc, OwnersState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.costumesTitles != current.costumesTitles ||
          previous.checkedCostumeIndexes != current.checkedCostumeIndexes,
      builder: (context, state) {
        return ListTile(
          title: Text(
            state.costumesTitles?[index] ?? '',
            style: context.appTheme.textStyles.bodyLarge.copyWith(
              color: context.appTheme.colors.onSurfaceContainer,
            ),
          ),
          minVerticalPadding: 15,
          contentPadding: EdgeInsets.only(left: 10, right: 5),
          tileColor: context.appTheme.colors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: context.appTheme.colors.outline,
              width: 2,
            ),
          ),
          trailing: Checkbox(
            value: state.checkedCostumeIndexes.contains(index),
            onChanged: (_) => bloc.add(ToggleCheckEvent(index: index)),
            activeColor: context.appTheme.colors.onSurfaceContainer,
          ),
        );
      },
    );
  }
}
