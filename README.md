# Flutter 从零开始 — 教程代码

本目录包含一套完整的 Flutter 入门教程代码，适合有 Python 基础的开发者。

## 课程结构

| 阶段 | 目录 | 内容 | 收尾项目 |
|------|------|------|----------|
| 一 | `phase01_dart_basics/` | Dart 语法速成 | `hello_flutter/` |
| 二 | `phase02_widget_examples/` | Widget + 布局 + 导航 | `business_card/` |
| 三 | `weather_app/` | 状态管理 + 网络请求 | `weather_app/` |
| 四 | `todo_app/` | 持久化 + 动画 + Provider | `todo_app/` |

## 前置准备

### 编辑器选择

**推荐方案：VS Code 写代码 + Android Studio 管模拟器（不用它写代码）**

VS Code 和 Android Studio 在 Flutter 开发的核心体验上完全一致——都支持热重载、调试、代码提示。区别在于：

| | VS Code | Android Studio |
|---|---|---|
| 启动速度 | 轻量、快 | 重、慢 |
| Flutter 支持 | Dart + Flutter 官方插件 | 内置 |
| 模拟器管理 | 命令行 或 借用 AVD 管理器 | 内置 GUI |
| Android SDK | 需单独安装 | 自带 |

下面的步骤以 **Windows + VS Code** 为例。

### 1. 安装 Flutter SDK

1. 下载 Flutter SDK：https://docs.flutter.dev/get-started/install/windows
2. 解压到 `C:\flutter\`（或其他不含空格的路径，**不要放 Program Files**）
3. 将 `C:\flutter\bin` 添加到系统环境变量 `PATH`
4. 打开终端，运行 `flutter doctor` 验证

### 2. 安装 Android 工具链

**方式 A：安装 Android Studio（推荐，为了 SDK 和模拟器）**

1. 下载 Android Studio：https://developer.android.com/studio
2. 安装时勾选 Android SDK、Android SDK Platform-Tools、Android Emulator
3. 打开 Android Studio → More Actions → SDK Manager → SDK Tools 标签，确保安装了 **Android SDK Command-line Tools**
4. 打开 Android Studio → More Actions → Virtual Device Manager → 创建一个模拟器（推荐 Pixel 6 + Android 13+）

**方式 B：仅安装命令行工具**

1. 下载 Android SDK Command-line Tools：https://developer.android.com/studio#command-line-tools
2. 解压到 `C:\Android\cmdline-tools\`
3. 添加环境变量 `ANDROID_HOME=C:\Android`
4. 用 `sdkmanager` 安装必要组件：
```bash
sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0" "emulator" "system-images;android-33;google_apis;x86_64"
avdmanager create avd -n pixel6 -k "system-images;android-33;google_apis;x86_64"
```

### 3. 配置 VS Code

1. 安装 VS Code：https://code.visualstudio.com/
2. 在扩展商店搜索安装 **Flutter** 插件（会自动安装 Dart 插件）
3. 打开命令面板（`Ctrl+Shift+P`）→ 输入 `Flutter: New Project` 验证插件是否正常工作

### 4. 验证环境

```bash
flutter doctor
```

成功的输出应类似：

```
[√] Flutter (Channel stable, 3.x, ...)
[√] Windows Version
[√] Android toolchain - develop for Android devices
[√] Chrome - develop for the web
[√] Visual Studio - develop Windows apps
[√] Android Studio (version ...)
[√] VS Code (version ...)
[√] Connected device (1 available)
```

### 5. 启动教程项目

```bash
# 克隆教程仓库
git clone https://github.com/Rheron1848/FlutterTutorial.git
cd FlutterTutorial

# 用 VS Code 打开
code .

# 进入第一个项目，安装依赖并运行
cd hello_flutter
flutter pub get
flutter run
```

> `flutter run` 会列出可用设备（模拟器 / 真机 / Chrome），按数字选择即可。真机调试需要开启 USB 调试模式。

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
