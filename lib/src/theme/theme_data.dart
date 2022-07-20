import 'dart:ui';

import 'package:flutter/foundation.dart';
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
    TButtonThemeData? buttonThemeData,
    String? fontFamily,
  }) {
    return TThemeData.raw(
      brightness: brightness,
      buttonThemeData: buttonThemeData ?? const TButtonThemeData(),
      colorScheme: colorScheme ?? (brightness == Brightness.light ? TColorScheme.light : TColorScheme.dark),
      size: size ?? TComponentSize.medium,
      fontFamily: fontFamily ?? 'PingFang SC, Microsoft YaHei, Arial Regular',
    );
  }

  TThemeData.raw({
    required this.brightness,
    required this.colorScheme,
    required this.size,
    required this.buttonThemeData,
    required this.fontFamily,
  });

  /// 描述主题或调色板的对比度。
  final Brightness brightness;

  /// 配色方案
  final TColorScheme colorScheme;

  /// 组件尺寸,默认medium。可选项：small/medium/large
  final TComponentSize size;

  /// 按钮主题数据
  final TButtonThemeData buttonThemeData;

  /// 字体
  final String fontFamily;

  /// 默认的亮色样式
  factory TThemeData.light() => TThemeData(brightness: Brightness.light);

  /// 默认的暗黑样式
  factory TThemeData.dark() => TThemeData(brightness: Brightness.dark);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TThemeData &&
          runtimeType == other.runtimeType &&
          brightness == other.brightness &&
          colorScheme == other.colorScheme &&
          size == other.size &&
          buttonThemeData == other.buttonThemeData);

  @override
  int get hashCode => brightness.hashCode ^ colorScheme.hashCode ^ size.hashCode ^ buttonThemeData.hashCode;

  TThemeData copyWith({
    Brightness? brightness,
    TColorScheme? colorScheme,
    TComponentSize? size,
    TButtonThemeData? buttonThemeData,
  }) {
    return TThemeData(
      brightness: brightness ?? this.brightness,
      colorScheme: colorScheme ?? this.colorScheme,
      size: size ?? this.size,
      buttonThemeData: buttonThemeData ?? this.buttonThemeData,
    );
  }
}
