// 01_variables_and_types.dart
// Dart 变量与类型 — Python 对比学习
// Python: x = 10  →  Dart: var x = 10; 或 int x = 10;

void main() {
  // === 1. 变量声明 ===
  // Python: x = 10
  var a = 10; // 类型推断为 int
  int b = 20; // 显式类型标注
  print('a = $a, b = $b'); // 字符串插值：$变量名 或 ${表达式}

  // === 2. final vs const ===
  // Python 中通常用全大写约定常量：MAX_SIZE = 100
  final now = DateTime.now(); // final：运行时确定，只能赋值一次
  const pi = 3.14159; // const：编译时确定
  // const now2 = DateTime.now(); // ❌ 编译错误！const 不能是运行时值
  print('final (runtime): $now');
  print('const (compile-time): $pi');

  // === 3. 基本类型 ===
  int age = 25;
  double height = 1.75;
  String name = 'Dart';
  bool isFun = true;

  // === 4. 空安全（Null Safety）===
  // Python: x = None
  String? maybeNull = null; // ? 表示可为 null
  String notNull = 'hello';
  // notNull = null; // ❌ 编译错误！非空类型不能赋 null

  // ?? 运算符：如果为 null 则使用默认值
  String result = maybeNull ?? 'default value';
  print('result: $result'); // default value

  // ?. 安全调用：如果为 null 则跳过
  print('length: ${maybeNull?.length}'); // null（不会崩溃）

  // === 5. 类型转换 ===
  // Python: int("123")  →  Dart: int.parse("123")
  var numStr = '123';
  var num = int.parse(numStr);
  var numDouble = double.parse('3.14');
  print('parsed: $num, $numDouble');

  // toString()
  print('toString: ${num.toString()}');

  // === 6. dynamic 类型 ===
  // 类似 Python 的动态类型
  dynamic anything = 'hello';
  anything = 42; // 可以改变类型
  anything = true;
  print('dynamic: $anything');
}
