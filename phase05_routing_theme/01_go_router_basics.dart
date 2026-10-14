// phase05_routing_theme/01_go_router_basics.dart
// 阶段五：路由与主题 — GoRouter 基础
// 本文件为参考代码，不是可运行的 Flutter 项目
// 对比命令式 Navigator 与声明式 GoRouter

/*
=== 命令式路由：Navigator（手动压栈）===

// Navigator ≈ Python 里手动维护一个页面栈（list），push 就是 append，pop 就是 pop()
// 页面栈由你自己一层层压进去、弹出来，一旦层级深了很难追踪"当前在哪"

// 跳转到新页面（压栈，可以返回）
Navigator.of(context).push(
  MaterialPageRoute(builder: (context) => TaskDetailPage(taskId: 1)),
);

// 返回上一页（弹栈）
Navigator.of(context).pop();

// 问题：
// 1. 深链接（URL 直达某个页面）做不了
// 2. 页面跳转逻辑散落在各处，改了页面名要全文搜索替换
// 3. 没有统一的 404 处理

=== 声明式路由：GoRouter（配置路由表）===

// GoRouter ≈ Flask/Django 的 URL 路由表：
// 在 Flask 里是 @app.route('/task/<int:id>') 集中注册，
// Flutter 里是用 GoRoute 集中声明 path -> 页面 的映射，
// 由路由框架根据当前 URL 自动"渲染"出页面栈

import 'package:go_router/go_router.dart';

final router = GoRouter(
  // 路由表：URL 路径 -> 页面 Widget
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: '/tasks',
      builder: (context, state) => TaskListPage(),
    ),
    GoRoute(
      path: '/task/:id',              // :id 是路径参数
      builder: (context, state) =>
          TaskDetailPage(taskId: state.pathParameters['id']!),
    ),
  ],
  // errorBuilder：匹配不到任何路由时渲染的页面（相当于 Flask 的 404 视图）
  errorBuilder: (context, state) => NotFoundPage(path: state.uri.toString()),
);

=== 接入 MaterialApp ===

// 普通写法（Navigator 时代）
MaterialApp(
  home: HomePage(),
)

// GoRouter 写法：用 .router 工厂方法，传入 router 的配置
MaterialApp.router(
  routerConfig: router,   // 传整个 GoRouter 实例
)

=== 三种跳转方式：go / push / pop ===

// context.go('/task/1')
//   替换当前页（浏览器 URL 变成 /task/1，历史记录里当前页被换掉）
//   类比 Python：redirect('/task/1')，当前请求被"替换"了
//   适用：登录成功后跳首页（不希望用户按"返回"回到登录页）

context.go('/task/1');

// context.push('/task/1')
//   压栈（新页面盖在当前页上面，可以按"返回"回来）
//   类比 Python：在页面栈 list 上 append 一个新页面
//   适用：从列表点进详情页（看完详情要能返回列表）

context.push('/task/1');

// context.pop()
//   弹栈，返回上一页（等价于 Navigator 的 pop）
//   只有 push 进来的页面才适合 pop；go 替换过的页面栈里没有"上一页"可回

context.pop();

=== 小结 ===

// Navigator：命令式，手动管理栈，像 Python 手写 list 的 append/pop
// GoRouter：声明式，集中配置路由表，像 Flask/Django 的 URL 分发
//   - context.go    -> 替换当前页（redirect）
//   - context.push  -> 压栈可返回（栈操作）
//   - context.pop   -> 返回上一页
//   - errorBuilder  -> 自定义 404 页
*/
