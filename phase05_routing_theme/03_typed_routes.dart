// phase05_routing_theme/03_typed_routes.dart
// 阶段五：路由与主题 — Typed Routes（编译期类型安全）
// 本文件为参考代码，不是可运行的 Flutter 项目
// 用 go_router_builder 代码生成，把字符串路径变成强类型路由类

/*
=== 为什么需要 typed routes ===

// 前面两节跳转全靠手拼字符串：
//   context.push('/task/${todo.id}');
// 字符串路径写错了编译器完全不知道，只有运行期才炸——
// 类比 Python：就像 dict 的 key 拼写错误
//   config['dubug'] = True   # 不报错，但读 config['debug'] 时是 None
// typed routes 的思路：让编译器替你检查路径和参数，写错在写代码那一刻就报错

=== 三步写法 ===

// 第 1 步：路由类继承 GoRouteData，实现 build() 方法
// 每个路由就是一个类，路径参数是这个类的字段（强类型！）
import 'package:go_router/go_router.dart';

// 列表页：无参数
class TaskListRoute extends GoRouteData {
  const TaskListRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TaskListPage();
  }
}

// 详情页：id 是 int 字段，不再是字符串字典里的 'id'
class TaskDetailRoute extends GoRouteData {
  const TaskDetailRoute({required this.id});

  final int id;   // 编译期就知道类型，忘了传或传错类型直接编译失败

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TaskDetailPage(taskId: id);
  }
}

// 第 2 步：用 @TypedGoRoute 注解声明路由表，声明 part 文件
// 文件顶部必须有这一行（'xxx' 换成当前文件名），生成的代码会写进这个 part 文件：
part 'routes.g.dart';

// 注解里写：路径 + 对应的路由类；:id 对应类里的 int id 字段
@TypedGoRoute<TaskListRoute>(path: '/tasks')
@TypedGoRoute<TaskDetailRoute>(path: '/task/:id')
// 可以叠加多个注解注册多条路由

// 第 3 步：运行代码生成，生成 routes.g.dart（里面是路由表和 $ 辅助类）
// 在终端执行：
//   dart run build_runner build --delete-conflicting-outputs
// --delete-conflicting-outputs 允许覆盖旧的生成文件，重跑生成时不会报错
// 类比 Python：类似 SQLAlchemy / dataclasses 的代码生成，
// 或者 Django 里 makemigrations 生成迁移文件——先声明，再生成

=== 生成后怎么用 ===

// 生成代码里会出现一个 $appRouter（名字取决于你的写法），传给 MaterialApp.router：
//   MaterialApp.router(routerConfig: $appRouter)

// 跳转：构造路由对象，调 .push(context) 或 .go(context)
// 不再拼字符串，参数是构造函数的命名参数，类型不对编译器立刻拦住
TaskDetailRoute(id: todo.id).push(context);

// 返回上一页
context.pop();

// 带查询参数的路由类同理，把查询参数也声明成字段即可：
// class TaskListRoute extends GoRouteData {
//   const TaskListRoute({this.tab = 'all'});
//   final String tab;   // 对应 /tasks?tab=done
//   ...
// }

=== $extra：传整个对象（概念简述）===

// 有些场景想直接把一个对象（比如一个 Todo 实例）传给下一个页面，
// 而不是只传一个 id 让它自己去查。$extra 就是为这个准备的：
//
//   TaskDetailRoute($extra: todo).push(context);
//
// 注意：
// - $extra 只存在于内存里，不会出现在 URL 中，所以不支持深链接/浏览器刷新恢复
// - 一般推荐优先传 id，下一个页面自己取数据；$extra 适合复杂对象且不需要 URL 可分享的场景

=== 小结 ===

// - 问题：字符串路径和参数 key 拼错只有运行期才暴露（Python dict key 拼错同理）
// - 方案：GoRouteData 子类 + @TypedGoRoute 注解 + build_runner 代码生成
// - 跳转：TaskDetailRoute(id: todo.id).push(context)，类型错误编译期拦截
// - $extra 可传整个对象，但不进 URL，慎用
*/
