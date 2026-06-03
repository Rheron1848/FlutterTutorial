# Flutter 从零开始教程 实现计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 创建一套完整的 Flutter 入门教程，包含 4 个阶段的 Dart 示例代码和 4 个可运行的 Flutter 项目。

**Architecture:** 教程代码按阶段分目录存放。Dart 基础示例为独立 `.dart` 文件（可命令行运行），Flutter 项目使用 `flutter create` 生成脚手架后编写核心 `lib/` 代码。每个阶段包含示例代码 + 完整 App 项目。

**Tech Stack:** Dart 3.x、Flutter 3.x、Material Design 3、http 包、Provider、SharedPreferences

**项目结构：**
```
flutter/
├── docs/superpowers/
│   ├── specs/2026-06-03-flutter-tutorial-design.md
│   └── plans/2026-06-03-flutter-tutorial-plan.md
├── phase01_dart_basics/          # 7 个 Dart 独立示例文件
├── hello_flutter/                # flutter create 项目
│   └── lib/main.dart
├── phase02_widget_examples/      # Widget 布局示例
├── business_card/                # flutter create 项目
│   └── lib/
├── phase03_advanced_examples/    # 状态管理 + 网络示例
├── weather_app/                  # flutter create 项目
│   └── lib/
├── phase04_advanced_examples/    # 存储 + 动画示例
└── todo_app/                     # flutter create 项目
    └── lib/
```

---

### Task 1: 创建项目目录结构

**Files:**
- Create: 所有目录

- [ ] **Step 1: 创建所有目录**

```bash
mkdir -p /home/rheron/文档/projects/flutter/phase01_dart_basics
mkdir -p /home/rheron/文档/projects/flutter/hello_flutter/lib
mkdir -p /home/rheron/文档/projects/flutter/phase02_widget_examples
mkdir -p /home/rheron/文档/projects/flutter/business_card/lib/screens
mkdir -p /home/rheron/文档/projects/flutter/phase03_advanced_examples
mkdir -p /home/rheron/文档/projects/flutter/weather_app/lib/screens
mkdir -p /home/rheron/文档/projects/flutter/phase04_advanced_examples
mkdir -p /home/rheron/文档/projects/flutter/todo_app/lib/{models,screens,providers}
```

- [ ] **Step 2: 验证目录结构**

```bash
find /home/rheron/文档/projects/flutter -type d | sort
```

- [ ] **Step 3: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add .
git commit -m "$(cat <<'EOF'
feat: create tutorial project directory structure
EOF
)"
```

---

### Task 2: 阶段一 — Dart 基础示例：变量与类型

**Files:**
- Create: `phase01_dart_basics/01_variables_and_types.dart`

- [ ] **Step 1: 创建变量与类型示例文件**

```dart
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
```

- [ ] **Step 2: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add phase01_dart_basics/01_variables_and_types.dart
git commit -m "$(cat <<'EOF'
feat: add Dart variables and types tutorial with Python analogies
EOF
)"
```

---

### Task 3: 阶段一 — Dart 函数

**Files:**
- Create: `phase01_dart_basics/02_functions.dart`

- [ ] **Step 1: 创建函数示例文件**

```dart
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
```

- [ ] **Step 2: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add phase01_dart_basics/02_functions.dart
git commit -m "feat: add Dart functions tutorial with Python analogies"
```

---

### Task 4: 阶段一 — Dart 控制流与集合

**Files:**
- Create: `phase01_dart_basics/03_control_flow.dart`
- Create: `phase01_dart_basics/04_collections.dart`

- [ ] **Step 1: 创建控制流示例文件**

```dart
// 03_control_flow.dart
// Dart 控制流 — 与 Python 几乎一样，只是需要花括号和分号

