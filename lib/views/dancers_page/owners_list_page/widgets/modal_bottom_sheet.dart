import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folk_robe/common/common_divider.dart';
import 'package:folk_robe/dao/owner.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';
import 'package:folk_robe/views/dancers_page/owners_list_page/bloc/owners_bloc.dart';

Future<void> showOwnersBottomsheet({
  required BuildContext context,
  required List<Owner>? allOwnersList,
  required int ownerIndex,
  required OwnersBloc bloc,
  required void Function() deleteOwnerPressed,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: context.appTheme.colors.surfaceContainer,
    builder: (modalContext) {
      return BlocBuilder<OwnersBloc, OwnersState>(
        bloc: bloc,
        buildWhen: (previous, current) => 
          previous.individualCheckedItemsIndexes != current.individualCheckedItemsIndexes ||
          previous.ownersFiltered != current.ownersFiltered,
        builder: (context, state) {
          final owner = (state.ownersFiltered ?? state.allOwnersList ?? [])[ownerIndex]; 
          final itemsList = (owner.items.isEmpty)
              ? []
              : owner.items.split(', ');

          final bool hasCheckedItems = state.individualCheckedItemsIndexes.isNotEmpty;

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
                      owner.name,
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
                owner.title,
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
                    itemBuilder: (context, itemIndex) {
                      // Read directly from the updated bloc state now!
                      final bool isCurrentItemChecked = state.individualCheckedItemsIndexes.contains(itemIndex);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemsList[itemIndex],
                            style: context.appTheme.textStyles.bodyLarge.copyWith(
                              color: context.appTheme.colors.onSurfaceContainer,
                              decoration: isCurrentItemChecked 
                                  ? TextDecoration.lineThrough 
                                  : TextDecoration.none,
                            ),
                          ),
                          Checkbox(
                            value: isCurrentItemChecked,
                            onChanged: (bool? value) {
                              bloc.add(IndividualToggleCheckEvent(index: itemIndex));
                            },
                            activeColor: context.appTheme.colors.onSurfaceContainer,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SafeArea(
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: !hasCheckedItems ? null : () {
                        locator<NavigationService>().pop();
                        deleteOwnerPressed();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: context.appTheme.colors.onSurfaceContainer,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Върни частично костюма', 
                            style: context.appTheme.textStyles.bodyLarge.copyWith(
                              color: context.appTheme.colors.surfaceContainer,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                          Icon(
                            Icons.delete_rounded,
                            color: context.appTheme.colors.surfaceContainer,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}