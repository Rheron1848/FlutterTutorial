import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  String _filter = 'all';

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

  void addTodo(String title, {TodoPriority priority = TodoPriority.medium}) {
    _todos.insert(
      0,
      Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        priority: priority,
      ),
    );
    _saveToStorage();
    notifyListeners();
  }

  void toggleTodo(String id) {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.isDone = !todo.isDone;
    _saveToStorage();
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
    _saveToStorage();
    notifyListeners();
  }

  void updateTodo(
    String id,
    String newTitle, {
    TodoPriority? priority,
  }) {
    final todo = _todos.firstWhere((t) => t.id == id);
    todo.title = newTitle;
    if (priority != null) {
      todo.priority = priority;
    }
    _saveToStorage();
    notifyListeners();
  }

  void setFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  Future<void> _saveToStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _todos.map((t) => t.toJson()).toList();
    await prefs.setString('todos', jsonEncode(jsonList));
  }

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
