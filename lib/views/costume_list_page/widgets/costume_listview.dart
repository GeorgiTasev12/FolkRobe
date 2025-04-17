import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/common/common_list_tile/common_list_tile.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';
import 'package:folk_robe/views/costume_list_page/widgets/delete_dialog.dart';
import 'package:folk_robe/views/costume_list_page/widgets/update_dialog.dart';

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
            return CommonListTile(
              title: state.costumeList?[index].title ?? '',
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              suffixWidgets: [
                CommonCircleComponentButton(
                  index: index,
                  backgroundColor: context.appTheme.colors.warning,
                  icon: Icon(
                    Icons.edit,
                    color: context.appTheme.colors.surfaceContainer,
                  ),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: bloc,
                      child: UpdateDialog(
                          index: state.costumeList?[index].id ?? 0),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                CommonCircleComponentButton(
                  index: index,
                  backgroundColor: context.appTheme.colors.error,
                  icon: Icon(
                    Icons.delete,
                    color: context.appTheme.colors.surfaceContainer,
                  ),
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: bloc,
                      child: DeleteDialog(
                          index: state.costumeList?[index].id ?? 0),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}

class CommonCircleComponentButton extends StatelessWidget {
  final int index;
  final Icon icon;
  final void Function() onTap;
  final Color? backgroundColor;

  const CommonCircleComponentButton({
    required this.index,
    required this.onTap,
    required this.icon,
    this.backgroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: backgroundColor,
        child: IconButton(
          onPressed: onTap,
          icon: icon,
        ),
      ),
    );
  }
}
