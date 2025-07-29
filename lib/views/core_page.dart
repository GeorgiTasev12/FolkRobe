import 'package:flutter/material.dart';
import 'package:folk_robe/helpers/screen_size_helper.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';
import 'package:folk_robe/theme/styles/colors_and_styles.dart';

class CorePage extends StatelessWidget {
  final Widget child;
  final VoidCallback? onFABPressed;
  final bool? hasAppBar;
  final String? appBarTitle;
  final bool? hasAppBarTitle;
  final bool? hasFAB;

  const CorePage({
    super.key,
    required this.child,
    this.onFABPressed,
    this.appBarTitle,
    this.hasAppBar = true,
    this.hasAppBarTitle = true,
    this.hasFAB = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: hasFAB ?? false
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
      appBar: hasAppBar ?? false
          ? AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () => locator<NavigationService>().pop(),
                icon: const Icon(Icons.arrow_back),
                color: context.appTheme.colors.primary,
              ),
              backgroundColor: context.appTheme.colors.background,
              title: hasAppBarTitle ?? false
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
            )
          : null,
      backgroundColor: context.appTheme.colors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHelper(context).horizontalPadding,
          vertical: 10,
        ),
        child: child,
      ),
    );
  }
}
