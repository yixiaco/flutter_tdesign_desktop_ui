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