void main() {
  // === 1. if/else ===
  var score = 85;
  if (score >= 90) {
    print('优秀');
  } else if (score >= 60) {
    print('及格');
  } else {
    print('不及格');
  }

  // === 2. for 循环 ===
  // Python: for i in range(5):
  for (var i = 0; i < 5; i++) {
    print('for loop: $i');
  }

  // for-in（类似 Python 的 for item in list）
  var fruits = ['苹果', '香蕉', '橙子'];
  for (var fruit in fruits) {
    print('fruit: $fruit');
  }

  // === 3. while 循环 ===
  var count = 3;
  while (count > 0) {
    print('countdown: $count');
    count--;
  }

  // === 4. switch ===
  var command = 'OPEN';
  switch (command) {
    case 'OPEN':
      print('打开');
      break;
    case 'CLOSE':
      print('关闭');
      break;
    default:
      print('未知命令');
  }

  // === 5. 三元运算符 ===
  var isLoggedIn = true;
  var message = isLoggedIn ? '欢迎回来' : '请登录';
  print(message);

  // === 6. 异常处理 ===
  try {
    var result = 10 ~/ 0; // 整除
    print(result);
  } catch (e) {
    print('捕获异常: $e');
  } finally {
    print('finally 总是执行');
  }
}
```

- [ ] **Step 2: 创建集合示例文件**

```dart
// 04_collections.dart
// Dart 集合 — List/Set/Map 对应 Python 的 list/set/dict

void main() {
  // === 1. List（类似 Python list）===
  // Python: nums = [1, 2, 3]
  List<int> nums = [1, 2, 3, 4, 5];
  print('nums: $nums');
  print('first: ${nums.first}, last: ${nums.last}');
  print('length: ${nums.length}');

  // 添加/删除
  nums.add(6);
  nums.remove(1);
  print('after add/remove: $nums');

  // 常用方法（类似 Python 的同名函数）
  // Python: [n*2 for n in nums] 或 list(map(lambda n: n*2, nums))
  var doubled = nums.map((n) => n * 2).toList();
  print('map doubled: $doubled');

  // Python: [n for n in nums if n > 3] 或 list(filter(lambda n: n>3, nums))
  var filtered = nums.where((n) => n > 3).toList();
  print('where > 3: $filtered');

  // 展开操作符（Python 的 *list 解包）
  var more = [0, ...nums, 7, 8];
  print('spread: $more');

  // === 2. Set（类似 Python set）===
  Set<String> tags = {'flutter', 'dart', 'mobile'};
  tags.add('flutter'); // 重复不会添加
  tags.add('coding');
  print('tags: $tags');
  print('has flutter: ${tags.contains('flutter')}');

  // === 3. Map（类似 Python dict）===
  // Python: user = {"name": "Alice", "age": 25}
  Map<String, dynamic> user = {
    'name': 'Alice',
    'age': 25,
    'isAdmin': true,
  };
  print('user: $user');
  print('name: ${user['name']}');

  // 遍历
  user.forEach((key, value) {
    print('$key => $value');
  });

  // === 4. List 的集合操作 ===
  var list1 = [1, 2, 3, 4];
  var list2 = [3, 4, 5, 6];

  // 筛选满足条件的第一个元素
  var firstEven = list1.firstWhere((n) => n % 2 == 0);
  print('first even: $firstEven');

  // 检查是否所有/任一满足条件
  // Python: all(n > 0 for n in list1)  /  any(n > 3 for n in list1)
  print('all > 0: ${list1.every((n) => n > 0)}');
  print('any > 3: ${list1.any((n) => n > 3)}');

  // 排序
  var unsorted = [3, 1, 4, 1, 5, 9];
  unsorted.sort();
  print('sorted: $unsorted');
}
```

- [ ] **Step 3: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add phase01_dart_basics/03_control_flow.dart phase01_dart_basics/04_collections.dart
git commit -m "feat: add Dart control flow and collections tutorial"
```

---

### Task 5: 阶段一 — Dart 面向对象

**Files:**
- Create: `phase01_dart_basics/05_classes.dart`

- [ ] **Step 1: 创建类示例文件**

