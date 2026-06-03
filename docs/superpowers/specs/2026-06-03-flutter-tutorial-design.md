# Flutter 从零开始教程设计

## 用户画像

- **编程基础**：Python 熟练，有面向对象功底，有一点 UI 经验（tkinter/PyQt 或简单前端）
- **学习目标**：构建个人项目 + 深入理解 Flutter 原理（兼顾实践与理论）
- **时间投入**：每周 5-10 小时
- **开发环境**：Windows + Android 真机 + iPhone（iOS 构建需 macOS，学习阶段以 Android 为主）

## 整体架构

采用**混合式教学**：四阶段 × 10 周，每个阶段以一个小项目收尾，理论与实践交替推进。

```
阶段一（2周）        阶段二（3周）         阶段三（3周）        阶段四（2周）
┌──────────────┐   ┌──────────────┐    ┌──────────────┐    ┌──────────────┐
│ 环境 + Dart  │ → │ 核心 Widget  │ →  │ 状态 + 网络  │ →  │ 进阶 + 综合  │
│ 第一个页面   │   │ 布局 + 导航  │    │ 天气 App     │    │ 待办事项 App │
└──────────────┘   └──────────────┘    └──────────────┘    └──────────────┘
   收尾：Hello       收尾：名片App        收尾：天气App        收尾：Todo App
```

### 教学原则

- 每个知识点标注 Python 类比，降低学习曲线
- 每个阶段包含：理论学习 → 代码练习 → 小项目收尾
- 所有代码存放在本项目目录下，按阶段分目录

---

## 阶段一：环境搭建 + Dart 速成 + 第一个 Flutter 页面（2周）

### 第 1 周：环境与 Dart 基础

| 主题 | 内容 | Python 类比 |
|------|------|-------------|
| 环境搭建 | 安装 Flutter SDK、Android Studio、配置 Android 模拟器、`flutter doctor` 验证 | 类似 pip install + 虚拟环境 |
| Dart 变量与类型 | `var`/`final`/`const`、基本类型、空安全 `?` | `var` ≈ Python 变量；`final` ≈ 约定常量 |
| 函数 | 声明、箭头函数、命名参数 `{}`、可选参数 `[]`、默认值 | 比 Python 多了类型标注和命名参数 |
| 控制流 | `if/else`、`for`、`while`、`switch` | 几乎一样，需要加分号和花括号 |
| 集合 | `List`、`Set`、`Map`、`map`/`where`/`forEach` | `List`=list、`Map`=dict |

**产出**：环境跑通，能在命令行运行 Dart 程序。

### 第 2 周：Dart OOP + 第一个页面

| 主题 | 内容 |
|------|------|
| 类与对象 | 构造函数、命名构造函数、`this`/`super`、继承 `extends`、Mixin `with` |
| 异步编程 | `Future`、`async/await`、`try/catch`（与 Python 异步几乎一致） |
| 第一个 Flutter 项目 | `MaterialApp` → `Scaffold` → `AppBar` + `body` + `Text` |
| 热重载 | 修改代码 → 保存 → 即时更新 |

**产出**：一个带标题栏和自定义文字的 Flutter 页面，理解项目文件结构。

---

## 阶段二：核心 Widget + 布局 + 导航（3周）

### 第 3 周：常用 Widget

| 类型 | Widget | 说明 |
|------|--------|------|
| 展示类 | `Text`、`Image`、`Icon` | 文本样式（fontSize/color/weight）、网络图/本地图/asset 图 |
| 按钮类 | `ElevatedButton`、`TextButton`、`IconButton`、`FloatingActionButton` | 各类按钮及 onPressed 回调 |
| 容器类 | `Container`、`Padding`、`Center`、`SizedBox` | padding/margin/decoration/width/height |
| 布局类 | `Row`、`Column`、`Expanded`、`Flexible` | 弹性布局核心四件套，mainAxisAlignment/crossAxisAlignment |
| 列表类 | `ListView`（builder 模式）、`GridView` | 长列表性能优化、网格布局 |

