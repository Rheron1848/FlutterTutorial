// 06_async.dart
// Dart 异步编程 — 与 Python 的 async/await 几乎一样
// Python: async def fetch():   await asyncio.sleep(1)
// Dart:   Future<void> fetch() async { await Future.delayed(...); }

import 'dart:async';

void main() async {
  print('=== 异步编程示例 ===\n');

  // === 1. Future（类似 Python 的 coroutine/Task）===
  print('1. 基本 Future');
  var result = await fetchData();
  print('结果: $result\n');

  // === 2. 链式调用 ===
  print('2. 链式调用');
  fetchData()
      .then((data) => '处理: $data')
      .then((processed) => print('$processed\n'));

  // === 3. 错误处理 ===
  print('3. 错误处理');
  try {
    await riskyOperation();
  } catch (e) {
    print('捕获错误: $e');
  } finally {
    print('清理工作完成\n');
  }

  // === 4. 并发执行（类似 Python 的 asyncio.gather）===
  print('4. 并发执行');
  var results = await Future.wait([
    delayedResult('任务A', 1),
    delayedResult('任务B', 2),
    delayedResult('任务C', 1),
  ]);
  print('所有任务完成: $results\n');

  // === 5. Stream（类似 Python 的 async generator）===
  print('5. Stream 流式数据');
  await for (var value in countStream(5)) {
    print('stream: $value');
  }
}

// 模拟异步获取数据
Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 1)); // 模拟网络请求
  return '数据加载完成';
}

// 可能出错的操作
Future<void> riskyOperation() async {
  await Future.delayed(Duration(milliseconds: 500));
  throw Exception('网络连接失败！');
}

// 延迟返回结果
Future<String> delayedResult(String name, int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  return '$name 完成';
}

// Stream 生成器
Stream<int> countStream(int max) async* {
  for (var i = 1; i <= max; i++) {
    await Future.delayed(Duration(milliseconds: 500));
    yield i;
  }
}
