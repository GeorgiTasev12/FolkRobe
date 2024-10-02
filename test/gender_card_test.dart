import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:folk_robe/ui/widgets/gender_card.dart';

void main() {
  testWidgets(
    'Display the card about selecting a gender',
        (WidgetTester tester) async {
      String title = 'Male';
      IconData icon = Icons.male_rounded;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GenderCard(
              title: title,
              icon: icon,
            ),
          ),
        )
      );

      expect(find.text(title), findsOneWidget);
      expect(find.byIcon(icon), findsOneWidget);
    },
  );
}
