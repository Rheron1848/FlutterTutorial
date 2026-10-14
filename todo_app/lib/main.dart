import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/todo_provider.dart';
import 'router.dart';
import 'theme.dart';

void main() {
  runApp(
    // MultiProvider：多个 ChangeNotifier 集中注入
    // （类比 Python 的依赖注入容器，一次配置全局取用）
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
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '待办事项',
      routerConfig: appRouter,
      theme: lightTheme,
      darkTheme: darkTheme,
      // context.watch：主题模式变化时整个应用换肤重建
      themeMode: context.watch<ThemeProvider>().mode,
    );
  }
}