```dart
// 05_classes.dart
// Dart 面向对象 — 与 Python 类概念相似，语法不同

void main() {
  // === 1. 基本类 ===
  var animal = Animal('旺财', 3);
  animal.speak(); // 旺财 says: ...
  print(animal); // Animal(name: 旺财, age: 3)

  // === 2. 命名构造函数 ===
  var baby = Animal.baby('小猫');
  print(baby); // Animal(name: 小猫, age: 0)

  // === 3. 继承 ===
  var dog = Dog('旺财', 3, '金毛');
  dog.speak(); // 旺财 barks: 汪汪!
  dog.fetch(); // 旺财 is fetching...

  var cat = Cat('咪咪', 2);
  cat.speak(); // 咪咪 meows: 喵喵~

  // === 4. Mixin（Dart 特有的多继承替代）===
  var duck = Duck('唐老鸭');
  duck.swim(); // 唐老鸭 is swimming
  duck.fly(); // 唐老鸭 is flying
  duck.speak(); // 唐老鸭 quacks: 呱呱
}

// --- 基类 ---
class Animal {
  String name;
  int age;

  // 默认构造函数
  Animal(this.name, this.age);

  // 命名构造函数
  Animal.baby(this.name) : age = 0;

  void speak() {
    print('$name says: ...');
  }

  @override
  String toString() => 'Animal(name: $name, age: $age)';
}

// --- 继承 ---
class Dog extends Animal {
  String breed;

  // 调用父类构造函数
  Dog(String name, int age, this.breed) : super(name, age);

  @override
  void speak() {
    print('$name barks: 汪汪!');
  }

  void fetch() {
    print('$name is fetching...');
  }
}

class Cat extends Animal {
  Cat(String name, int age) : super(name, age);

  @override
  void speak() {
    print('$name meows: 喵喵~');
  }
}

// --- Mixin（类似多继承，但更安全）---
mixin Swimmer {
  void swim() {
    print('$this is swimming');
  }
}

mixin Flyer {
  void fly() {
    print('$this is flying');
  }
}

class Duck extends Animal with Swimmer, Flyer {
  Duck(String name) : super(name, 0);

  @override
  void speak() {
    print('$name quacks: 呱呱');
  }
}
```

- [ ] **Step 2: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add phase01_dart_basics/05_classes.dart
git commit -m "feat: add Dart OOP tutorial with Python analogies"
```

---

### Task 6: 阶段一 — Dart 异步编程

**Files:**
- Create: `phase01_dart_basics/06_async.dart`

- [ ] **Step 1: 创建异步编程示例文件**

```dart
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
```

- [ ] **Step 2: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add phase01_dart_basics/06_async.dart
git commit -m "feat: add Dart async programming tutorial"
```

---

### Task 7: 阶段一 — Hello Flutter 项目

**Files:**
- Create: `hello_flutter/pubspec.yaml`
- Create: `hello_flutter/lib/main.dart`

- [ ] **Step 1: 创建 pubspec.yaml**

```yaml
name: hello_flutter
description: 第一个 Flutter 应用 — Hello World

publish_to: 'none'

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
```

- [ ] **Step 2: 创建 main.dart**

```dart
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
```

- [ ] **Step 3: 创建 analysis_options.yaml**

```yaml
# hello_flutter/analysis_options.yaml
include: package:flutter_lints/flutter.yaml

linter:
  rules:
    prefer_const_constructors: true
    prefer_const_declarations: true
```

- [ ] **Step 4: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add hello_flutter/
git commit -m "feat: add hello_flutter project with starter app"
```

---

### Task 8: 阶段二 — Widget 布局示例

**Files:**
- Create: `phase02_widget_examples/01_basic_widgets.dart`
- Create: `phase02_widget_examples/02_layout_examples.dart`
- Create: `phase02_widget_examples/03_listview_examples.dart`

- [ ] **Step 1: 创建基础 Widget 示例**

由于代码较长，核心示例展示常用 Widget 组合：

```dart
// phase02_widget_examples/01_basic_widgets.dart
// Flutter 常用 Widget 速查
// 本文件为参考代码，不是可运行的 Flutter 项目
// 在 business_card 项目中会实际运用这些 Widget

