import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层主题数据
class TInputThemeData with Diagnosticable {
  const TInputThemeData({
    this.maxLength,
    this.size,
    this.decoration,
  });

  /// 用户最多可以输入的文本长度，一个中文等于一个计数长度。值小于等于 0 的时候，则表示不限制输入长度。
  final int? maxLength;

  /// 输入框尺寸。可选项：small/medium/large. 参考[TComponentSize]
  /// 默认值为[TThemeData.size]
  final TComponentSize? size;

  /// 装饰器
  final InputDecoration? decoration;

  /// 复制属性
  TInputThemeData copyWith({
    int? maxLength,
    TComponentSize? size,
    InputDecoration? decoration,
  }) {
    return TInputThemeData(
      maxLength: maxLength ?? this.maxLength,
      size: size ?? this.size,
      decoration: decoration ?? this.decoration,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TInputThemeData &&
          runtimeType == other.runtimeType &&
          maxLength == other.maxLength &&
          size == other.size &&
          decoration == other.decoration;

  @override
  int get hashCode => maxLength.hashCode ^ size.hashCode ^ decoration.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<int>('maxLength', maxLength, defaultValue: null));
    properties.add(DiagnosticsProperty<TComponentSize>('size', size, defaultValue: null));
    properties.add(DiagnosticsProperty<InputDecoration>('decoration', decoration, defaultValue: null));
  }
}

/// 弹出层主题
class TInputTheme extends InheritedTheme {
  final TInputThemeData data;

  const TInputTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// 来自封闭给定上下文的最近主题实例的数据
  static TInputThemeData of(BuildContext context) {
    final TInputTheme? theme = context.dependOnInheritedWidgetOfExactType<TInputTheme>();
    return theme?.data ?? TTheme.of(context).inputThemeData;
  }

  @override
  bool updateShouldNotify(TInputTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TInputTheme(data: data, child: child);
  }
}

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
