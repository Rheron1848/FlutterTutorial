// phase05_routing_theme/02_routing_advanced.dart
// 阶段五：路由与主题 — 路由进阶
// 本文件为参考代码，不是可运行的 Flutter 项目
// 路径参数、查询参数、redirect 重定向与路由守卫

/*
=== 路径参数（path parameters）===

// 在路由表里用 :id 声明占位符：
GoRoute(
  path: '/task/:id',      // :id 会匹配 URL 里这一段的内容
  builder: (context, state) {
    // 通过 state.pathParameters 按名字取，类型是 Map<String, String>
    // 类比 Python：Flask 的 @app.route('/task/<int:id>')，
    // state.pathParameters['id'] ≈ request.view_args['id']（但都是字符串，要自己做类型转换）
    final id = int.parse(state.pathParameters['id']!);
    return TaskDetailPage(taskId: id);
  },
)

// 多级参数同理：
// path: '/user/:uid/task/:tid'
// state.pathParameters['uid'], state.pathParameters['tid']

// 补充：使用 typed routes（见 03 文件）后，参数变成路由对象的强类型字段，
// 不再需要手写字符串 key，也不需要自己 parse

=== 查询参数（query parameters）===

// URL 中 ? 后面的键值对：'/tasks?tab=done&page=2'
// 类比 Python：Flask 的 request.args.get('tab')
GoRoute(
  path: '/tasks',
  builder: (context, state) {
    // state.uri 是 Uri 对象，queryParameters 是 Map<String, String>
    // 不存在的 key 返回 null，所以用 ?? 给默认值
    final tab = state.uri.queryParameters['tab'] ?? 'all';
    final page = int.tryParse(state.uri.queryParameters['page'] ?? '1') ?? 1;
    return TaskListPage(initialTab: tab, initialPage: page);
  },
)

=== redirect 重定向 ===

// GoRouter 级别的 redirect：每次导航前都会调用
// 返回一个路径字符串 = 跳到那个路径；返回 null = 放行，正常导航
// 类比 Python：Flask 的 @before_request 钩子里
//   if not logged_in and request.path.startswith('/admin'):
//       return redirect('/login')
//   return None  # 返回 None 表示放行

final router = GoRouter(
  initialLocation: '/',
  routes: [ /* ...省略路由表... */ ],

  redirect: (context, state) {
    final loggedIn = authService.isLoggedIn;   // 你的登录状态
    final goingToLogin = state.matchedLocation == '/login';

    // 未登录且目标不是登录页 -> 重定向到 /login
    if (!loggedIn && !goingToLogin) {
      return '/login';
    }
    // 已登录却访问登录页 -> 送回首页（登录后别再停在登录页）
    if (loggedIn && goingToLogin) {
      return '/';
    }
    // 返回 null = 不干预，放行这次导航（最关键的一行，别漏）
    return null;
  },
);

=== 路由守卫（route guard）概念 ===

// "路由守卫"不是一个单独的 API，就是 redirect 的一种用法模式：
// 导航发生前检查条件（登录态、权限），不满足就改道
//
// 常见套路：
// 1. 全局守卫：GoRouter.redirect（上面那个例子），所有路由统一检查
// 2. 单路由守卫：某个 GoRoute 自己的 redirect 字段，只在这个路由被访问时触发
//
// GoRoute(
//   path: '/admin',
//   redirect: (context, state) =>
//       user.isAdmin ? null : '/forbidden',  // 返回 null 放行，否则去无权限页
//   builder: (context, state) => AdminPage(),
// )

=== 小结 ===

// - 路径参数：path: '/task/:id'，state.pathParameters['id'] 读取（字符串，需自行转换）
// - 查询参数：?tab=done，state.uri.queryParameters 读取（带默认值更稳）
// - redirect：返回路径 = 重定向，返回 null = 放行；这是实现路由守卫的核心机制
// - 守卫写在全局（GoRouter.redirect）或单路由（GoRoute.redirect），按需选择
*/
