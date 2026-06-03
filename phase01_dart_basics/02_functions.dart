// 02_functions.dart
// Dart 函数 — Python 对比学习
// Python: def greet(name): return f"Hello, {name}"
// Dart:   String greet(String name) => 'Hello, $name';

void main() {
  // === 1. 基本函数定义 ===
  print(greet('World')); // Hello, World
  print(add(3, 5)); // 8
  print(isEven(4)); // true

  // === 2. 命名参数（Named Parameters）===
  // Dart 独有特性！Python 需要 **kwargs
  print(describe(name: 'Alice', age: 25));
  // 可以任意顺序传入
  print(describe(age: 30, name: 'Bob'));

  // === 3. 可选位置参数 ===
  print(greetWithTitle('Charlie')); // Hello, Charlie
  print(greetWithTitle('Diana', 'Dr.')); // Hello, Dr. Diana

  // === 4. 默认参数值 ===
  print(createBox(width: 100)); // Box: 100x50x50
  print(createBox(width: 100, height: 200, depth: 300)); // Box: 100x200x300

  // === 5. 箭头函数（单表达式简写）===
  // Python: lambda x: x * 2
  // Dart:   (x) => x * 2
  var numbers = [1, 2, 3, 4, 5];
  var doubled = numbers.map((n) => n * 2); // 类似 Python 的 map
  print('doubled: ${doubled.toList()}');

  // === 6. 匿名函数 ===
  // Python: lambda x: x > 3
  var filtered = numbers.where((n) => n > 3);
  print('filtered: ${filtered.toList()}');

  // === 7. 函数作为一等公民 ===
  int Function(int, int) operation = add; // 函数类型标注
  print('function variable: ${operation(10, 20)}'); // 30
}

// --- 函数定义区 ---

// 基本函数
String greet(String name) {
  return 'Hello, $name';
}

// 箭头函数（单表达式）
int add(int a, int b) => a + b;
bool isEven(int n) => n % 2 == 0;

// 命名参数：用 {} 包裹，required 表示必填
String describe({required String name, required int age}) {
  return '$name is $age years old.';
}

// 可选位置参数：用 [] 包裹
String greetWithTitle(String name, [String title = '']) {
  if (title.isEmpty) return 'Hello, $name';
  return 'Hello, $title $name';
}

// 默认参数值
String createBox({required int width, int height = 50, int depth = 50}) {
  return 'Box: ${width}x${height}x$depth';
}
