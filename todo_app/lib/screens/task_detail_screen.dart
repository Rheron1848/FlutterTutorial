import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';
import '../providers/todo_provider.dart';
import '../theme.dart';

/// 任务详情页：根据路由传入的 id 从 TodoProvider 中查找任务。
///
/// Python 类比：类似 Flask 的详情视图，通过 URL 参数查数据库记录，
/// 查不到就返回 404 —— 这里显示"任务不存在或已删除"。
class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({required this.todoId, super.key});

  final String todoId;

  @override
  Widget build(BuildContext context) {
    // context.watch：任务数据变化（如切换完成、编辑标题）时本页自动重建
    final provider = context.watch<TodoProvider>();
    final todo = provider.allTodos.where((t) => t.id == todoId).firstOrNull;

    if (todo == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('任务详情'), centerTitle: true),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  size: 64, color: Colors.grey.shade400),
              const SizedBox(height: 16),
              Text(
                '任务不存在或已删除',
                style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              FilledButton.tonalIcon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('返回'),
              ),
            ],
          ),
        ),
      );
    }

    final taskColors = AppTaskColors.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('任务详情'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 标题 + 完成状态
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            todo.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  decoration: todo.isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                  color:
                                      todo.isDone ? Colors.grey : null,
                                ),
                          ),
                        ),
                        Icon(
                          todo.isDone
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: todo.isDone ? Colors.green : Colors.grey,
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    _buildInfoRow(
                      context,
                      label: '完成状态',
                      child: Text(todo.isDone ? '已完成' : '未完成'),
                    ),
                    const SizedBox(height: 12),
                    // 优先级 chip，颜色取自 ThemeExtension
                    _buildInfoRow(
                      context,
                      label: '优先级',
                      child: Chip(
                        visualDensity: VisualDensity.compact,
                        avatar: CircleAvatar(
                          radius: 6,
                          backgroundColor:
                              _priorityColor(taskColors, todo.priority),
                        ),
                        label: Text(todo.priority.label),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      context,
                      label: '创建时间',
                      child: Text(_formatTime(todo.createdAt)),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // 操作区：切换完成 / 删除
            Row(
              children: [
                Expanded(
                  child: FilledButton.tonalIcon(
                    onPressed: () => provider.toggleTodo(todo.id),
                    icon: Icon(
                      todo.isDone ? Icons.undo : Icons.check,
                    ),
                    label: Text(todo.isDone ? '标记为未完成' : '标记为完成'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.tonalIcon(
                    style: FilledButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                    ),
                    onPressed: () {
                      provider.deleteTodo(todo.id);
                      context.pop(); // 删除后返回上一页
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('删除任务'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context,
      {required String label, required Widget child}) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        child,
      ],
    );
  }

  Color _priorityColor(AppTaskColors colors, TodoPriority priority) {
    switch (priority) {
      case TodoPriority.high:
        return colors.highPriority;
      case TodoPriority.medium:
        return colors.mediumPriority;
      case TodoPriority.low:
        return colors.lowPriority;
    }
  }

  String _formatTime(DateTime time) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${time.year}-${two(time.month)}-${two(time.day)} '
        '${two(time.hour)}:${two(time.minute)}';
  }
}