/*
=== 展示类 Widget ===

// Text — 文本
Text(
  'Hello World',
  style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.blue,
  ),
  textAlign: TextAlign.center,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
)

// Image — 图片
Image.network('https://example.com/image.jpg')
Image.asset('assets/images/logo.png')  // 本地资源
Image.file(File('/path/to/image.jpg'))  // 文件

// Icon — 图标
Icon(Icons.star, color: Colors.amber, size: 48)

=== 按钮类 Widget ===

// ElevatedButton — 凸起按钮（主要操作）
ElevatedButton(
  onPressed: () { print('点击'); },
  child: Text('确认'),
)

// TextButton — 文本按钮（次要操作）
TextButton(
  onPressed: () { print('取消'); },
  child: Text('取消'),
)

// IconButton — 图标按钮
IconButton(
  onPressed: () { print('搜索'); },
  icon: Icon(Icons.search),
)

// FloatingActionButton — 浮动按钮
FloatingActionButton(
  onPressed: () {},
  child: Icon(Icons.add),
)

=== 容器类 Widget ===

// Container — 万能容器
Container(
  width: 200,
  height: 100,
  padding: EdgeInsets.all(16),       // 内边距
  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 外边距
  decoration: BoxDecoration(
    color: Colors.blue.shade50,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.blue, width: 2),
    boxShadow: [
      BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
    ],
  ),
  child: Text('内容'),
)

// Padding — 纯内边距
Padding(
  padding: EdgeInsets.all(16),
  child: Text('有内边距的文本'),
)

// Center — 居中
Center(child: Text('居中'))

// SizedBox — 固定尺寸或间距
SizedBox(width: 100, height: 50, child: Text('固定尺寸'))
SizedBox(height: 20)  // 只做垂直间距
*/

void main() {
  print('Widget 速查表 — 请阅读代码中的注释');
  print('运行方式: dart run phase02_widget_examples/01_basic_widgets.dart');
}
```

- [ ] **Step 2: 创建布局示例代码**

```dart
// phase02_widget_examples/02_layout_examples.dart
// Flutter 布局核心：Row、Column、Expanded、Flexible
// 本文件演示弹性布局原理

void main() {
  print('''
=== Flutter 布局核心 ===

Row / Column — 弹性布局的基石
Expanded — 占据剩余空间
Flexible — 占据剩余空间（可限制比例）

=== 常见布局模式 ===

// 1. 水平均匀分布
Row(
  children: [
    Expanded(child: Container(color: Colors.red, height: 50)),
    SizedBox(width: 10),
    Expanded(child: Container(color: Colors.blue, height: 50)),
    SizedBox(width: 10),
    Expanded(child: Container(color: Colors.green, height: 50)),
  ],
)

// 2. 垂直布局 + 底部固定按钮
Column(
  children: [
    Expanded(
      child: Center(child: Text('主要内容')),
    ),
    SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        child: Text('底部按钮'),
      ),
    ),
  ],
)

// 3. Flexible 按比例分配
Row(
  children: [
    Flexible(flex: 2, child: Container(color: Colors.red, height: 50)),
    Flexible(flex: 1, child: Container(color: Colors.blue, height: 50)),
    Flexible(flex: 1, child: Container(color: Colors.green, height: 50)),
  ],
)

// 4. mainAxisAlignment 主轴对齐
Column(
  mainAxisAlignment: MainAxisAlignment.start,    // 顶部
  mainAxisAlignment: MainAxisAlignment.center,    // 居中
  mainAxisAlignment: MainAxisAlignment.end,       // 底部
  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 两端
  mainAxisAlignment: MainAxisAlignment.spaceAround,  // 环绕
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,  // 均匀
  children: [...],
)

// 5. crossAxisAlignment 交叉轴对齐
Row(
  crossAxisAlignment: CrossAxisAlignment.start,   // 顶部
  crossAxisAlignment: CrossAxisAlignment.center,   // 居中
  crossAxisAlignment: CrossAxisAlignment.end,      // 底部
  crossAxisAlignment: CrossAxisAlignment.stretch,  // 拉伸
  children: [...],
)
''');
}
```

- [ ] **Step 3: 创建 ListView 示例**

```dart
// phase02_widget_examples/03_listview_examples.dart
// ListView — Flutter 最常用的滚动列表

