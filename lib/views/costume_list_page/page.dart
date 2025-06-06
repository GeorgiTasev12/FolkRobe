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
import 'package:folk_robe/bloc/costume_bloc.dart';
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
          previous.costumeList != current.costumeList,
      builder: (context, state) {
        return CorePage(
          hasFAB: true,
          onFABPressed: () => showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: bloc,
                child: CommonDialog(
                  onPressed: () {
                    bloc.add(AddCostumeEvent(
                      title: state.nameTextController?.text ?? "",
                      quantity: state.quantityTextController?.text,
                    ));
                    bloc.add(InitDataEvent());
                    locator<NavigationService>().pop();
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
                      previous.costumeList != current.costumeList,
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
                          contentPadding: const EdgeInsets.only(
                            right: 5,
                            left: 15,
                          ),
                          suffixWidgets: [
                            ClipOval(
                              child: Material(
                                color: context.appTheme.colors.warning,
                                child: IconButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (_) => BlocProvider.value(
                                      value: bloc,
                                      child: CommonDialog(onPressed: () {
                                        bloc.add(UpdateCostumeEvent(
                                          id: state.costumeList?[index].id,
                                          title:
                                              state.nameTextController?.text ??
                                                  "",
                                          quantity: state
                                              .quantityTextController?.text,
                                        ));
                                        bloc.add(InitDataEvent());
                                        locator<NavigationService>().pop();
                                      }),
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
                                    builder: (_) => BlocProvider.value(
                                      value: bloc,
                                      child: DeleteDialog(
                                          index: state.costumeList?[index].id ??
                                              0),
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
