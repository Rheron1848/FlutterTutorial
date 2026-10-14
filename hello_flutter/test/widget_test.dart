import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hello_flutter/main.dart';

void main() {
  testWidgets('应用启动后显示标题和欢迎文字', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('我的第一个 Flutter 应用'), findsOneWidget);
    expect(find.text('Hello, Flutter!'), findsOneWidget);
  });

  testWidgets('点击浮动按钮显示 SnackBar', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.touch_app));
    await tester.pump();

    expect(find.text('你点击了按钮！'), findsOneWidget);
  });
}
