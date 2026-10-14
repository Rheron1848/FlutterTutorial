// phase05_routing_theme/04_shell_route.dart
// 阶段五:路由与主题 — ShellRoute 与 StatefulShellRoute(底部导航保持状态)
// 本文件为参考代码,不是可运行的 Flutter 项目,全部示例在下方注释块中

/*
=== ShellRoute 与 StatefulShellRoute 的区别 ===

// ShellRoute:包裹多个子路由,提供一个外壳(如底部导航栏)。
// 问题:切换到另一个 tab 再切回来时,之前的 tab 页面会被销毁重建,
// 滚动位置、表单输入等状态全部丢失。
//
// Python 类比:
//   普通 ShellRoute ≈ 每次调用都重新执行函数,局部变量全部重置
//   StatefulShellRoute ≈ 缓存了每个 tab 的实例,切换只是隐藏/显示
//
// StatefulShellRoute:为每个 branch(分支)维护一个独立的 Navigator,
// 切换 tab 时用 IndexedStack 缓存所有分支,状态不丢失。

=== 用 StatefulShellRoute.indexedStack 实现底部导航 ===

// 路由定义:每个 branch 是一组子路由
final router = GoRouter(
  initialLocation: '/home',
  routes: [
    // StatefulShellRoute.indexedStack:内置用 IndexedStack 缓存各分支
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        // navigationShell 是当前外壳,负责在 branches 之间切换
        return Scaffold(
          body: navigationShell, // IndexedStack,自动显示当前 branch
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navigationShell.currentIndex,
            onTap: (index) => navigationShell.goBranch(index),
            // goBranch 切到指定分支;默认只切不换栈,
            // 传 initialLocation: true 会重置该分支栈
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: '搜索'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
            ],
          ),
        );
      },
      branches: [
        // 每个 branch 是一个独立的子导航栈
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) => const HomePage(),
              routes: [
                // 分支内的二级页面
                GoRoute(
                  path: 'detail',
                  builder: (context, state) => const HomeDetailPage(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) => const SearchPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
  ],
);

// 页面内部跳转(同分支内 push):
// context.go('/home/detail');          // 或
// context.push('/home/detail');

=== typed routes 下的写法 ===

// 配合 go_router_builder 代码生成,用注解声明,不再需要手写字符串路径:
//
// @TypedStatefulShellRoute<MyShellRoute>(
//   branches: [
//     TypedStatefulShellBranch<MyHomeBranch>(
//       routes: [TypedGoRoute<HomeRoute>(path: '/home')],
//     ),
//     TypedStatefulShellBranch<MySearchBranch>(
//       routes: [TypedGoRoute<SearchRoute>(path: '/search')],
//     ),
//     TypedStatefulShellBranch<MyProfileBranch>(
//       routes: [TypedGoRoute<ProfileRoute>(path: '/profile')],
//     ),
//   ],
// )
// class MyShellRoute extends StatefulShellRouteData {
//   const MyShellRoute();
//
//   @override
//   Widget builder(BuildContext context, GoRouterState state,
//       StatefulNavigationShell navigationShell) {
//     return Scaffold(
//       body: navigationShell,
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: navigationShell.currentIndex,
//         onTap: (index) => navigationShell.goBranch(index),
//         items: const [...],
//       ),
//     );
//   }
// }
//
// 之后跳转变成类型安全的写法:HomeRoute().go(context)
//
// 选型小结:
//   需要底部/侧边导航 + 保留各 tab 状态 → StatefulShellRoute
//   只是共享一个外壳(如统一的 AppBar),不需要保状态 → 普通 ShellRoute
*/

void main() {
  print('ShellRoute 参考代码 — 请阅读上方注释块');
  print('运行方式: dart run phase05_routing_theme/04_shell_route.dart');
}
