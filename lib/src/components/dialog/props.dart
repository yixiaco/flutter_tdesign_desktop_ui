/// 对话框风格
enum TDialogTheme {
  /// 默认
  defaultTheme,

  /// 信息
  info,

  /// 警告
  warning,

  /// 错误
  danger,

  ///成功
  success;
}

/// 对话框类型
enum TDialogMode {
  /// 弹出「模态对话框」时，只能操作对话框里面的内容，不能操作其他内容
  modal,

  /// 弹出「非模态对话框」时，则可以操作页面内所有内容
  modeless,

  /// 「普通对话框」是指没有脱离文档流的对话框，可以在这个基础上开发更多的插件
  normal;
}
