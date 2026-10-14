import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_app/main.dart';
import 'package:todo_app/providers/todo_provider.dart';

void main() {
  testWidgets('应用启动后显示待办事项页面', (tester) async {
    // 测试环境下没有真实的 SharedPreferences，使用内存 mock
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => TodoProvider()..loadFromStorage(),
        child: const TodoApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('待办事项'), findsOneWidget);
  });
}
