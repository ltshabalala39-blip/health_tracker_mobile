import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_tracker_mobile/main.dart';

void main() {
  // Test 1: Testing the Card UI and Null Fallback
  testWidgets('MortalityCard displays week and handles null deaths', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MortalityCard(week: 'Week 42', deaths: null),
        ),
      ),
    );

    expect(find.text('Week: Week 42'), findsOneWidget);
    expect(find.text('Deaths: No Data'), findsOneWidget);
  });

  // Test 2: Testing the Summary Header
  testWidgets('DataSummaryHeader displays correct record count', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DataSummaryHeader(recordCount: 52),
        ),
      ),
    );

    expect(find.text('Showing 52 records'), findsOneWidget);
  });
}