### 第 4 周：导航与路由

| 主题 | 内容 |
|------|------|
| 页面跳转 | `Navigator.push`/`pop`、传参与回传 |
| 命名路由 | `routes` 表、`pushNamed`、`onGenerateRoute` |
| 底部导航 | `BottomNavigationBar` + `IndexedStack` 保持页面状态 |
| 抽屉菜单 | `Drawer` + `DrawerHeader` |

### 第 5 周：名片 App（收尾项目）

功能：
- **首页**：头像、姓名、职位、简介
- **技能页**：`ListView` 展示技能标签列表
- **联系页**：邮箱、电话、社交媒体链接
- `BottomNavigationBar` 三页切换

**产出**：完整的多页面应用。

---

## 阶段三：状态管理 + 网络请求（3周）

### 第 6 周：状态管理与表单

| 主题 | 内容 |
|------|------|
| StatefulWidget | 与 StatelessWidget 的区别、`setState()`、生命周期 |
| 表单输入 | `TextField`、`TextEditingController`、焦点管理 |
| 表单验证 | `Form` + `TextFormField` + `GlobalKey<FormState>` + validator |
| 选择控件 | `Checkbox`、`Switch`、`Radio` |

### 第 7 周：网络请求

| 主题 | 内容 |
|------|------|
| http 包 | 添加依赖（`pubspec.yaml`）、GET/POST 请求 |
| JSON 处理 | `dart:convert`、`jsonDecode`/`jsonEncode`、fromJson/toJson |
| 异步 UI | `FutureBuilder`（loading/data/error 三态处理） |
| 下拉刷新 | `RefreshIndicator` + `onRefresh` |

### 第 8 周：天气查询 App（收尾项目）

功能：
- 搜索城市名 → 调用免费天气 API → 展示结果
- 加载中动画、错误提示（网络异常/城市不存在）、下拉刷新
- 温度大字 + 天气图标 + 湿度/风速详情卡片

**产出**：第一个网络数据驱动型应用。

---

## 阶段四：进阶 + 综合项目（2周）

### 第 9 周：本地存储 + 动画 + 状态管理进阶

| 主题 | 内容 |
|------|------|
| SharedPreferences | 轻量键值存储，读写 String/int/bool |
| 隐式动画 | `AnimatedContainer`、`AnimatedOpacity` |
| Hero 动画 | 页面间共享元素过渡 |
| Provider | `ChangeNotifier` + `ChangeNotifierProvider` + `context.watch<T>()` |

### 第 10 周：待办事项 App（综合项目）

功能：
- 新增任务、标记完成、删除（滑动删除）、编辑
- 筛选：全部 / 未完成 / 已完成
- Provider 管理状态 + SharedPreferences 持久化 + 动画反馈
- UI：顶部输入框 + 任务列表 + 底部筛选栏

**产出**：完整的数据驱动型 CRUD 应用。

---

## 课程总结

| 阶段 | 时长 | 核心技能 | 收尾项目 |
|------|------|----------|----------|
| 一 | 2周 | Dart 语法 + Flutter 项目结构 | Hello World |
| 二 | 3周 | Widget 布局系统 + 多页面导航 | 个人名片 App |
| 三 | 3周 | 状态管理 + 表单 + 网络请求 | 天气查询 App |
| 四 | 2周 | 持久化 + 动画 + Provider 状态管理 | 待办事项 App |

## 边界说明

- **包含**：Dart 基础、Flutter 核心 Widget、导航路由、表单、网络请求、本地存储、基础动画、Provider 状态管理
- **不包含**（留给后续进阶学习）：Riverpod/BLoC 状态管理、自定义绘制（CustomPainter）、原生平台通信（MethodChannel）、Firebase 集成、发布打包、测试
