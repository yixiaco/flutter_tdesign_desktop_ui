import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 主题常量
class TVar {
  const TVar._();

  // Border Radius
  static double borderRadiusSmall = 2; // 圆角-2
  static double borderRadiusDefault = 3; // 圆角-3
  static double borderRadiusMedium = 6; // 圆角-6
  static double borderRadiusLarge = 9; // 圆角-9
  static double borderRadiusExtraLarge = 12; // 圆角-12
  static double borderRadiusRound = 999; // 圆角-999

  // Spacer
  static double spacer = 8;
  static double spacerS = spacer * .5; // 间距-4
  static double spacerM = spacer * .75; // 间距-6
  static double spacerL = spacer * 1.5; // 间距-12
  static double spacer1 = spacer; // 间距-8
  static double spacer2 = spacer * 2; // 间距-16
  static double spacer3 = spacer * 3; // 间距-24
  static double spacer4 = spacer * 4; // 间距-32
  static double spacer5 = spacer * 5; // 间距-大-40
  static double spacer6 = spacer * 6; // 间距-大-48
  static double spacer7 = spacer * 7; // 间距-大-48
  static double spacer8 = spacer * 8; // 间距-大-48
  static double spacer9 = spacer * 9; // 间距-大-48
  static double spacer10 = spacer * 10; // 间距-大-80

  // 动画
  static Curve animTimeFnEasing = const Cubic(.38, 0, .24, 1);
  static Curve animTimeFnEaseOut = const Cubic(0, 0, .15, 1);
  static Curve animTimeFnEaseIn = const Cubic(.82, 0, 1, .9);
  static Duration animDurationBase = const Duration(milliseconds: 200);
  static Duration animDurationModerate = const Duration(milliseconds: 240);
  static Duration animDurationSlow = const Duration(milliseconds: 280);
}

/// 颜色主题数据
class TThemeData with Diagnosticable {
  factory TThemeData({
    required Brightness brightness,
    TColorScheme? colorScheme,
    TComponentSize? size,
    TextDirection? textDirection,
    String? fontFamily,
    TFontData? fontData,
    TButtonThemeData? buttonThemeData,
    TCheckboxThemeData? checkboxThemeData,
    TInputThemeData? inputThemeData,
    TPopupThemeData? popupThemeData,
    TMenuThemeData? menuThemeData,
  }) {
    var family = fontFamily ?? 'Microsoft YaHei';
    return TThemeData.raw(
      brightness: brightness,
      colorScheme: colorScheme ?? (brightness == Brightness.light ? TColorScheme.light : TColorScheme.dark),
      size: size ?? TComponentSize.medium,
      textDirection: textDirection ?? TextDirection.ltr,
      fontFamily: family,
      fontData: fontData ?? TFontData.defaultFontData(family),
      buttonThemeData: buttonThemeData ?? const TButtonThemeData(),
      checkboxThemeData: checkboxThemeData ?? const TCheckboxThemeData(),
      inputThemeData: inputThemeData ?? const TInputThemeData(),
      popupThemeData: popupThemeData ?? const TPopupThemeData(),
      menuThemeData: menuThemeData ?? const TMenuThemeData(),
    );
  }

  TThemeData.raw({
    required this.brightness,
    required this.colorScheme,
    required this.size,
    required this.textDirection,
    required this.fontFamily,
    required this.fontData,
    required this.buttonThemeData,
    required this.checkboxThemeData,
    required this.inputThemeData,
    required this.popupThemeData,
    required this.menuThemeData,
  });

  /// 描述主题或调色板的对比度。
  final Brightness brightness;

  /// 配色方案
  final TColorScheme colorScheme;

  /// 组件尺寸,默认medium。可选项：small/medium/large
  final TComponentSize size;

  /// 文本方向
  final TextDirection textDirection;

  /// 字体
  final String fontFamily;

  /// 字体相关
  final TFontData fontData;

  /// 按钮主题数据
  final TButtonThemeData buttonThemeData;

  /// 复选框主题数据
  final TCheckboxThemeData checkboxThemeData;

  /// 输入框主题数据
  final TInputThemeData inputThemeData;

  /// 弹出层主题数据
  final TPopupThemeData popupThemeData;

  /// 导航菜单主题数据
  final TMenuThemeData menuThemeData;

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

  /// 通用字体大小
  double get fontSize => size.lazySizeOf(
        small: () => fontData.fontSizeS,
        medium: () => fontData.fontSizeBase,
        large: () => fontData.fontSizeL,
      );

  /// 是否是亮色主题
  bool get isLight => brightness == Brightness.light;

  TThemeData copyWith({
    Brightness? brightness,
    TColorScheme? colorScheme,
    TComponentSize? size,
    TextDirection? textDirection,
    String? fontFamily,
    TButtonThemeData? buttonThemeData,
    TCheckboxThemeData? checkboxThemeData,
    TInputThemeData? inputThemeData,
    TPopupThemeData? popupThemeData,
    TMenuThemeData? menuThemeData,
  }) {
    return TThemeData(
      brightness: brightness ?? this.brightness,
      colorScheme: colorScheme ?? this.colorScheme,
      size: size ?? this.size,
      textDirection: textDirection ?? this.textDirection,
      fontFamily: fontFamily ?? this.fontFamily,
      buttonThemeData: buttonThemeData ?? this.buttonThemeData,
      checkboxThemeData: checkboxThemeData ?? this.checkboxThemeData,
      inputThemeData: inputThemeData ?? this.inputThemeData,
      popupThemeData: popupThemeData ?? this.popupThemeData,
      menuThemeData: menuThemeData ?? this.menuThemeData,
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
          textDirection == other.textDirection &&
          fontFamily == other.fontFamily &&
          buttonThemeData == other.buttonThemeData &&
          checkboxThemeData == other.checkboxThemeData &&
          inputThemeData == other.inputThemeData &&
          popupThemeData == other.popupThemeData &&
          menuThemeData == other.menuThemeData;

  @override
  int get hashCode =>
      brightness.hashCode ^
      colorScheme.hashCode ^
      size.hashCode ^
      textDirection.hashCode ^
      fontFamily.hashCode ^
      buttonThemeData.hashCode ^
      checkboxThemeData.hashCode ^
      inputThemeData.hashCode ^
      popupThemeData.hashCode ^
      menuThemeData.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Brightness>('brightness', brightness, defaultValue: null));
    properties.add(DiagnosticsProperty<TColorScheme>('colorScheme', colorScheme, defaultValue: null));
    properties.add(DiagnosticsProperty<TComponentSize>('size', size, defaultValue: null));
    properties.add(DiagnosticsProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(DiagnosticsProperty<String>('fontFamily', fontFamily, defaultValue: null));
    properties.add(DiagnosticsProperty<TFontData>('fontData', fontData, defaultValue: null));
    properties.add(DiagnosticsProperty<TButtonThemeData>('buttonThemeData', buttonThemeData, defaultValue: null));
    properties.add(DiagnosticsProperty<TCheckboxThemeData>('checkboxThemeData', checkboxThemeData, defaultValue: null));
    properties.add(DiagnosticsProperty<TInputThemeData>('inputThemeData', inputThemeData, defaultValue: null));
    properties.add(DiagnosticsProperty<TPopupThemeData>('popupThemeData', popupThemeData, defaultValue: null));
    properties.add(DiagnosticsProperty<TMenuThemeData>('menuThemeData', menuThemeData, defaultValue: null));
  }
}
