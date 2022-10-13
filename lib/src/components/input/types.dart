
import 'package:tdesign_desktop_ui/src/basic/functions.dart';

/// 输入框状态
enum TInputStatus {
  /// 默认状态
  defaultStatus,

  /// 成功状态
  success,

  /// 告警状态
  warning,

  /// 错误状态
  error;

  /// 懒惰的返回值
  T lazyValueOf<T>({
    required TSupplier<T> defaultStatus,
    required TSupplier<T> success,
    required TSupplier<T> warning,
    required TSupplier<T> error,
  }) {
    switch (this) {
      case TInputStatus.defaultStatus:
        return defaultStatus();
      case TInputStatus.success:
        return success();
      case TInputStatus.warning:
        return warning();
      case TInputStatus.error:
        return error();
    }
  }
}

/// 输入框类型
enum TInputType {
  /// 文本
  text,

  /// 密码
  password;
}
