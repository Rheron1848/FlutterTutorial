/// 任务优先级枚举。
///
/// Python 类比：类似 `enum.Enum`，可以给每个成员附加属性（这里是中文 label）。
enum TodoPriority {
  high('高'),
  medium('中'),
  low('低');

  /// 中文显示名，用于 UI 展示
  final String label;

  const TodoPriority(this.label);

  /// 从字符串反序列化，容错处理：未知值回退为 medium
  static TodoPriority fromString(String? value) => TodoPriority.values
      .firstWhere((p) => p.name == value, orElse: () => TodoPriority.medium);
}

class Todo {
  final String id;
  String title;
  bool isDone;
  final DateTime createdAt;
  TodoPriority priority;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
    this.priority = TodoPriority.medium,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isDone': isDone,
        'priority': priority.name,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json['id'],
        title: json['title'],
        isDone: json['isDone'] ?? false,
        // 旧数据没有 priority 字段，容错为默认值 medium
        priority: TodoPriority.fromString(json['priority']),
        createdAt: DateTime.parse(json['createdAt']),
      );
}
