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
