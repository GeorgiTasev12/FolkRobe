import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';
import 'package:folk_robe/views/costume_list_page/widgets/update_dialog.dart';

import 'costume_item.dart';
import 'delete_dialog.dart';

class CostumeListView extends StatelessWidget {
  const CostumeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CostumeListBloc>();

    return BlocBuilder<CostumeListBloc, CostumeListState>(
      bloc: bloc,
      buildWhen: (previous, current) =>
          previous.costumeList != current.costumeList,
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.costumeList?.length ?? 0,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return CostumeItem(
              title: state.costumeList?[index].title ?? '',
              onTap: null,
              onUpdate: () => showDialog(
                context: context,
                builder: (context) => BlocProvider.value(
                  value: bloc,
                  child: UpdateDialog(index: state.costumeList?[index].id ?? 0),
                ),
              ),
              onDelete: () => showDialog(
                context: context,
                builder: (context) => BlocProvider.value(
                  value: bloc,
                  child: DeleteDialog(index: state.costumeList?[index].id ?? 0),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
