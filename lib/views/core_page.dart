import 'package:flutter/material.dart';
import 'package:folk_robe/common/common_divider.dart';
import 'package:folk_robe/common/common_textfield.dart';
import 'package:folk_robe/helpers/screen_size_helper.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/models/options.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CorePage extends StatelessWidget {
  final Widget child;
  final VoidCallback? onFABPressed;
  final bool hasAppBar;
  final String? appBarTitle;
  final bool hasAppBarTitle;
  final bool hasFAB;
  final bool hasSearchBar;
  final ValueChanged<String>? onSearchChanged;
  final IconButton? suffixingSearchIcon;
  final TextEditingController? searchTextController;
  final bool isSuffixIconVisible;
  final VoidCallback? onSuffixPressed;
  final VoidCallback? onPopPressed;
  final bool hasFilterMenu;
  final bool isFilterSelected;
  final void Function(GenderType?)? onSelectedFilter;
  final GenderType? initialFilterValue;

  const CorePage({
    super.key,
    required this.child,
    this.onFABPressed,
    this.appBarTitle,
    this.hasAppBar = true,
    this.hasAppBarTitle = true,
    this.hasFAB = false,
    this.hasSearchBar = false,
    this.onSearchChanged,
    this.suffixingSearchIcon,
    this.searchTextController,
    this.isSuffixIconVisible = false,
    this.onSuffixPressed,
    this.onPopPressed,
    this.onSelectedFilter,
    this.hasFilterMenu = false,
    this.isFilterSelected = false,
    this.initialFilterValue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: hasFAB
          ? FloatingActionButton(
              backgroundColor: context.appTheme.colors.surfaceContainer,
              onPressed: onFABPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.add,
                color: context.appTheme.colors.onSurfaceContainer,
              ),
            )
          : null,
      appBar: hasAppBar
          ? AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  if (onPopPressed != null) {
                    onPopPressed!();
                  } else {
                    locator<NavigationService>().pop();
                  }
                },
                icon: const Icon(Icons.arrow_back),
                color: context.appTheme.colors.primary,
              ),
              backgroundColor: context.appTheme.colors.background,
              title: hasAppBarTitle
                  ? FittedBox(
                      fit: BoxFit.fitHeight,
                      child: Text(
                        appBarTitle ?? "",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 18,
                          color: context.appTheme.colors.primary,
                        ),
                      ),
                    )
                  : null,
              bottom: hasSearchBar
                  ? PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CommonTextfield(
                                    textController: searchTextController ??
                                        TextEditingController(),
                                    onChanged: onSearchChanged,
                                    hintText: 'Търси...',
                                    suffixIconButton: isSuffixIconVisible
                                        ? IconButton(
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              color: context.appTheme.colors
                                                  .onSurfaceContainer,
                                            ),
                                            onPressed: onSuffixPressed,
                                          )
                                        : null,
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      color: context
                                          .appTheme.colors.onSurfaceContainer,
                                    ),
                                    isSearchTextField: true,
                                  ),
                                ),
                                if (hasFilterMenu)
                                  FilterGenderPopupMenu(
                                    initialFilterValue: initialFilterValue,
                                    onSelectedFilter: onSelectedFilter,
                                  ),
                              ],
                            ),
                          ),
                          CommonDivider(),
                        ],
                      ),
                    )
                  : null,
            )
          : null,
      backgroundColor: context.appTheme.colors.background,
      body: Padding(
        padding: (hasSearchBar)
            ? EdgeInsets.only(
                left: ScreenSizeHelper(context).horizontalPadding,
                right: ScreenSizeHelper(context).horizontalPadding,
                top: 15,
              )
            : EdgeInsets.symmetric(
                horizontal: ScreenSizeHelper(context).horizontalPadding,
                vertical: 10,
              ),
        child: child,
      ),
    );
  }
}

class FilterGenderPopupMenu extends StatelessWidget {
  const FilterGenderPopupMenu({
    super.key,
    required this.initialFilterValue,
    required this.onSelectedFilter,
  });

  final GenderType? initialFilterValue;
  final void Function(GenderType? p1)? onSelectedFilter;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: context.appTheme.colors.surfaceContainer,
          textStyle: context.appTheme.textStyles.labelMedium.copyWith(
            color: context.appTheme.colors.onSurfaceContainer,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
      ),
      child: PopupMenuButton<GenderType>(
        icon: Icon(Icons.filter_alt),
        iconColor: context.appTheme.colors.onSurfaceContainer,
        initialValue: initialFilterValue,
        onSelected: onSelectedFilter,
        itemBuilder: (context) => <PopupMenuEntry<GenderType>>[
          PopupMenuItem<GenderType>(
            value: GenderType.none,
            child: ListTile(
              title: Text(GenderType.none.genderName),
              titleTextStyle: context.appTheme.textStyles.bodyLarge.copyWith(
                color: context.appTheme.colors.onSurfaceContainer,
              ),
              tileColor: context.appTheme.colors.surfaceContainer,
            ),
          ),
          PopupMenuItem<GenderType>(
            value: GenderType.male,
            child: ListTile(
              title: Text(GenderType.male.genderName),
              titleTextStyle: context.appTheme.textStyles.bodyLarge.copyWith(
                color: context.appTheme.colors.onSurfaceContainer,
              ),
              tileColor: context.appTheme.colors.surfaceContainer,
            ),
          ),
          PopupMenuItem<GenderType>(
            value: GenderType.female,
            child: ListTile(
              title: Text(GenderType.female.genderName),
              titleTextStyle: context.appTheme.textStyles.bodyLarge.copyWith(
                color: context.appTheme.colors.onSurfaceContainer,
              ),
              tileColor: context.appTheme.colors.surfaceContainer,
            ),
          ),
        ],
      ),
    );
  }
}

PopupMenuItem<GenderType> genderMenuItem({
  required BuildContext context,
  required GenderType selectedGender,
  required String label,
  required GenderType? value,
}) {
  return PopupMenuItem(
    value: value,
    child: ListTile(
      title: Text(label),
      titleTextStyle: context.appTheme.textStyles.titleMedium.copyWith(
        color: context.appTheme.colors.onSurfaceContainer,
      ),
      tileColor: context.appTheme.colors.surfaceContainer,
    ),
  );
}
