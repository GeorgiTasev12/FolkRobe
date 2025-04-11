import 'package:flutter/material.dart';
import 'package:folk_robe/constants.dart';
import 'package:folk_robe/locator.dart';
import 'package:folk_robe/service/navigation_service.dart';

class CorePage extends StatelessWidget {
  final Widget child;
  final bool? hasAppBar;
  final String? appBarTitle;
  final bool? hasAppBarTitle;
  final bool? hasFAB;
  final Widget? floatingActionButton;

  const CorePage({
    super.key,
    required this.child,
    this.appBarTitle,
    this.hasAppBar = true,
    this.hasAppBarTitle = true,
    this.hasFAB = false,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: hasFAB ?? false
          ? floatingActionButton
          : null,
      appBar:
          hasAppBar ?? false
              ? AppBar(
                automaticallyImplyLeading: false,
                leading: IconButton(
                    onPressed: () => locator<NavigationService>().pop(),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                backgroundColor: Colors.blueGrey,
                title: hasAppBarTitle ?? false
                  ? FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Text(
                      appBarTitle ?? "",
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ) : null,
              ) : null,
        backgroundColor: Colors.blueGrey,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: child,
        ),
    );
  }
}