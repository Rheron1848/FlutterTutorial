import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

/// 设置页：主题模式切换 + 关于信息。
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.watch：主题模式变化时（包括初次加载完成）自动重建
    final themeMode = context.watch<ThemeProvider>().mode;

    return Scaffold(
      appBar: AppBar(title: const Text('设置'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('外观', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          child: RadioGroup<ThemeMode>(
            groupValue: themeMode,
            onChanged: (mode) {
              if (mode != null) {
                // 选中即写入 ThemeProvider（内部负责持久化）
                context.read<ThemeProvider>().setMode(mode);
              }
            },
            child: Column(
              children: [
                _buildModeTile(ThemeMode.light, Icons.light_mode, '浅色'),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildModeTile(ThemeMode.dark, Icons.dark_mode, '深色'),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _buildModeTile(
                  ThemeMode.system,
                  Icons.settings_suggest,
                  '跟随系统',
                ),
              ],
            ),
          ),
          ),
          const SizedBox(height: 32),
          const AboutSection(),
        ],
      ),
    );
  }

  // RadioGroup（RadioListTile 的新版分组祖先控件）负责管理选中值
  Widget _buildModeTile(ThemeMode value, IconData icon, String label) {
    return RadioListTile<ThemeMode>(
      title: Text(label),
      secondary: Icon(icon),
      value: value,
    );
  }
}

/// 底部「关于」说明区
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(color: Colors.grey.shade600);
    return Column(
      children: [
        Icon(Icons.school_outlined, size: 48, color: Colors.grey.shade400),
        const SizedBox(height: 12),
        Text('待办事项 App', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Text(
          'Flutter 教程阶段五练习项目：\n'
          '声明式路由（go_router）· 底部导航 · 深浅色主题 · 深链支持',
          textAlign: TextAlign.center,
          style: textStyle,
        ),
      ],
    );
  }
}
