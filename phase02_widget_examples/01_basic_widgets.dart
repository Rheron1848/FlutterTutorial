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
