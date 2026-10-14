import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:todo_app/main.dart';
import 'package:todo_app/providers/theme_provider.dart';
import 'package:todo_app/providers/todo_provider.dart';

void main() {
  testWidgets('应用启动后显示待办事项页面', (tester) async {
    // 测试环境下没有真实的 SharedPreferences，使用内存 mock
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(
      // 新入口：MultiProvider + MaterialApp.router（routerConfig 在 TodoApp 内部）
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => TodoProvider()..loadFromStorage(),
          ),
          ChangeNotifierProvider(
            create: (_) => ThemeProvider()..loadFromStorage(),
          ),
        ],
        child: const TodoApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('待办事项'), findsOneWidget);
  });

  testWidgets('设置页切换为深色模式后 ThemeMode 变为 dark', (tester) async {
    SharedPreferences.setMockInitialValues({});

    // 持有 provider 引用，方便切换后直接断言状态
    final todoProvider = TodoProvider()..loadFromStorage();
    final themeProvider = ThemeProvider()..loadFromStorage();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: todoProvider),
          ChangeNotifierProvider.value(value: themeProvider),
        ],
        child: const TodoApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 默认跟随系统，MaterialApp 的 themeMode 还不是 dark
    expect(themeProvider.mode, ThemeMode.system);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      isNot(ThemeMode.dark),
    );

    // 通过底部导航进入设置页
    await tester.tap(find.text('设置'));
    await tester.pumpAndSettle();
    expect(find.text('外观'), findsOneWidget);

    // 选择「深色」
    await tester.tap(find.text('深色'));
    await tester.pumpAndSettle();

    // ThemeProvider 状态与 MaterialApp 实际生效的 themeMode 都应为 dark
    expect(themeProvider.mode, ThemeMode.dark);
    expect(
      tester.widget<MaterialApp>(find.byType(MaterialApp)).themeMode,
      ThemeMode.dark,
    );
  });

  testWidgets('点击任务行通过路由进入任务详情页', (tester) async {
    SharedPreferences.setMockInitialValues({});

    final todoProvider = TodoProvider()..loadFromStorage();
    final themeProvider = ThemeProvider()..loadFromStorage();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: todoProvider),
          ChangeNotifierProvider.value(value: themeProvider),
        ],
        child: const TodoApp(),
      ),
    );
    await tester.pumpAndSettle();

    // 上一个用例可能把全局路由留在了设置页，先切回任务列表 tab
    await tester.tap(find.text('任务'));
    await tester.pumpAndSettle();

    // 输入任务并点击「添加」
    await tester.enterText(find.byType(TextFormField), '写阶段五测试');
    await tester.tap(find.text('添加'));
    await tester.pumpAndSettle();
    expect(find.text('写阶段五测试'), findsOneWidget);

    // 点击任务行 → typed route 跳转到 /task/:id
    await tester.tap(find.text('写阶段五测试'));
    await tester.pumpAndSettle();

    // 详情页特有的文案：标题栏、创建时间、优先级
    expect(find.text('任务详情'), findsOneWidget);
    expect(find.text('创建时间'), findsOneWidget);
    expect(find.text('优先级'), findsOneWidget);
    expect(find.text('写阶段五测试'), findsOneWidget);
    // 详情页是全屏页（在 shell 之外声明），底部导航应不可见
    expect(find.text('任务'), findsNothing);
  });
}
