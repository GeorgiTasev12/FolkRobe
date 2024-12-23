import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folk_robe/models/costume.dart';

import 'costume_item.dart';
import 'delete_dialog.dart';

class CostumeListView extends ConsumerWidget {
  final List<Costume> costumes;

  const CostumeListView({
    super.key,
    required this.costumes,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: costumes.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return CostumeItem(
          title: costumes[index].title,
          onTap: null,
          onDelete: () => showDialog(
            context: context,
            builder: (context) => DeleteDialog(
              costumes: costumes,
              widgetRef: ref,
              index: index,
            ),
          ),
        );
      },
    );
  }
}