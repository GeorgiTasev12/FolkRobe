import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folk_robe/common/common_list_tile/common_list_tile.dart';
import 'package:folk_robe/theme/app_theme.dart';

void main() {
  testWidgets(
    'Display the costume item bar.',
    (WidgetTester tester) async {
      String title = 'Test title';
      bool isTapped = false;

      void onTap() => isTapped = true;

      await tester.pumpWidget(
        MaterialApp(
          themeMode: ThemeMode.system,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          home: Scaffold(
            body: CommonListTile(
              title: title,
              suffixWidgets: [
                IconButton(
                  onPressed: onTap,
                  icon: Icon(Icons.abc),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);

      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(isTapped, true);
    },
  );
}
