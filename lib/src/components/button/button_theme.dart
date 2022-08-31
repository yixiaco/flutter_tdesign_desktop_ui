import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TButtonStyle with Diagnosticable {
  const TButtonStyle({
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.fixedSize,
    this.minimumSize,
    this.maximumSize,
    this.side,
    this.shape,
    this.mouseCursor,
    this.enableFeedback,
    this.alignment,
    this.fixedRippleColor,
  });

  /// 文本样式
  final MaterialStateProperty<TextStyle?>? textStyle;

  /// 背景色
  final MaterialStateProperty<Color?>? backgroundColor;

  /// 前景色
  final MaterialStateProperty<Color?>? foregroundColor;

  /// 内边距
  final MaterialStateProperty<EdgeInsetsGeometry?>? padding;

  /// 固定大小
  final MaterialStateProperty<Size?>? fixedSize;

  /// 最小大小
  final MaterialStateProperty<Size?>? minimumSize;

  /// 最大大小
  final MaterialStateProperty<Size?>? maximumSize;

  /// 边框
  final MaterialStateProperty<BorderSide?>? side;

  /// 自定义形状
  final MaterialStateProperty<OutlinedBorder?>? shape;

  /// 鼠标样式
  final MaterialStateProperty<MouseCursor?>? mouseCursor;

  /// 检测到的手势是否应该提供声音和/或触觉反馈。
  /// 例如，在Android上，当反馈功能被启用时，轻按会产生点击声，长按会产生短暂的震动。
  /// 通常组件的默认值是true
  final bool? enableFeedback;

  /// 对齐
  final AlignmentGeometry? alignment;

  /// 波纹颜色
  final Color? fixedRippleColor;

  TButtonStyle copyWith({
    MaterialStateProperty<TextStyle?>? textStyle,
    MaterialStateProperty<Color?>? backgroundColor,
    MaterialStateProperty<Color?>? foregroundColor,
    MaterialStateProperty<EdgeInsetsGeometry?>? padding,
    MaterialStateProperty<Size?>? fixedSize,
    MaterialStateProperty<Size?>? minimumSize,
    MaterialStateProperty<Size?>? maximumSize,
    MaterialStateProperty<BorderSide?>? side,
    MaterialStateProperty<OutlinedBorder?>? shape,
    MaterialStateProperty<MouseCursor?>? mouseCursor,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    Color? fixedRippleColor,
  }) {
    return TButtonStyle(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      padding: padding ?? this.padding,
      fixedSize: fixedSize ?? this.fixedSize,
      minimumSize: minimumSize ?? this.minimumSize,
      maximumSize: maximumSize ?? this.maximumSize,
      side: side ?? this.side,
      shape: shape ?? this.shape,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      alignment: alignment ?? this.alignment,
      fixedRippleColor: fixedRippleColor ?? this.fixedRippleColor,
    );
  }

  TButtonStyle merge(TButtonStyle? buttonStyle) {
    if (buttonStyle == null) {
      return this;
    }
    return copyWith(
      textStyle: buttonStyle.textStyle,
      backgroundColor: buttonStyle.backgroundColor,
      foregroundColor: buttonStyle.foregroundColor,
      padding: buttonStyle.padding,
      fixedSize: buttonStyle.fixedSize,
      minimumSize: buttonStyle.minimumSize,
      maximumSize: buttonStyle.maximumSize,
      side: buttonStyle.side,
      shape: buttonStyle.shape,
      mouseCursor: buttonStyle.mouseCursor,
      enableFeedback: buttonStyle.enableFeedback,
      alignment: buttonStyle.alignment,
      fixedRippleColor: buttonStyle.fixedRippleColor,
    );
  }
}

/// 按钮主题数据
class TButtonThemeData with Diagnosticable {
  const TButtonThemeData({
    this.style,
    this.variant,
    this.themeStyle,
    this.ghost,
    this.size,
  });

  /// 按钮样式
  final TButtonStyle? style;

  /// 按钮形式
  final TButtonVariant? variant;

  /// 组件风格.
  final TButtonThemeStyle? themeStyle;

  /// 是否为幽灵按钮（镂空按钮）
  final bool? ghost;

  /// 组件尺寸。可选项：small/medium/large
  final TComponentSize? size;

  TButtonThemeData copyWith({
    TButtonStyle? style,
    TButtonVariant? variant,
    TButtonThemeStyle? themeStyle,
    bool? ghost,
    TComponentSize? size,
  }) {
    return TButtonThemeData(
      style: style ?? this.style,
      variant: variant ?? this.variant,
      themeStyle: themeStyle ?? this.themeStyle,
      ghost: ghost ?? this.ghost,
      size: size ?? this.size,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TButtonThemeData &&
          runtimeType == other.runtimeType &&
          style == other.style &&
          variant == other.variant &&
          themeStyle == other.themeStyle &&
          ghost == other.ghost &&
          size == other.size;

  @override
  int get hashCode => style.hashCode ^ variant.hashCode ^ themeStyle.hashCode ^ ghost.hashCode ^ size.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TButtonStyle>('style', style, defaultValue: null));
    properties.add(DiagnosticsProperty<TButtonVariant>('variant', variant, defaultValue: null));
    properties.add(DiagnosticsProperty<TButtonThemeStyle>('themeStyle', themeStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('ghost', ghost, defaultValue: null));
    properties.add(DiagnosticsProperty<TComponentSize>('size', size, defaultValue: null));
  }
}

/// 按钮主题
class TButtonTheme extends InheritedTheme {
  const TButtonTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  final TButtonThemeData data;

  /// 来自封闭给定上下文的最近主题实例的数据
  static TButtonThemeData of(BuildContext context) {
    final TButtonTheme? theme = context.dependOnInheritedWidgetOfExactType<TButtonTheme>();
    return theme?.data ?? TTheme.of(context).buttonThemeData;
  }

  @override
  bool updateShouldNotify(TButtonTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TButtonTheme(data: data, child: child);
  }
}
