/// 进度条状态
enum TProgressStatus {
  /// 成功
  success,
  /// 错误
  error,
  /// 告警
  warning,
  /// 执行动画
  active;
}

/// 进度条风格。
/// 值为 line，标签（label）显示在进度条右侧；
/// 值为 plump，标签（label）显示在进度条里面；
/// 值为 circle，标签（label）显示在进度条正中间。
enum TProgressTheme {
  /// 标签（label）显示在进度条右侧；
  line,
  /// 标签（label）显示在进度条里面；
  plump,
  /// 标签（label）显示在进度条正中间。
  circle;
}