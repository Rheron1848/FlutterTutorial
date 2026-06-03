// hello_flutter/lib/main.dart
// 你的第一个 Flutter 应用！
// 运行方式：cd hello_flutter && flutter run

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MaterialApp — 整个应用的根 Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hello Flutter',
      // 主题配置
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const HomePage(),
    );
  }
}

// Scaffold — 页面的骨架结构
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的第一个 Flutter 应用'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon 图标
            Icon(
              Icons.flutter_dash,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 24),
            // Text 文字
            Text(
              'Hello, Flutter!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '这是你的第一个 Flutter 页面',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      // FloatingActionButton 浮动按钮
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 显示 SnackBar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('你点击了按钮！'),
              duration: Duration(seconds: 1),
            ),
          );
        },
        child: const Icon(Icons.touch_app),
      ),
    );
  }
}
