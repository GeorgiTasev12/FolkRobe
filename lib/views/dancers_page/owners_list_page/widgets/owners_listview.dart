import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/empty_info.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/widgets/temp_owner_listtile.dart';

class OwnersListView extends StatelessWidget {
  const OwnersListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnersBloc, OwnersState>(
        buildWhen: (previous, current) =>
            previous.allOwnersList != current.allOwnersList ||
            previous.ownersFiltered != current.ownersFiltered ||
            previous.querySearch != current.querySearch ||
            previous.isLoading != current.isLoading,
        builder: (context, state) {
          final displayList = state.ownersFiltered ?? state.allOwnersList ?? [];

          if (state.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: context.appTheme.colors.primary,
              ),
            );
          }

          if ((state.allOwnersList?.isEmpty ?? true)) {
            // Full list is empty
            return Center(
              child: EmptyInfoText(),
            );
          } else if (displayList.isEmpty) {
            // List filtered by search but no results
            return Center(
              child: Text(
                'Няма резултати..',
                style: context.appTheme.textStyles.titleMedium
                    .copyWith(color: context.appTheme.colors.primary),
              ),
            );
          }

          return ListView.separated(
            itemCount: displayList.length,
            separatorBuilder: (context, idnex) => const SizedBox(height: 10),
            itemBuilder: (context, index) => TempOwnerListTile(
              index: index,
            ),
          );
        });
  }
}
