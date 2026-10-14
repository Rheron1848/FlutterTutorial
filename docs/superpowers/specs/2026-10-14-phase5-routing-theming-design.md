# 阶段五设计：路由与主题

## 背景

教程前四阶段已完成（Dart 基础 → Widget/导航 → 状态/网络 → 持久化/动画/Provider）。
本阶段进入进阶主题：**声明式路由（go_router）** 与 **应用主题（深浅色模式、主题定制）**,
收尾时把 `todo_app` 从单页应用改造为带底部导航、任务详情页、深浅色切换、深链支持的多页面应用。

用户画像沿用总设计：Python 熟练、每周 5-10 小时、Windows + Android。
教学原则不变：每个知识点标注 Python 类比，理论参考示例 → 综合项目练习。

## 内容大纲

### 理论参考示例 `phase05_routing_theme/`

延续 phase01/02 的风格：带中文注释、Python 类比的参考代码文件（不是独立可运行项目）。
`03_typed_routes.dart` 的代码生成流程在 todo_app 改造中实际演示，本文件讲概念与写法。

| 文件 | 内容 |
|------|------|
| `01_go_router_basics.dart` | 命令式 Navigator vs 声明式路由、`GoRouter` 配置、`context.go`/`push`、404 页 |
| `02_routing_advanced.dart` | 路径传参 `:id`、查询参数、`redirect` 重定向、路由守卫（登录判断） |
| `03_typed_routes.dart` | `go_router_builder` + build_runner 代码生成、编译期类型安全 |
| `04_shell_route.dart` | `StatefulShellRoute` 嵌套导航 + 底部导航保持各 tab 状态 |
| `05_theming.dart` | `ThemeData`、`ColorScheme.fromSeed`、`ThemeMode` 三态、深色模式、`TextTheme`、`ThemeExtension` |
| `06_deep_linking.dart` | Android intent-filter 配置、自定义 scheme、从外部链接直达应用内页面 |

### todo_app 改造（综合练习）

**依赖新增**:`go_router`、`go_router_builder`(dev)、`build_runner`(dev)。
版本用 `flutter pub add` 解析，不手写版本号。

**路由层**（新增 `lib/router.dart`):
- 全部页面用 typed routes 定义（`part 'router.g.dart'` + `@TypedGoRoute`),`build_runner` 生成 `router.g.dart`
- 路由结构：
  - `StatefulShellRoute` → 底部导航两个 tab:`/tasks`（任务列表）、`/settings`（设置）
  - `/task/:id` 任务详情页，从列表点击任务进入，演示路径传参
- 初始位置 `/tasks`

**主题层**:
- 新增 `lib/theme.dart`:`ColorScheme.fromSeed` 生成浅色/深色两套 `ThemeData`
- `ThemeExtension` 定义任务优先级颜色（高/中/低），列表和详情页都使用
- 新增 `lib/providers/theme_provider.dart`:`ChangeNotifier` 管理 `ThemeMode`（浅色/深色/跟随系统），读写 `SharedPreferences` 持久化（复习阶段四）

**页面结构**:
- `TodoScreen` 改造成列表项可点击 → `context.push` 到 `/task/:id`
- 新增 `SettingsScreen`：主题模式三选（Radio/SegmentedButton)、关于信息
- 新增 `TaskDetailScreen`：按 id 从 `TodoProvider` 查任务，展示标题、完成状态、优先级（用 ThemeExtension 颜色）、创建时间等
- `main.dart` 改为 `MultiProvider`(ThemeProvider + TodoProvider)+ `MaterialApp.router`

**深链**:
- `android/app/src/main/AndroidManifest.xml` 给 MainActivity 加 intent-filter,scheme 为 `fluttertodo`
- 外部链接 `fluttertodo://task/1` 可直达任务详情（应用冷启动/热启动均处理）

### 测试

- 现有 `test/widget_test.dart` 冒烟测试适配新入口（`MaterialApp.router` + MultiProvider + ThemeProvider mock)
- 新增用例：
  - 主题切换：设置页切换深色模式 → 断言 `MaterialApp.themeMode` 变化
  - 路由：任务列表点击进入详情页 → 断言详情页标题出现

### 验收标准

- `todo_app`: `flutter analyze` 零告警，`flutter test` 全部通过
- `phase05_routing_theme/`:`dart analyze` 零告警
- README 更新：课程结构表加阶段五行，学习路线加第 7 步
- 设计文档提交 git；实施完成后提交并推送全部代码

## 边界说明

- **包含**:go_router 声明式路由、typed routes、ShellRoute、ThemeData/ThemeMode/ColorScheme、ThemeExtension、Android 深链（自定义 scheme)
- **不包含**:Web 深链、iOS universal links（需 macOS)、Riverpod/BLoC、发布打包（留给后续阶段）
