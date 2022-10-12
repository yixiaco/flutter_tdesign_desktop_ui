/// 表单字段标签对齐方式
enum TFormLabelAlign {
  /// 左对齐
  left,

  /// 右对齐
  right,

  /// 顶部对齐
  top;
}

/// 表单布局
enum TFormLayout {
  /// 纵向布局
  vertical,

  /// 行内布局
  inline;
}

/// 重置表单的方式
enum TFormResetType {
  /// 重置表单为空
  empty,

  /// 重置表单数据为初始值
  initial;
}

/// 表单校验不通过时，是否自动滚动到第一个校验不通过的字段
enum TFormScrollToFirstError {
  /// 平滑滚动
  smooth,

  /// 瞬间直达
  auto;
}

/// 表单项状态
enum TFormItemStatus {
  /// 成功
  success,

  /// 错误
  error,

  /// 告警
  warning;
}
