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
