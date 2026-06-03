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
