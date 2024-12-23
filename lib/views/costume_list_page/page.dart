import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folk_robe/views/core_page.dart';
import 'package:folk_robe/views/costume_list_page/providers/costumes_list_provider.dart';
import 'package:folk_robe/views/costume_list_page/widgets/add_info_text.dart';
import 'package:folk_robe/views/costume_list_page/widgets/add_dialog.dart';
import 'package:folk_robe/views/costume_list_page/widgets/costume_listview.dart';

class CostumeListPage extends StatelessWidget {
  const CostumeListPage({super.key});

  @override
  Widget build(BuildContext context) => ProviderScope(
        child: _CostumeListPageState(),
      );
}

class _CostumeListPageState extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final costumes = ref.watch(costumesProvider);
    final notifier = ref.watch(costumesProvider.notifier);

    return CorePage(
      hasAppBar: true,
      hasBackButton: true,
      hasFAB: true,
      floatingActionButton: ShowAddCostumeButton(
        costumes: notifier,
      ),
      child: costumes.isEmpty
          ? AddInfoText()
          : CostumeListView(costumes: costumes),
    );
  }
}