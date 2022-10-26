/// 标签类型
enum TTagShape {
  /// 方形
  square,

  /// 圆角方形
  round,

  /// 标记型
  mark;
}

/// 组件风格
enum TTagTheme {
  /// 默认
  defaultTheme,

  /// 主色
  primary,

  /// 告警色
  warning,

  /// 错误色
  danger,

  /// 成功色
  success,

  /// 超链
  link;
}

/// 标签风格变体
enum TTagVariant {
  /// [TTagTheme]非默认时，主色背景，白色前景
  dark,

  /// [TTagTheme]非默认时，半透明主色背景，主色前景
  light,

  /// [TTagTheme]非默认时，透明背景，主色前景,主色边框
  outline,

  /// [TTagTheme]非默认时，半透明背景，主色前景,主色边框
  lightOutline;
}
