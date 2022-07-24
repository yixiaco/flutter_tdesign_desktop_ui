import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

// 边框圆角
const double borderRadius = 3;

// Font
const double fontSize = 10;
const double fontSizeS = fontSize * 1.2;
const double fontSizeBase = fontSize * 1.4;
const double fontSizeL = fontSize * 1.6;
const double fontSizeXL = fontSize * 2;
const double fontSizeXXL = fontSize * 3.6;

// Spacer
const double spacer = 8;
const double spacerS = spacer * .5; // 间距-4
const double spacerM = spacer * .75; // 间距-6
const double spacerL = spacer * 1.5; // 间距-12
const double spacer1 = spacer; // 间距-8
const double spacer2 = spacer * 2; // 间距-16
const double spacer3 = spacer * 3; // 间距-24
const double spacer4 = spacer * 4; // 间距-32
const double spacer5 = spacer * 5; // 间距-大-40
const double spacer6 = spacer * 6; // 间距-大-48
const double spacer7 = spacer * 7; // 间距-大-48
const double spacer8 = spacer * 8; // 间距-大-48
const double spacer9 = spacer * 9; // 间距-大-48
const double spacer10 = spacer * 10; // 间距-大-80

/// 颜色主题数据
class TThemeData with Diagnosticable {
  factory TThemeData({
    required Brightness brightness,
    TColorScheme? colorScheme,
    TComponentSize? size,
    String? fontFamily,
    TButtonThemeData? buttonThemeData,
    TPopupThemeData? popupThemeData,
  }) {
    return TThemeData.raw(
      brightness: brightness,
      colorScheme: colorScheme ?? (brightness == Brightness.light ? TColorScheme.light : TColorScheme.dark),
      size: size ?? TComponentSize.medium,
      fontFamily: fontFamily ?? 'PingFang SC, Microsoft YaHei, Arial Regular',
      buttonThemeData: buttonThemeData ?? const TButtonThemeData(),
      popupThemeData: popupThemeData ?? const TPopupThemeData(),
    );
  }

  TThemeData.raw({
    required this.brightness,
    required this.colorScheme,
    required this.size,
    required this.fontFamily,
    required this.buttonThemeData,
    required this.popupThemeData,
  });

  /// 描述主题或调色板的对比度。
  final Brightness brightness;

  /// 配色方案
  final TColorScheme colorScheme;

  /// 组件尺寸,默认medium。可选项：small/medium/large
  final TComponentSize size;

  /// 字体
  final String fontFamily;

  /// 按钮主题数据
  final TButtonThemeData buttonThemeData;

  /// 弹出层主题数据
  final TPopupThemeData popupThemeData;

  /// 基础/下层 投影 hover 使用的组件包括：表格 /
  List<BoxShadow> get shadow1 => colorScheme.shadow1;

  /// 中层投影 下拉 使用的组件包括：下拉菜单 / 气泡确认框 / 选择器 /
  List<BoxShadow> get shadow2 => colorScheme.shadow2;

  /// 上层投影（警示/弹窗）使用的组件包括：全局提示 / 消息通知
  List<BoxShadow> get shadow3 => colorScheme.shadow3;

  // 内投影 用于弹窗类组件（气泡确认框 / 全局提示 / 消息通知）的内描边
  BoxShadow get shadowInsetTop => colorScheme.shadowInsetTop;

  BoxShadow get shadowInsetRight => colorScheme.shadowInsetRight;

  BoxShadow get shadowInsetBottom => colorScheme.shadowInsetBottom;

  BoxShadow get shadowInsetLeft => colorScheme.shadowInsetLeft;

  List<BoxShadow> get shadowInset => [shadowInsetTop, shadowInsetRight, shadowInsetBottom, shadowInsetLeft];

  // 融合阴影
  List<BoxShadow> get shadow2Inset => [...shadow2, ...shadowInset];

  List<BoxShadow> get shadow3Inset => [...shadow3, ...shadowInset];

  /// 默认的亮色样式
  factory TThemeData.light() => TThemeData(brightness: Brightness.light);

  /// 默认的暗黑样式
  factory TThemeData.dark() => TThemeData(brightness: Brightness.dark);

  TThemeData copyWith({
    Brightness? brightness,
    TColorScheme? colorScheme,
    TComponentSize? size,
    String? fontFamily,
    TButtonThemeData? buttonThemeData,
    TPopupThemeData? popupThemeData,
  }) {
    return TThemeData(
      brightness: brightness ?? this.brightness,
      colorScheme: colorScheme ?? this.colorScheme,
      size: size ?? this.size,
      fontFamily: fontFamily ?? this.fontFamily,
      buttonThemeData: buttonThemeData ?? this.buttonThemeData,
      popupThemeData: popupThemeData ?? this.popupThemeData,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TThemeData &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          colorScheme == other.colorScheme &&
          size == other.size &&
          fontFamily == other.fontFamily &&
          buttonThemeData == other.buttonThemeData &&
          popupThemeData == other.popupThemeData;

  @override
  int get hashCode =>
      brightness.hashCode ^ colorScheme.hashCode ^ size.hashCode ^ fontFamily.hashCode ^ buttonThemeData.hashCode ^ popupThemeData.hashCode;
}
