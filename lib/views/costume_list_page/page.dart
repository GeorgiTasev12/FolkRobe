import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:folk_robe/common/common_list_tile/common_list_tile.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';
import 'package:folk_robe/views/costume_list_page/widgets/delete_dialog.dart';
import 'package:folk_robe/views/costume_list_page/widgets/empty_info_text.dart';
import 'package:folk_robe/views/costume_list_page/widgets/add_dialog.dart';
import 'package:folk_robe/views/costume_list_page/widgets/circle_button.dart';
import 'package:folk_robe/views/costume_list_page/widgets/update_dialog.dart';

class CostumeListPage extends HookWidget {
  const CostumeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CostumeListBloc>();

    useEffect(() {
      bloc.add(InitDataEvent(options: Options.shopski));
      return null;
    }, const []);

    return BlocBuilder<CostumeListBloc, CostumeListState>(
      buildWhen: (previous, current) =>
          previous.costumeList != current.costumeList,
      builder: (context, state) {
        return CorePage(
          hasFAB: true,
          floatingActionButton: ShowAddCostumeButton(),
          child: state.costumeList?.isEmpty ?? false
              ? EmptyInfoText()
              : BlocBuilder<CostumeListBloc, CostumeListState>(
                  bloc: bloc,
                  buildWhen: (previous, current) => previous.costumeList != current.costumeList,
                  builder: (context, state) {
                    return ListView.separated(
                      itemCount: state.costumeList?.length ?? 0,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        return CommonListTile(
                          title: state.costumeList?[index].title ?? '',
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
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
                ),
        );
      },
    );
  }
}
