import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folk_robe/ui/widgets/costume_item.dart';

void main() {
  testWidgets(
    'Display the costume item bar.',
        (WidgetTester tester) async {
      String title = 'Test title';
      bool isTapped = false;

      void onTap() => isTapped = true;

      await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CostumeItem(title: title, onTap: onTap),
            ),
          )
      );

      expect(find.text(title), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(isTapped, true);
    },
  );
}
