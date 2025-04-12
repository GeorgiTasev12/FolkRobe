import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costume_list_page/bloc/costume_bloc.dart';
import 'package:folk_robe/views/costume_list_page/widgets/empty_info_text.dart';
import 'package:folk_robe/views/costume_list_page/widgets/add_dialog.dart';
import 'package:folk_robe/views/costume_list_page/widgets/costume_listview.dart';


class CostumeListPage extends HookWidget {
  const CostumeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      context.read<CostumeListBloc>().add(InitDataEvent());
      return null;
    }, const []);

    return BlocBuilder<CostumeListBloc, CostumeListState>(
      buildWhen: (previous, current) => previous.costumeList != current.costumeList,
      builder: (context, state) {
        return CorePage(
          hasFAB: true,
          floatingActionButton: ShowAddCostumeButton(),
          child: state.costumeList?.isEmpty ?? false
              ? EmptyInfoText()
              : CostumeListView(),
        );
      },
    );
  }
}