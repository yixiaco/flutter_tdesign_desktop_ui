import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 选项卡主题数据
class TTabsStyleData with Diagnosticable {
  const TTabsStyleData({
    this.backgroundColor,
    this.indicatorColor,
    this.iconButtonStyle,
    this.buttonStyle,
  });

  /// 容器背景颜色
  final Color? backgroundColor;

  /// 下划线指示器颜色
  final Color? indicatorColor;

  /// icon按钮样式
  final TTabsIconButtonStyle? iconButtonStyle;

  /// 按钮样式
  final TTabsButtonStyle? buttonStyle;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Color>('backgroundColor', backgroundColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('indicatorColor', indicatorColor, defaultValue: null));
    properties.add(DiagnosticsProperty<TTabsIconButtonStyle>('iconButtonStyle', iconButtonStyle, defaultValue: null));
    properties.add(DiagnosticsProperty<TTabsButtonStyle>('buttonStyle', buttonStyle, defaultValue: null));
  }

  TTabsStyleData copyWith({
    Color? backgroundColor,
    Color? indicatorColor,
    TTabsIconButtonStyle? iconButtonStyle,
    TTabsButtonStyle? buttonStyle,
  }) {
    return TTabsStyleData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      iconButtonStyle: iconButtonStyle ?? this.iconButtonStyle,
      buttonStyle: buttonStyle ?? this.buttonStyle,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TTabsStyleData &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          indicatorColor == other.indicatorColor &&
          iconButtonStyle == other.iconButtonStyle &&
          buttonStyle == other.buttonStyle;

  @override
  int get hashCode => backgroundColor.hashCode ^ indicatorColor.hashCode ^ iconButtonStyle.hashCode ^ buttonStyle.hashCode;
}

/// 弹出层主题
class TTabsStyle extends InheritedTheme {
  final TTabsStyleData data;

  const TTabsStyle({
    super.key,
    required this.data,
    required super.child,
  });

  /// 来自封闭给定上下文的最近主题实例的数据
  static TTabsStyleData of(BuildContext context) {
    final TTabsStyle? theme = context.dependOnInheritedWidgetOfExactType<TTabsStyle>();
    return theme?.data ?? TTheme.of(context).tabsStyleData;
  }

  @override
  bool updateShouldNotify(TTabsStyle oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TTabsStyle(data: data, child: child);
  }
}

/// 选项卡按钮样式
class TTabsButtonStyle {
  /// 鼠标样式
  final MaterialStateProperty<MouseCursor>? cursor;

  /// 字体颜色，可以使用[MaterialStateColor]或[Color]
  final Color? textColor;

  /// 背景颜色，可以使用[MaterialStateColor]或[Color]
  final Color? backgroundColor;

  /// 水波纹颜色
  final Color? rippleColor;

  /// 关闭icon颜色
  final Color? closeIconColor;

  const TTabsButtonStyle({
    this.cursor,
    this.textColor,
    this.backgroundColor,
    this.rippleColor,
    this.closeIconColor,
  });

  TTabsButtonStyle copyWith({
    MaterialStateProperty<MouseCursor>? cursor,
    Color? textColor,
    Color? backgroundColor,
    Color? rippleColor,
    Color? closeIconColor,
  }) {
    return TTabsButtonStyle(
      cursor: cursor ?? this.cursor,
      textColor: textColor ?? this.textColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      rippleColor: rippleColor ?? this.rippleColor,
      closeIconColor: closeIconColor ?? this.closeIconColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TTabsButtonStyle &&
          runtimeType == other.runtimeType &&
          cursor == other.cursor &&
          textColor == other.textColor &&
          backgroundColor == other.backgroundColor &&
          rippleColor == other.rippleColor &&
          closeIconColor == other.closeIconColor;

  @override
  int get hashCode => cursor.hashCode ^ textColor.hashCode ^ backgroundColor.hashCode ^ rippleColor.hashCode ^ closeIconColor.hashCode;
}

/// 选项卡icon按钮样式
class TTabsIconButtonStyle {
  /// 阴影
  final BoxShadow? boxShadow;

  /// 边框样式
  final Border? border;

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 按钮背景颜色，可以使用[MaterialStateColor]或[Color]
  final Color? backgroundColor;

  /// icon大小
  final double? iconSize;

  /// icon颜色，可以使用[MaterialStateColor]或[Color]
  final Color? iconColor;

  const TTabsIconButtonStyle({
    this.boxShadow,
    this.border,
    this.width,
    this.height,
    required this.backgroundColor,
    required this.iconSize,
    required this.iconColor,
  });

  TTabsIconButtonStyle copyWith({
    BoxShadow? boxShadow,
    Border? border,
    double? width,
    double? height,
    Color? backgroundColor,
    double? iconSize,
    Color? iconColor,
  }) {
    return TTabsIconButtonStyle(
      boxShadow: boxShadow ?? this.boxShadow,
      border: border ?? this.border,
      width: width ?? this.width,
      height: height ?? this.height,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconSize: iconSize ?? this.iconSize,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TTabsIconButtonStyle &&
          runtimeType == other.runtimeType &&
          boxShadow == other.boxShadow &&
          border == other.border &&
          width == other.width &&
          height == other.height &&
          backgroundColor == other.backgroundColor &&
          iconSize == other.iconSize &&
          iconColor == other.iconColor;

  @override
  int get hashCode =>
      boxShadow.hashCode ^ border.hashCode ^ width.hashCode ^ height.hashCode ^ backgroundColor.hashCode ^ iconSize.hashCode ^ iconColor.hashCode;
}
