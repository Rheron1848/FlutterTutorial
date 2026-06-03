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
