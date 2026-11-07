import 'package:app_skeleton/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var appKey = 0;

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 4000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
    rootBundle.evict('assets/data/books.json');
    appKey++;
    await tester.pumpWidget(Lecture7App(key: ValueKey(appKey)));
    await tester.pumpAndSettle();
  }

  Future<void> pumpUntilFound(WidgetTester tester, Finder finder) async {
    for (var i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      if (finder.evaluate().isNotEmpty) {
        await tester.pump(const Duration(milliseconds: 300));
        return;
      }
    }
    fail('Timed out waiting for $finder');
  }

  testWidgets('home -> category list -> detail -> back', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    expect(find.text('图书分类'), findsOneWidget);
    expect(find.text('全部图书'), findsOneWidget);

    await tester.tap(find.text('文学'));
    await pumpUntilFound(tester, find.text('活着'));

    expect(find.text('活着'), findsOneWidget);

    await tester.tap(find.text('活着'));
    await pumpUntilFound(tester, find.text('图书详情'));

    expect(find.text('B001'), findsOneWidget);
    expect(find.text('余华'), findsOneWidget);

    await tester.tap(find.byTooltip('返回'));
    await pumpUntilFound(tester, find.text('活着'));
  });

  testWidgets('long press returns a typed filter result to home', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('文学'));
    await pumpUntilFound(tester, find.text('活着'));

    await tester.longPress(find.text('活着'));
    await pumpUntilFound(tester, find.text('仅看高借阅量'));

    await tester.tap(find.text('仅看高借阅量'));
    await pumpUntilFound(tester, find.text('仅看高借阅量 · 文学'));
  });

  testWidgets('load more appends 20 books each time', (
    WidgetTester tester,
  ) async {
    await pumpApp(tester);

    await tester.tap(find.text('全部图书'));
    await pumpUntilFound(tester, find.byType(ListTile));

    expect(find.byType(ListTile), findsNWidgets(20));
    expect(find.textContaining('加载更多'), findsOneWidget);

    await tester.tap(find.textContaining('加载更多'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(ListTile), findsNWidgets(40));
  });
}
