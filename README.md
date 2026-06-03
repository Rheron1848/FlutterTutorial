# Flutter 从零开始 — 教程代码

本目录包含一套完整的 Flutter 入门教程代码，适合有 Python 基础的开发者。

## 课程结构

| 阶段 | 目录 | 内容 | 收尾项目 |
|------|------|------|----------|
| 一 | `phase01_dart_basics/` | Dart 语法速成 | `hello_flutter/` |
| 二 | `phase02_widget_examples/` | Widget + 布局 + 导航 | `business_card/` |
| 三 | `phase03_advanced_examples/` | 状态管理 + 网络请求 | `weather_app/` |
| 四 | `phase04_advanced_examples/` | 持久化 + 动画 + Provider | `todo_app/` |

## 前置准备

1. 安装 Flutter SDK：https://docs.flutter.dev/get-started/install
2. 安装 Android Studio 和 Android SDK
3. 运行 `flutter doctor` 确认环境就绪

## 运行方式

### Dart 示例（阶段一基础语法）
```bash
cd phase01_dart_basics
dart run 01_variables_and_types.dart
```

### Flutter 项目
```bash
cd hello_flutter    # 或其他 Flutter 项目目录
flutter pub get     # 安装依赖
flutter run         # 启动应用
```

## 学习路线

1. 先阅读 `phase01_dart_basics/` 中的 Dart 示例，理解基本语法
2. 运行 `hello_flutter/` 体验第一个 Flutter 应用
3. 阅读 `phase02_widget_examples/` 了解常用 Widget
4. 研究 `business_card/` 理解多页面导航
5. 进入 `weather_app/` 学习状态管理和网络请求
6. 最后完成 `todo_app/` 综合运用所有技能
