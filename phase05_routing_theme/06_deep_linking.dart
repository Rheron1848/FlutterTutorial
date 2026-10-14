// phase05_routing_theme/06_deep_linking.dart
// 阶段五:路由与主题 — 深链(Deep Linking)概念与配置
// 本文件为参考代码,不是可运行的 Flutter 项目,全部示例在下方注释块中

/*
=== 什么是深链 ===

// 深链:从浏览器地址、短信、邮件或另一个 App 里的链接,
// 直接打开应用内的某个具体页面,而不是只停在首页。
//
// 例如:点击链接 fluttertodo://task/1
//   → 系统唤起 Todo App
//   → 直接定位到 id 为 1 的任务详情页
//
// Python 类比:相当于给函数调用直接附上完整参数,
// 跳过默认入口,直达对应分支。

=== Android 配置:AndroidManifest.xml ===

// 在 MainActivity 上注册 intent-filter,声明本应用响应哪种链接。
// 文件位置:android/app/src/main/AndroidManifest.xml

// <activity
//     android:name=".MainActivity"
//     android:exported="true"
//     ...>
//     <intent-filter>
//         <action android:name="android.intent.action.VIEW" />
//         <category android:name="android.intent.category.DEFAULT" />
//         <category android:name="android.intent.category.BROWSABLE" />
//         <!-- 自定义 scheme + host,匹配 fluttertodo://task/1 这类链接 -->
//         <data android:scheme="fluttertodo" android:host="task" />
//     </intent-filter>
// </activity>

// 说明:
//   action VIEW     — 声明这是一个"查看"动作
//   category DEFAULT    — 允许应用内通过隐式 intent 启动
//   category BROWSABLE  — 允许浏览器里的链接触发
//   data scheme     — 自定义协议头(如 fluttertodo),也可配 https

=== iOS 配置:Info.plist 简述 ===

// 文件位置:ios/Runner/Info.plist,声明 URL Scheme 即可:

// <key>CFBundleURLTypes</key>
// <array>
//     <dict>
//         <key>CFBundleURLName</key>
//         <string>com.example.todo</string>
//         <key>CFBundleURLSchemes</key>
//         <array>
//             <string>fluttertodo</string>
//         </array>
//     </dict>
// </array>

=== 冷启动与热启动 ===

// 冷启动(cold start):应用未在运行,系统拉起新进程并打开链接目标页。
//   这时初始路由由链接决定,而不是应用的默认首页。
// 热启动(warm start):应用已在后台,系统把链接路由派发给现有进程。
//
// go_router 两种情况都自动处理:
//   冷启动时它从平台拿到链接作为 initial location;
//   热启动时通过 stream 收到新链接并导航到对应路由。

=== go_router 自动处理初始路由 ===

// 不需要手写解析平台链接的代码,go_router 会自动完成:

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(
      // 路径参数自动从链接中解析: fluttertodo://task/1 → id == '1'
      path: '/task/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!; // '1'
        return TaskDetailPage(taskId: int.parse(id));
      },
    ),
  ],
);

// MaterialApp.router(routerConfig: router) 之后:
//   点击 fluttertodo://task/1
//   → 冷启动:直接以 /task/1 作为初始路由打开
//   → 热启动:收到链接后导航到 /task/1

=== 本机测试命令 ===

// 模拟器/真机连着电脑时,用 adb 直接发一个 VIEW intent 测试深链:

// adb shell am start -a android.intent.action.VIEW \
//     -d "fluttertodo://task/1"

// 应用应从后台/未启动状态直接跳到任务 1 的详情页。
// Windows 上一行写法(去掉反斜杠续行):
// adb shell am start -a android.intent.action.VIEW -d "fluttertodo://task/1"
*/

void main() {
  print('Deep Linking 参考代码 — 请阅读上方注释块');
  print('运行方式: dart run phase05_routing_theme/06_deep_linking.dart');
}
