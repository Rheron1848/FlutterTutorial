import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 主题模式状态管理。
///
/// Python 类比：类似一个可读写的全局配置对象（如 config 模块），
/// 修改主题模式后立即通知所有监听者重建，并写入 SharedPreferences 持久化。
/// 复习阶段四的 ChangeNotifier + SharedPreferences 用法。
class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  /// 启动时从本地存储读取用户上次的选择（无记录则跟随系统）
  Future<void> loadFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefsKey);
    _mode = ThemeMode.values.firstWhere(
      (m) => m.name == saved,
      orElse: () => ThemeMode.system,
    );
    notifyListeners();
  }

  /// 切换主题模式并持久化
  Future<void> setMode(ThemeMode mode) async {
    if (_mode == mode) return;
    _mode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, mode.name);
    notifyListeners();
  }

  static const _prefsKey = 'theme_mode';
}