void main() {
  print('''
=== ListView 用法 ===

// 1. 少量固定子项（一次性全部构建）
ListView(
  children: [
    ListTile(title: Text('项目 1')),
    ListTile(title: Text('项目 2')),
    ListTile(title: Text('项目 3')),
  ],
)

// 2. builder 模式（推荐！按需构建，性能好）
ListView.builder(
  itemCount: 100,                     // 总数量
  itemBuilder: (context, index) {     // 只构建可见的项
    return ListTile(
      leading: CircleAvatar(child: Text('\${index + 1}')),
      title: Text('第 \${index + 1} 项'),
      subtitle: Text('这是第 \${index + 1} 项的副标题'),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () => print('点击了第 \${index + 1} 项'),
    );
  },
)

// 3. separated 模式（带分隔线）
ListView.separated(
  itemCount: 50,
  separatorBuilder: (context, index) => Divider(),  // 分隔线
  itemBuilder: (context, index) => ListTile(
    title: Text('项目 \${index + 1}'),
  ),
)

=== GridView 网格列表 ===

GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3,          // 每行 3 个
    crossAxisSpacing: 8,        // 水平间距
    mainAxisSpacing: 8,         // 垂直间距
    childAspectRatio: 1.0,      // 宽高比
  ),
  itemCount: 12,
  itemBuilder: (context, index) => Container(
    color: Colors.blue.shade100,
    child: Center(child: Text('网格 \${index + 1}')),
  ),
)
''');
}
```

- [ ] **Step 4: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add phase02_widget_examples/
git commit -m "feat: add Flutter widget and layout reference examples"
```

---

### Task 9: 阶段二 — 名片 App（核心项目）

**Files:**
- Create: `business_card/pubspec.yaml`
- Create: `business_card/lib/main.dart`
- Create: `business_card/lib/screens/home_screen.dart`
- Create: `business_card/lib/screens/skills_screen.dart`
- Create: `business_card/lib/screens/contact_screen.dart`

- [ ] **Step 1: 创建 pubspec.yaml**

```yaml
name: business_card
description: 个人名片 App — Flutter 教程阶段二项目

publish_to: 'none'

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
  assets:
    - assets/images/
```

- [ ] **Step 2: 创建 main.dart**

```dart
// business_card/lib/main.dart
// 名片 App — 多页面导航 + BottomNavigationBar

import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/skills_screen.dart';
import 'screens/contact_screen.dart';

void main() {
  runApp(const BusinessCardApp());
}

class BusinessCardApp extends StatelessWidget {
  const BusinessCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '个人名片',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

// 主页面：BottomNavigationBar 管理三个页面
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // 三个页面
  final List<Widget> _pages = const [
    HomeScreen(),
    SkillsScreen(),
    ContactScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // 当前选中的页面
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.code),
            label: '技能',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: '联系',
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 3: 创建首页**

```dart
// business_card/lib/screens/home_screen.dart
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人名片'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // 头像
            CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 60,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            // 姓名
            Text(
              '张三',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            // 职位
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Flutter 开发者',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // 个人简介卡片
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          '关于我',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '热爱移动开发，专注于使用 Flutter 构建跨平台应用。'
                      '喜欢学习新技术，乐于分享知识。'
                      '工作之余喜欢跑步和阅读。',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // 基本信息卡片
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.location_on, '城市', '北京'),
                    const Divider(),
                    _buildInfoRow(Icons.work, '经验', '3 年'),
                    const Divider(),
                    _buildInfoRow(Icons.school, '学历', '计算机科学 本科'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 20),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const Spacer(),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
```

- [ ] **Step 4: 创建技能页**

```dart
// business_card/lib/screens/skills_screen.dart
import 'package:flutter/material.dart';

class SkillsScreen extends StatelessWidget {
  const SkillsScreen({super.key});

