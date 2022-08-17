import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 按钮主题数据
class TButtonThemeData with Diagnosticable {
  const TButtonThemeData({
    this.baseStyle,
    this.outlineStyle,
    this.dashedStyle,
    this.textStyle,
    this.themeStyle,
    this.ghost,
    this.size,
  });

  /// 基础主题样式（填充按钮）
  final ButtonStyle? baseStyle;

  /// 线框主题样式（描边按钮）
  final ButtonStyle? outlineStyle;

  /// 虚线主题样式（虚框按钮）
  final ButtonStyle? dashedStyle;

  /// 文字主题样式（文字按钮）
  final ButtonStyle? textStyle;

  /// 组件风格.
  final TButtonThemeStyle? themeStyle;

  /// 是否为幽灵按钮（镂空按钮）
  final bool? ghost;

  /// 组件尺寸。可选项：small/medium/large
  final TComponentSize? size;

  TButtonThemeData copyWith({
    ButtonStyle? baseStyle,
    ButtonStyle? outlineStyle,
    ButtonStyle? dashedStyle,
    ButtonStyle? textStyle,
    TButtonThemeStyle? themeStyle,
    bool? ghost,
    TComponentSize? size,
  }) {
    return TButtonThemeData(
      baseStyle: baseStyle ?? this.baseStyle,
      outlineStyle: outlineStyle ?? this.outlineStyle,
      dashedStyle: dashedStyle ?? this.dashedStyle,
      textStyle: textStyle ?? this.textStyle,
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
          baseStyle == other.baseStyle &&
          outlineStyle == other.outlineStyle &&
          dashedStyle == other.dashedStyle &&
          textStyle == other.textStyle &&
          themeStyle == other.themeStyle &&
          ghost == other.ghost &&
          size == other.size;

  @override
  int get hashCode =>
      baseStyle.hashCode ^ outlineStyle.hashCode ^ dashedStyle.hashCode ^ textStyle.hashCode ^ themeStyle.hashCode ^ ghost.hashCode ^ size.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ButtonStyle>('baseStyle', baseStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<ButtonStyle>('outlineStyle', outlineStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<ButtonStyle>('dashedStyle', dashedStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<ButtonStyle>('textStyle', textStyle, defaultValue: null));
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

///按钮变体枚举
enum TButtonVariant {
  /// 填充按钮
  base,

  /// 描边按钮
  outline,

  /// 虚框按钮
  dashed,

  /// 文字按钮
  text;

  /// 判断是否包含类型
  bool contain({
    bool base = false,
    bool outline = false,
    bool dashed = false,
    bool text = false,
  }) {
    switch (this) {
      case TButtonVariant.base:
        return base;
      case TButtonVariant.outline:
        return outline;
      case TButtonVariant.dashed:
        return dashed;
      case TButtonVariant.text:
        return text;
    }
  }

  /// 根据按钮形式，返回对应的值
  T variantOf<T>({required T base, required T outline, required T dashed, required T text}) {
    switch (this) {
      case TButtonVariant.base:
        return base;
      case TButtonVariant.outline:
        return outline;
      case TButtonVariant.dashed:
        return dashed;
      case TButtonVariant.text:
        return text;
    }
  }
}

/// 预定义的一组形状
enum TButtonShape {
  /// 长方形
  rectangle,

  /// 正方形
  square,

  /// 圆角长方形
  round,

  /// 圆形
  circle;

  /// 根据按钮形状，返回对应的值
  T valueOf<T>({required T rectangle, required T square, required T round, required T circle}) {
    switch (this) {
      case TButtonShape.rectangle:
        return rectangle;
      case TButtonShape.square:
        return square;
      case TButtonShape.round:
        return round;
      case TButtonShape.circle:
        return circle;
    }
  }
}

/// 按钮组件风格
enum TButtonThemeStyle {
  /// 默认色
  defaultStyle,

  /// 品牌色
  primary,

  /// 危险色
  danger,

  /// 告警色
  warning,

  /// 成功色
  success;

  T valueOf<T>({required T defaultStyle, required T primary, required T danger, required T warning, required T success}) {
    switch (this) {
      case TButtonThemeStyle.defaultStyle:
        return defaultStyle;
      case TButtonThemeStyle.primary:
        return primary;
      case TButtonThemeStyle.danger:
        return danger;
      case TButtonThemeStyle.warning:
        return warning;
      case TButtonThemeStyle.success:
        return success;
    }
  }

  T isDefaultOf<T>({required T defaultStyle, required T other}) {
    switch (this) {
      case TButtonThemeStyle.defaultStyle:
        return defaultStyle;
      case TButtonThemeStyle.primary:
        return other;
      case TButtonThemeStyle.danger:
        return other;
      case TButtonThemeStyle.warning:
        return other;
      case TButtonThemeStyle.success:
        return other;
    }
  }
}
