import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/settings_screen.dart';
import 'screens/task_detail_screen.dart';
import 'screens/todo_screen.dart';

// build_runner 会依据下方的注解生成 router.g.dart（类比 Python 的代码生成器，
// 如 dataclasses / attrs 在 import 时展开：这里的生成是显式跑命令）。
part 'router.g.dart';

/// 应用路由器（全局单例，供 MaterialApp.router 使用）。
///
/// Python 类比：类似把 URL 规则表集中在一个地方声明（类似 Django 的 urls.py），
/// 而不是到处手写跳转。initialLocation 即首页。
final GoRouter appRouter = GoRouter(
  initialLocation: '/tasks',
  routes: $appRoutes,
);

/// 带底部导航的外壳路由：两个 tab 各自维护导航栈，
/// 切换 tab 不会丢失各自状态（类比 Python Web 框架里多个独立的子应用挂载在同一前缀下）。
///
/// StatefulShellRoute.indexedStack 用 IndexedStack 承载各分支页面。
@TypedStatefulShellRoute<AppShellRouteData>(
  branches: [
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<TasksRouteData>(path: '/tasks')],
    ),
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<SettingsRouteData>(path: '/settings')],
    ),
  ],
)
class AppShellRouteData extends StatefulShellRouteData {
  const AppShellRouteData();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return AppShell(navigationShell: navigationShell);
  }
}

/// 任务列表 tab
class TasksRouteData extends GoRouteData with $TasksRouteData {
  const TasksRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TodoScreen();
  }
}

/// 设置 tab
class SettingsRouteData extends GoRouteData with $SettingsRouteData {
  const SettingsRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsScreen();
  }
}

/// 任务详情页：路径参数 :id（类比 Flask 的路径参数 /{id})，
/// 在 shell 之外声明，进入时是全屏页并覆盖底部导航。
@TypedGoRoute<TaskRouteData>(path: '/task/:id')
class TaskRouteData extends GoRouteData with $TaskRouteData {
  const TaskRouteData({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TaskDetailScreen(todoId: id);
  }
}

/// 底部导航外壳：两个 tab，选中项对应当前分支。
class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          // goBranch 切换分支；首次进入时创建该分支的栈
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: '任务',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: '设置',
          ),
        ],
      ),
    );
  }
}
