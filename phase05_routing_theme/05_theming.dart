// phase05_routing_theme/05_theming.dart
// 阶段五:路由与主题 — ThemeData / ColorScheme / TextTheme / ThemeExtension
// 本文件为参考代码,不是可运行的 Flutter 项目,全部示例在下方注释块中

/*
=== ThemeData 三件套:theme / darkTheme / themeMode ===

// MaterialApp 同时接收亮色和暗色两套主题,由 themeMode 决定用哪套。
//
// Python 类比:
//   ThemeData ≈ 一个集中存放样式变量的 dict(CSS 里的 :root 变量),
//   全局定义一次,所有 Widget 从这里取色、取字号,而不是到处写死。

MaterialApp(
  title: 'Todo App',
  theme: ThemeData.light(),      // 亮色主题
  darkTheme: ThemeData.dark(),   // 暗色主题(可省略,省略则不支持暗色)
  themeMode: ThemeMode.system,   // 跟随系统的亮/暗设置
  home: const HomePage(),
)

// ThemeMode 三态:
//   ThemeMode.system — 跟随系统(默认,推荐)
//   ThemeMode.light  — 强制亮色
//   ThemeMode.dark   — 强制暗色

=== ColorScheme.fromSeed:一套种子色生成两套配色 ===

// 给一个种子色,Material 3 会自动推导出一整套协调的
// 主色、次要色、容器色等;再配合 brightness 生成亮色/暗色版本。

ThemeData buildTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF2196F3), // 种子色,品牌主色
    brightness: brightness,             // 同一套种子色生成亮/暗两版
  );
  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
  );
}

// 页面里取色:
// Theme.of(context).colorScheme.primary      // 主色
// Theme.of(context).colorScheme.surface      // 背景色
// Theme.of(context).colorScheme.onPrimary    // 主色上的前景色
//
// Python 类比:就像只定义一个主题色变量,
// CSS 预处理器自动派生出 hover 色、边框色等一整套。

=== TextTheme:集中管理文字样式 ===

// Material 3 预定义了一套字号阶梯,集中管理正文、标题样式。

TextTheme textTheme = ThemeData().textTheme;

Text('大标题', style: textTheme.headlineLarge)   // 页面级大标题
Text('小节标题', style: textTheme.titleMedium)   // 卡片/列表项标题
Text('正文内容', style: textTheme.bodyMedium)    // 默认正文
Text('辅助说明', style: textTheme.bodySmall)     // 次要/说明文字

// 页面中统一替换:
ThemeData(
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontSize: 16, height: 1.5),
  ),
)

// 使用时通过 Theme.of(context) 拿,保证跟随当前主题:
Text('正文', style: Theme.of(context).textTheme.bodyMedium)

=== ThemeExtension:自定义主题属性 ===

// 内置 ThemeData 只覆盖 Material 规范的颜色和文字,
// 设计系统里自定义的品牌色、优先级色(如 todo 的 高/中/低 优先级色)
// 需要 ThemeExtension 扩展。
//
// 三步:
// 1) extends ThemeExtension<T>,实现 copyWith 和 lerp(亮暗主题切换时平滑过渡)
// 2) 在 MaterialApp 的 ThemeData 里用 extensions: 注册
// 3) 提供 static of(BuildContext) 方便页面读取

// 1) 定义:
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    this.brand = const Color(0xFF2196F3),
    this.priorityHigh = Colors.red,
    this.priorityLow = Colors.grey,
  });

  final Color brand;          // 品牌色
  final Color priorityHigh;   // 高优先级色
  final Color priorityLow;    // 低优先级色

  @override
  AppColors copyWith({
    Color? brand,
    Color? priorityHigh,
    Color? priorityLow,
  }) {
    return AppColors(
      brand: brand ?? this.brand,
      priorityHigh: priorityHigh ?? this.priorityHigh,
      priorityLow: priorityLow ?? this.priorityLow,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    // lerp:亮暗主题切换时在两种配色间平滑插值
    if (other is! AppColors) return this;
    return AppColors(
      brand: Color.lerp(brand, other.brand, t)!,
      priorityHigh: Color.lerp(priorityHigh, other.priorityHigh, t)!,
      priorityLow: Color.lerp(priorityLow, other.priorityLow, t)!,
    );
  }

  // 3) 读取入口:AppColors.of(context)
  static AppColors of(BuildContext context) =>
      Theme.of(context).extension<AppColors>()!;
}

// 2) 注册到主题(亮暗主题各给一份,通常暗色版调低饱和度):
ThemeData(
  extensions: const [AppColors()],
)

// 页面中使用:
// final colors = AppColors.of(context);
// Icon(Icons.flag, color: colors.priorityHigh);
//
// Python 类比:相当于往全局配置 dict 里加自定义键,
// copyWith ≈ dict | 覆盖项 产生新 dict(不可变更新),
// 而 Theme.of(context) 类似读取当前生效的那份配置。
*/

void main() {
  print('Theming 参考代码 — 请阅读上方注释块');
  print('运行方式: dart run phase05_routing_theme/05_theming.dart');
}
