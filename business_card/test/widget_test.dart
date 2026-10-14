import 'package:flutter_test/flutter_test.dart';

import 'package:business_card/main.dart';

void main() {
  testWidgets('应用启动后显示底部导航的三个标签页', (tester) async {
    await tester.pumpWidget(const BusinessCardApp());

    expect(find.text('首页'), findsOneWidget);
    expect(find.text('技能'), findsOneWidget);
    expect(find.text('联系'), findsOneWidget);
  });

  testWidgets('点击导航栏可以切换到不同页面', (tester) async {
    await tester.pumpWidget(const BusinessCardApp());

    // 切换到"技能"标签后，应显示技能页面特有的内容
    await tester.tap(find.text('技能'));
    await tester.pump();

    expect(find.text('移动开发'), findsOneWidget);
  });
}
