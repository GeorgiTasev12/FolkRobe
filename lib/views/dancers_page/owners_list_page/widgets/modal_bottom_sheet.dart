import 'package:flutter/material.dart';
import 'package:folk_robe/common/common_divider.dart';
import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

Future<void> showOwnersBottomsheet({
  required BuildContext context,
  required List<Owner>? allOwnersList,
  required int index,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.appTheme.colors.surfaceContainer,
    builder: (context) {
      final ownersList = allOwnersList?[index]; //state.allOwnersList?[index];
      final itemsList = (ownersList?.items.isEmpty ?? true)
          ? []
          : ownersList!.items.split(', ');

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  allOwnersList?[index].name ?? 'Dancer not found.',
                  style: context.appTheme.textStyles.titleLarge.copyWith(
                    color: context.appTheme.colors.onSurfaceContainer,
                  ),
                ),
                const Spacer(),
                IconButton.filled(
                  onPressed: () => locator<NavigationService>().pop(),
                  icon: Icon(
                    Icons.close,
                    color: context.appTheme.colors.surfaceContainer,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: context.appTheme.colors.onSurfaceContainer,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 2),
          CommonDivider(),
          const SizedBox(height: 5),
          Text(
            allOwnersList?[index].title ?? 'Missing region title.',
            style: context.appTheme.textStyles.titleLarge.copyWith(
              color: context.appTheme.colors.onSurfaceContainer,
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ListView.builder(
                itemCount: itemsList.length,
                itemBuilder: (context, index) {
                  return Text(
                    itemsList[index] ?? '',
                    style: context.appTheme.textStyles.bodyLarge.copyWith(
                      color: context.appTheme.colors.onSurfaceContainer,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      );
    },
  );
}
