import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层主题数据
class TInputThemeData with Diagnosticable {
  const TInputThemeData({
    this.maxLength,
    this.size,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.boxShadow,
  });

  /// 用户最多可以输入的文本长度，一个中文等于一个计数长度。值小于等于 0 的时候，则表示不限制输入长度。
  final int? maxLength;

  /// 输入框尺寸。可选项：small/medium/large. 参考[TComponentSize]
  /// 默认值为[TThemeData.size]
  final TComponentSize? size;

  /// 边框圆角样式
  final BorderRadiusGeometry? borderRadius;

  /// 背景颜色
  final Color? backgroundColor;

  /// 边框颜色
  final Color? borderColor;

  /// 边框阴影
  final List<BoxShadow>? boxShadow;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<int>('maxLength', maxLength, defaultValue: null));
    properties.add(DiagnosticsProperty<TComponentSize>('size', size, defaultValue: null));
    properties.add(DiagnosticsProperty<BorderRadiusGeometry>('borderRadius', borderRadius, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('backgroundColor', backgroundColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('borderColor', borderColor, defaultValue: null));
    properties.add(DiagnosticsProperty<List<BoxShadow>>('boxShadow', boxShadow, defaultValue: null));
  }

  TInputThemeData copyWith({
    int? maxLength,
    TComponentSize? size,
    BorderRadiusGeometry? borderRadius,
    Color? backgroundColor,
    Color? borderColor,
    List<BoxShadow>? boxShadow,
  }) {
    return TInputThemeData(
      maxLength: maxLength ?? this.maxLength,
      size: size ?? this.size,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TInputThemeData &&
          runtimeType == other.runtimeType &&
          maxLength == other.maxLength &&
          size == other.size &&
          borderRadius == other.borderRadius &&
          backgroundColor == other.backgroundColor &&
          borderColor == other.borderColor &&
          boxShadow == other.boxShadow;

  @override
  int get hashCode =>
      maxLength.hashCode ^
      size.hashCode ^
      borderRadius.hashCode ^
      backgroundColor.hashCode ^
      borderColor.hashCode ^
      boxShadow.hashCode;
}

/// 弹出层主题
class TInputTheme extends InheritedTheme {
  final TInputThemeData data;

  const TInputTheme({
    super.key,
    required this.data,
    required super.child,
  });

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
