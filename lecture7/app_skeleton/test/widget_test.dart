import 'package:app_skeleton/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('list page renders the first 20 books from assets', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(800, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const AppSkeletonApp());
    await tester.pumpAndSettle();

    expect(find.text('图书列表'), findsOneWidget);
    expect(find.byType(ListTile), findsNWidgets(20));
    expect(find.text('活着'), findsOneWidget);
  });
}
