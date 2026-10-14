import 'package:flutter/material.dart';

/// 浅色 / 深色两套主题。
///
/// Python 类比：类似给应用准备两套 CSS 主题表，
/// 通过 `ThemeMode` 决定用哪一套（或跟随系统）。
/// 种子色与教程前面阶段保持一致：deepPurple。
final ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  extensions: const [AppTaskColors.light],
);

final ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  extensions: const [AppTaskColors.dark],
);

/// 任务优先级对应的自定义颜色。
///
/// Python 类比：类似给主题挂一个可插拔的「颜色字典」，
/// 通过 `ThemeExtension` 声明，深浅色各配一套，
/// 页面里用 `Theme.of(context).extension<AppTaskColors>()` 取出来。
@immutable
class AppTaskColors extends ThemeExtension<AppTaskColors> {
  final Color highPriority; // 高优先级
  final Color mediumPriority; // 中优先级
  final Color lowPriority; // 低优先级

  const AppTaskColors({
    required this.highPriority,
    required this.mediumPriority,
    required this.lowPriority,
  });

  /// 浅色主题下的优先级配色
  static const light = AppTaskColors(
    highPriority: Color(0xFFD32F2F),
    mediumPriority: Color(0xFFF57C00),
    lowPriority: Color(0xFF388E3C),
  );

  /// 深色主题下的优先级配色（整体调亮，保证深色背景上可读）
  static const dark = AppTaskColors(
    highPriority: Color(0xFFEF9A9A),
    mediumPriority: Color(0xFFFFCC80),
    lowPriority: Color(0xFFA5D6A7),
  );

  /// 便捷取值方法，类似 Python 的 @classmethod 工具方法
  static AppTaskColors of(BuildContext context) =>
      Theme.of(context).extension<AppTaskColors>()!;

  @override
  AppTaskColors copyWith({
    Color? highPriority,
    Color? mediumPriority,
    Color? lowPriority,
  }) {
    return AppTaskColors(
      highPriority: highPriority ?? this.highPriority,
      mediumPriority: mediumPriority ?? this.mediumPriority,
      lowPriority: lowPriority ?? this.lowPriority,
    );
  }

  @override
  AppTaskColors lerp(AppTaskColors? other, double t) {
    if (other == null) return this;
    return AppTaskColors(
      highPriority: Color.lerp(highPriority, other.highPriority, t)!,
      mediumPriority: Color.lerp(mediumPriority, other.mediumPriority, t)!,
      lowPriority: Color.lerp(lowPriority, other.lowPriority, t)!,
    );
  }
}