  // 技能数据
  final List<Map<String, dynamic>> skillCategories = const [
    {
      'title': '移动开发',
      'skills': ['Flutter', 'Dart', 'Android', 'iOS'],
      'icon': Icons.phone_android,
      'color': Colors.blue,
    },
    {
      'title': '前端技术',
      'skills': ['HTML', 'CSS', 'JavaScript'],
      'icon': Icons.web,
      'color': Colors.orange,
    },
    {
      'title': '后端技术',
      'skills': ['Python', 'Node.js', 'MySQL'],
      'icon': Icons.dns,
      'color': Colors.green,
    },
    {
      'title': '工具',
      'skills': ['Git', 'VS Code', 'Figma', 'Docker'],
      'icon': Icons.build,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('技能'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: skillCategories.length,
        itemBuilder: (context, index) {
          final category = skillCategories[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 分类标题
                  Row(
                    children: [
                      Icon(
                        category['icon'] as IconData,
                        color: category['color'] as Color,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        category['title'] as String,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // 技能标签
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: (category['skills'] as List<String>).map((skill) {
                      return Chip(
                        label: Text(skill),
                        backgroundColor:
                            (category['color'] as Color).withOpacity(0.1),
                        side: BorderSide(
                          color: (category['color'] as Color).withOpacity(0.3),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
```

- [ ] **Step 5: 创建联系页**

```dart
// business_card/lib/screens/contact_screen.dart
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('联系我'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 联系方式卡片
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildContactTile(
                  icon: Icons.email,
                  label: '邮箱',
                  value: 'zhangsan@example.com',
                  color: Colors.red,
                ),
                const Divider(height: 1),
                _buildContactTile(
                  icon: Icons.phone,
                  label: '电话',
                  value: '+86 138-0000-0000',
                  color: Colors.green,
                ),
                const Divider(height: 1),
                _buildContactTile(
                  icon: Icons.link,
                  label: 'GitHub',
                  value: 'github.com/zhangsan',
                  color: Colors.black,
                ),
                const Divider(height: 1),
                _buildContactTile(
                  icon: Icons.public,
                  label: '网站',
                  value: 'www.zhangsan.dev',
                  color: Colors.blue,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // 留言表单区域
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '发送消息',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: '你的名字',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    maxLines: 4,
                    decoration: const InputDecoration(
                      labelText: '消息内容',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.message_outlined),
                      alignLabelWithHint: true,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('消息已发送！（演示功能）'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('发送'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(label),
      subtitle: Text(value),
      trailing: IconButton(
        icon: const Icon(Icons.copy, size: 18),
        onPressed: () {
          // 复制功能（演示）
        },
      ),
    );
  }
}
```

- [ ] **Step 6: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add business_card/
git commit -m "feat: add business_card Flutter app with 3-tab navigation"
```

---

### Task 10: 阶段三 — 天气 App

**Files:**
- Create: `weather_app/pubspec.yaml`
- Create: `weather_app/lib/main.dart`
- Create: `weather_app/lib/screens/weather_screen.dart`

- [ ] **Step 1: 创建 pubspec.yaml**

```yaml
name: weather_app
description: 天气查询 App — Flutter 教程阶段三项目

publish_to: 'none'

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  http: ^1.1.0

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
```

- [ ] **Step 2: 创建 main.dart**

```dart
// weather_app/lib/main.dart
// 天气查询 App — 状态管理 + 网络请求 + 表单

import 'package:flutter/material.dart';
import 'screens/weather_screen.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '天气查询',
      theme: ThemeData(
        colorSchemeSeed: Colors.cyan,
        useMaterial3: true,
      ),
      home: const WeatherScreen(),
    );
  }
}
```

- [ ] **Step 3: 创建天气页面核心代码**

```dart
// weather_app/lib/screens/weather_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // 控制器：获取输入框的文本
  final TextEditingController _cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // 状态变量
  Map<String, dynamic>? _weatherData;
  bool _isLoading = false;
  String? _errorMessage;

  // 使用免费的 wttr.in API（无需注册）
  Future<void> _fetchWeather(String city) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://wttr.in/$city?format=j1'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _weatherData = data;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = '城市未找到，请检查名称';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '网络请求失败: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  void _onSearch() {
    if (_formKey.currentState!.validate()) {
      _fetchWeather(_cityController.text.trim());
    }
  }

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('天气查询'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 搜索栏
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _cityController,
                      decoration: const InputDecoration(
                        hintText: '输入城市名（英文）',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_city),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '请输入城市名';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _onSearch(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _onSearch,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 内容区域
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    // 正在加载
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('正在查询天气...'),
          ],
        ),
      );
    }

    // 错误
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red.shade300),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red.shade400, fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                setState(() {
                  _errorMessage = null;
                });
              },
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    // 天气数据
    if (_weatherData != null) {
      return _buildWeatherCard();
    }

    // 初始状态
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.cloud, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            '输入城市名查询天气',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '例如: Beijing, Tokyo, London',
            style: TextStyle(color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherCard() {
    final current = _weatherData!['current_condition'][0];
    final weather = _weatherData!['weather'][0];
    final tempC = current['temp_C'];
    final desc = current['weatherDesc'][0]['value'];
    final humidity = current['humidity'];
    final windSpeed = current['windspeedKmph'];
    final feelsLike = current['FeelsLikeC'];
    final maxTemp = weather['maxtempC'];
    final minTemp = weather['mintempC'];

    return RefreshIndicator(
      onRefresh: () => _fetchWeather(_cityController.text.trim()),
      child: ListView(
        children: [
          // 主天气卡片
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    _cityController.text.trim(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '$tempC°C',
                    style: const TextStyle(
                      fontSize: 72,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    desc,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '体感 $feelsLike°C  最高 $maxTemp°C  最低 $minTemp°C',
                    style: const TextStyle(color: Colors.white60),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // 详情卡片
          Row(
            children: [
              Expanded(
                child: _buildDetailCard(
                  Icons.water_drop,
                  '湿度',
                  '$humidity%',
                  Colors.blue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDetailCard(
                  Icons.air,
                  '风速',
                  '$windSpeed km/h',
                  Colors.teal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard(
      IconData icon, String label, String value, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: Colors.grey.shade600)),
          ],
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add weather_app/
git commit -m "feat: add weather_app with http networking and form state management"
```

---

### Task 11: 阶段四 — 待办事项 App（综合项目）

**Files:**
- Create: `todo_app/pubspec.yaml`
- Create: `todo_app/lib/main.dart`
- Create: `todo_app/lib/models/todo.dart`
- Create: `todo_app/lib/providers/todo_provider.dart`
- Create: `todo_app/lib/screens/todo_screen.dart`

- [ ] **Step 1: 创建 pubspec.yaml**

```yaml
name: todo_app
description: 待办事项 App — Flutter 教程阶段四综合项目

publish_to: 'none'

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
```

- [ ] **Step 2: 创建 Todo 模型**

```dart
// todo_app/lib/models/todo.dart
// 待办事项数据模型

class Todo {
  final String id;
  String title;
  bool isDone;
  final DateTime createdAt;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // JSON 序列化（用于 SharedPreferences 存储）
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isDone': isDone,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        title: json['title'],
        isDone: json['isDone'] ?? false,
        createdAt: DateTime.parse(json['createdAt']),
      );
}
```

- [ ] **Step 3: 创建 Provider 状态管理**

```dart
// todo_app/lib/providers/todo_provider.dart
// 状态管理：使用 Provider + ChangeNotifier

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  String _filter = 'all'; // 'all' | 'active' | 'done'

  // 获取过滤后的列表
  List<Todo> get todos {
    switch (_filter) {
      case 'active':
        return _todos.where((t) => !t.isDone).toList();
      case 'done':
        return _todos.where((t) => t.isDone).toList();
      default:
        return List.unmodifiable(_todos);
    }
  }

  List<Todo> get allTodos => _todos;
  String get filter => _filter;

  int get activeCount => _todos.where((t) => !t.isDone).length;

  // 添加待办
  void addTodo(String title) {
    _todos.insert(
      0,
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
      ),
    );
    _saveToStorage();
    notifyListeners();
  }

  // 切换完成状态
  void toggleTodo(String id) {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.isDone = !todo.isDone;
    _saveToStorage();
    notifyListeners();
  }

  // 删除待办
  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    _saveToStorage();
    notifyListeners();
  }

  // 更新标题
  void updateTodo(String id, String newTitle) {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.title = newTitle;
    _saveToStorage();
    notifyListeners();
  }

  // 切换过滤
  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  // 持久化到 SharedPreferences
  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _todos.map((t) => t.toJson()).toList();
    await prefs.setString('todos', jsonEncode(jsonList));
  }

  // 从 SharedPreferences 加载
  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('todos');
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _todos = jsonList.map((j) => Todo.fromJson(j)).toList();
      notifyListeners();
    }
  }
}
```

- [ ] **Step 4: 创建 main.dart**

```dart
// todo_app/lib/main.dart
// 待办事项 App — Provider + SharedPreferences + 动画

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/todo_provider.dart';
import 'screens/todo_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider()..loadFromStorage(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '待办事项',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const TodoScreen(),
    );
  }
}
```

- [ ] **Step 5: 创建主界面**

```dart
// todo_app/lib/screens/todo_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/todo.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTodo() {
    if (_formKey.currentState!.validate()) {
      context.read<TodoProvider>().addTodo(_controller.text.trim());
      _controller.clear();
    }
  }

  void _showEditDialog(Todo todo) {
    final editController = TextEditingController(text: todo.title);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('编辑任务'),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: '任务名称',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              if (editController.text.trim().isNotEmpty) {
                context
                    .read<TodoProvider>()
                    .updateTodo(todo.id, editController.text.trim());
                Navigator.pop(ctx);
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('待办事项'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 输入区域
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: '添加新任务...',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.add_task),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '请输入任务名称';
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) => _addTodo(),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _addTodo,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                    child: const Text('添加'),
                  ),
                ],
              ),
            ),
          ),
          // 过滤栏
          Consumer<TodoProvider>(
            builder: (context, provider, _) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildFilterChip('全部', 'all', provider),
                    const SizedBox(width: 8),
                    _buildFilterChip(
                      '未完成 (${provider.activeCount})',
                      'active',
                      provider,
                    ),
                    const SizedBox(width: 8),
                    _buildFilterChip('已完成', 'done', provider),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          // 任务列表
          Expanded(
            child: Consumer<TodoProvider>(
              builder: (context, provider, _) {
                final todos = provider.todos;

                if (todos.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.task_alt,
                            size: 64, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text(
                          '暂无任务',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    final todo = todos[index];
                    return _buildTodoItem(todo);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value, TodoProvider provider) {
    final isSelected = provider.filter == value;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => provider.setFilter(value),
      selectedColor: Theme.of(context).colorScheme.primaryContainer,
      checkmarkColor: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildTodoItem(Todo todo) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 8),
      child: Dismissible(
        key: Key(todo.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            color: Colors.red.shade300,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) {
          context.read<TodoProvider>().deleteTodo(todo.id);
        },
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            leading: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Checkbox(
                value: todo.isDone,
                onChanged: (_) {
                  context.read<TodoProvider>().toggleTodo(todo.id);
                },
              ),
            ),
            title: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: 16,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
                color: todo.isDone ? Colors.grey : null,
              ),
              child: Text(todo.title),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () => _showEditDialog(todo),
            ),
            onTap: () {
              context.read<TodoProvider>().toggleTodo(todo.id);
            },
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 6: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add todo_app/
git commit -m "feat: add todo_app with Provider, SharedPreferences, and animations"
```

---

### Task 12: 创建总览 README

**Files:**
- Create: `README.md`

- [ ] **Step 1: 创建项目 README**

```markdown
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
```

- [ ] **Step 2: Commit**

```bash
cd /home/rheron/文档/projects/flutter
git add README.md
git commit -m "docs: add project README with learning roadmap"
```

---

## 边界说明

**包含**：Dart 基础语法示例、4 个完整 Flutter 项目、Python 对比注释、Provider 状态管理
**不包含**：Riverpod/BLoC、自定义绘制、原生通信、Firebase 集成、发布打包、单元测试
```

- [ ] **Step 3: Commit final plan**

```bash
cd /home/rheron/文档/projects/flutter
git add docs/superpowers/plans/
git commit -m "docs: add implementation plan for Flutter tutorial"
```
