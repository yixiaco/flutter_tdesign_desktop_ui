import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'color.dart';
import 'color_generate.dart';

/// 配色方案
class TColorScheme with Diagnosticable {
  const TColorScheme({
    required this.brandColor,
    required this.warningColor,
    required this.errorColor,
    required this.successColor,
    required this.gray1,
    required this.gray2,
    required this.gray3,
    required this.gray4,
    required this.gray5,
    required this.gray6,
    required this.gray7,
    required this.gray8,
    required this.gray9,
    required this.gray10,
    required this.gray11,
    required this.gray12,
    required this.gray13,
    required this.gray14,
    required this.fontWhite1,
    required this.fontWhite2,
    required this.fontWhite3,
    required this.fontWhite4,
    required this.fontGray1,
    required this.fontGray2,
    required this.fontGray3,
    required this.fontGray4,
    required this.brandColorHover,
    required this.brandColorFocus,
    required this.brandColorActive,
    required this.brandColorDisabled,
    required this.brandColorLight,
    required this.warningColorHover,
    required this.warningColorFocus,
    required this.warningColorActive,
    required this.warningColorDisabled,
    required this.warningColorLight,
    required this.errorColorHover,
    required this.errorColorFocus,
    required this.errorColorActive,
    required this.errorColorDisabled,
    required this.errorColorLight,
    required this.successColorHover,
    required this.successColorFocus,
    required this.successColorActive,
    required this.successColorDisabled,
    required this.successColorLight,
    required this.maskActive,
    required this.maskDisabled,
    required this.bgColorPage,
    required this.bgColorContainer,
    required this.bgColorContainerHover,
    required this.bgColorContainerActive,
    required this.bgColorContainerSelect,
    required this.bgColorSecondaryContainer,
    required this.bgColorSecondaryContainerHover,
    required this.bgColorSecondaryContainerActive,
    required this.bgColorComponent,
    required this.bgColorComponentHover,
    required this.bgColorComponentActive,
    required this.bgColorComponentDisabled,
    required this.bgColorSpecialComponent,
    required this.textColorPrimary,
    required this.textColorSecondary,
    required this.textColorPlaceholder,
    required this.textColorDisabled,
    required this.textColorAnti,
    required this.textColorBrand,
    required this.textColorLink,
    required this.borderLevel1Color,
    required this.componentStroke,
    required this.borderLevel2Color,
    required this.componentBorder,
    required this.shadow1,
    required this.shadow2,
    required this.shadow3,
    required this.shadowInsetTop,
    required this.shadowInsetRight,
    required this.shadowInsetBottom,
    required this.shadowInsetLeft,
    required this.tableShadowColor,
    required this.scrollbarColor,
    required this.scrollbarHoverColor,
    required this.scrollTrackColor,
  });

  /// 品牌色 & 基础颜色
  final MaterialColor brandColor;

  Color get brandColor1 => brandColor.shade50;

  Color get brandColor2 => brandColor.shade100;

  Color get brandColor3 => brandColor.shade200;

  Color get brandColor4 => brandColor.shade300;

  Color get brandColor5 => brandColor.shade400;

  Color get brandColor6 => brandColor.shade500;

  Color get brandColor7 => brandColor.shade600;

  Color get brandColor8 => brandColor.shade700;

  Color get brandColor9 => brandColor.shade800;

  Color get brandColor10 => brandColor.shade900;

  /// 告警色 & 基础颜色
  final MaterialColor warningColor;

  Color get warningColor1 => warningColor.shade50;

  Color get warningColor2 => warningColor.shade100;

  Color get warningColor3 => warningColor.shade200;

  Color get warningColor4 => warningColor.shade300;

  Color get warningColor5 => warningColor.shade400;

  Color get warningColor6 => warningColor.shade500;

  Color get warningColor7 => warningColor.shade600;

  Color get warningColor8 => warningColor.shade700;

  Color get warningColor9 => warningColor.shade800;

  Color get warningColor10 => warningColor.shade900;

  /// 错误色 & 基础颜色
  final MaterialColor errorColor;

  Color get errorColor1 => errorColor.shade50;

  Color get errorColor2 => errorColor.shade100;

  Color get errorColor3 => errorColor.shade200;

  Color get errorColor4 => errorColor.shade300;

  Color get errorColor5 => errorColor.shade400;

  Color get errorColor6 => errorColor.shade500;

  Color get errorColor7 => errorColor.shade600;

  Color get errorColor8 => errorColor.shade700;

  Color get errorColor9 => errorColor.shade800;

  Color get errorColor10 => errorColor.shade900;

  /// 成功色 & 基础颜色
  final MaterialColor successColor;

  Color get successColor1 => successColor.shade50;

  Color get successColor2 => successColor.shade100;

  Color get successColor3 => successColor.shade200;

  Color get successColor4 => successColor.shade300;

  Color get successColor5 => successColor.shade400;

  Color get successColor6 => successColor.shade500;

  Color get successColor7 => successColor.shade600;

  Color get successColor8 => successColor.shade700;

  Color get successColor9 => successColor.shade800;

  Color get successColor10 => successColor.shade900;

  /// 灰色
  final Color gray1;
  final Color gray2;
  final Color gray3;
  final Color gray4;
  final Color gray5;
  final Color gray6;
  final Color gray7;
  final Color gray8;
  final Color gray9;
  final Color gray10;
  final Color gray11;
  final Color gray12;
  final Color gray13;
  final Color gray14;

  /// 文字 & 图标 颜色
  final Color fontWhite1;
  final Color fontWhite2;
  final Color fontWhite3;
  final Color fontWhite4;
  final Color fontGray1;
  final Color fontGray2;
  final Color fontGray3;
  final Color fontGray4;

  /// 基础颜色的扩展 用于 hover / 聚焦 / 禁用 / 点击 等状态
  final Color brandColorHover;
  final Color brandColorFocus;
  final Color brandColorActive;
  final Color brandColorDisabled;
  final Color brandColorLight;

  /// 警告色扩展 用于 hover / 聚焦 / 禁用 / 点击 等状态
  final Color warningColorHover;
  final Color warningColorFocus;
  final Color warningColorActive;
  final Color warningColorDisabled;
  final Color warningColorLight;

  /// 失败/错误色扩展 用于 hover / 聚焦 / 禁用 / 点击 等状态
  final Color errorColorHover;
  final Color errorColorFocus;
  final Color errorColorActive;
  final Color errorColorDisabled;
  final Color errorColorLight;

  /// 成功色扩展 用于 hover / 聚焦 / 禁用 / 点击 等状态
  final Color successColorHover;
  final Color successColorFocus;
  final Color successColorActive;
  final Color successColorDisabled;
  final Color successColorLight;

  //遮罩
  /// 遮罩-弹出
  final Color maskActive;

  /// 遮罩-禁用
  final Color maskDisabled;

  // 背景色
  /// 背景色 色彩 - page
  final Color bgColorPage;

  /// 背景色 色彩 - 容器
  final Color bgColorContainer;

  /// 背景色 色彩 - 容器 - hover
  final Color bgColorContainerHover;

  /// 背景色 色彩 - 容器 - active
  final Color bgColorContainerActive;

  /// 背景色 色彩 - 容器 - select
  final Color bgColorContainerSelect;

  /// 背景色 次级容器
  final Color bgColorSecondaryContainer;

  /// 背景色 次级容器 - hover
  final Color bgColorSecondaryContainerHover;

  /// 背景色 次级容器 - active
  final Color bgColorSecondaryContainerActive;

  /// 背景色 组件
  final Color bgColorComponent;

  /// 背景色 组件 - hover
  final Color bgColorComponentHover;

  /// 背景色 组件 - active
  final Color bgColorComponentActive;

  /// 背景色 组件 - disabled
  final Color bgColorComponentDisabled;

  /// 特殊组件背景色，目前只用于 button、input 组件多主题场景，浅色主题下固定为白色，深色主题下为 transparent 适配背景颜色
  final Color bgColorSpecialComponent;

  // 文本颜色
  /// 文本颜色 色彩-文字-主要
  final Color textColorPrimary;

  /// 文本颜色 色彩-文字-主要
  final Color textColorSecondary;

  /// 文本颜色 色彩-文字-占位符/说明
  final Color textColorPlaceholder;

  /// 文本颜色 色彩-文字-禁用
  final Color textColorDisabled;

  /// 文本颜色 色彩-文字-反色
  final Color textColorAnti;

  /// 文本颜色 色彩-文字-品牌
  final Color textColorBrand;

  /// 文本颜色 色彩-文字-链接
  final Color textColorLink;

  /// 分割线
  final Color borderLevel1Color;
  final Color componentStroke;

  /// 边框
  final Color borderLevel2Color;
  final Color componentBorder;

  /// 基础/下层 投影 hover 使用的组件包括：表格 /
  final List<BoxShadow> shadow1;

  /// 中层投影 下拉 使用的组件包括：下拉菜单 / 气泡确认框 / 选择器 /
  final List<BoxShadow> shadow2;

  /// 上层投影（警示/弹窗）使用的组件包括：全局提示 / 消息通知
  final List<BoxShadow> shadow3;

  /// 内投影 用于弹窗类组件（气泡确认框 / 全局提示 / 消息通知）的内描边
  final BoxShadow shadowInsetTop;
  final BoxShadow shadowInsetRight;
  final BoxShadow shadowInsetBottom;
  final BoxShadow shadowInsetLeft;

  /// table 特定阴影
  final Color tableShadowColor;

  /// 滚动条颜色
  final Color scrollbarColor;

  /// 滚动条悬浮颜色 (hover)
  final Color scrollbarHoverColor;

  /// 滚动条轨道颜色，不能是带透明度，否则纵向滚动时，横向滚动条会穿透
  final Color scrollTrackColor;

  /// 默认亮色模式
  static TColorScheme get light {
    return lightOf(TColors.blue);
  }

  /// 亮色模式-主色
  static TColorScheme lightOf(MaterialColor brandColor) {
    var fontWhite1 = TColors.white;
    const fontWhite2 = Color(0x8CFFFFFF);
    const fontWhite3 = Color(0x59FFFFFF);
    const fontWhite4 = Color(0x38FFFFFF);
    const fontGray1 = Color(0xE5000000);
    const fontGray2 = Color(0x99000000);
    const fontGray3 = Color(0x66000000);
    const fontGray4 = Color(0x42000000);
    return TColorScheme(
      brandColor: brandColor,
      warningColor: TColors.orange,
      errorColor: TColors.red,
      successColor: TColors.green,
      gray1: TColors.gray1,
      gray2: TColors.gray2,
      gray3: TColors.gray3,
      gray4: TColors.gray4,
      gray5: TColors.gray5,
      gray6: TColors.gray6,
      gray7: TColors.gray7,
      gray8: TColors.gray8,
      gray9: TColors.gray9,
      gray10: TColors.gray10,
      gray11: TColors.gray11,
      gray12: TColors.gray12,
      gray13: TColors.gray13,
      gray14: TColors.gray14,
      fontWhite1: fontWhite1,
      fontWhite2: fontWhite2,
      fontWhite3: fontWhite3,
      fontWhite4: fontWhite4,
      fontGray1: fontGray1,
      fontGray2: fontGray2,
      fontGray3: fontGray3,
      fontGray4: fontGray4,
      brandColorHover: brandColor.shade600,
      brandColorFocus: brandColor.shade100,
      brandColorActive: brandColor.shade800,
      brandColorDisabled: brandColor.shade200,
      brandColorLight: brandColor.shade50,
      warningColorHover: TColors.orange.shade300,
      warningColorFocus: TColors.orange.shade100,
      warningColorActive: TColors.orange.shade500,
      warningColorDisabled: TColors.orange.shade200,
      warningColorLight: TColors.orange.shade50,
      errorColorHover: TColors.red.shade400,
      errorColorFocus: TColors.red.shade100,
      errorColorActive: TColors.red.shade500,
      errorColorDisabled: TColors.red.shade200,
      errorColorLight: TColors.red.shade50,
      successColorHover: TColors.green.shade300,
      successColorFocus: TColors.green.shade100,
      successColorActive: TColors.green.shade500,
      successColorDisabled: TColors.green.shade200,
      successColorLight: TColors.green.shade50,
      maskActive: const Color(0x99000000),
      maskDisabled: const Color(0x99FFFFFF),
      bgColorPage: TColors.gray2,
      bgColorContainer: Colors.white,
      bgColorContainerHover: TColors.gray1,
      bgColorContainerActive: TColors.gray3,
      bgColorContainerSelect: Colors.white,
      bgColorSecondaryContainer: TColors.gray1,
      bgColorSecondaryContainerHover: TColors.gray2,
      bgColorSecondaryContainerActive: TColors.gray4,
      bgColorComponent: TColors.gray3,
      bgColorComponentHover: TColors.gray4,
      bgColorComponentActive: TColors.gray6,
      bgColorComponentDisabled: TColors.gray2,
      bgColorSpecialComponent: Colors.white,
      textColorPrimary: fontGray1,
      textColorSecondary: fontGray2,
      textColorPlaceholder: fontGray3,
      textColorDisabled: fontGray4,
      textColorAnti: Colors.white,
      textColorBrand: brandColor.shade700,
      textColorLink: brandColor.shade700,
      borderLevel1Color: TColors.gray3,
      componentStroke: TColors.gray3,
      borderLevel2Color: TColors.gray4,
      componentBorder: TColors.gray4,
      shadow1: [
        const BoxShadow(offset: Offset(0, 1), blurRadius: 10, color: Color(0x0C000000)),
        const BoxShadow(offset: Offset(0, 4), blurRadius: 5, color: Color(0x14000000)),
        const BoxShadow(offset: Offset(0, 4), blurRadius: 4, spreadRadius: -1, color: Color(0x1E000000)),
      ],
      shadow2: [
        const BoxShadow(offset: Offset(0, 3), blurRadius: 14, spreadRadius: 2, color: Color(0x0C000000)),
        const BoxShadow(offset: Offset(0, 8), blurRadius: 10, spreadRadius: 1, color: Color(0x0F000000)),
        const BoxShadow(offset: Offset(0, 5), blurRadius: 5, spreadRadius: -3, color: Color(0x19000000)),
      ],
      shadow3: [
        const BoxShadow(offset: Offset(0, 6), blurRadius: 30, spreadRadius: 5, color: Color(0x0C000000)),
        const BoxShadow(offset: Offset(0, 16), blurRadius: 24, spreadRadius: 2, color: Color(0x0A000000)),
        const BoxShadow(offset: Offset(0, 8), blurRadius: 10, spreadRadius: -5, color: Color(0x14000000)),
      ],
      shadowInsetTop: const BoxShadow(blurStyle: BlurStyle.inner, offset: Offset(0, .5), blurRadius: 0, color: Color(0xFFDCDCDC)),
      shadowInsetRight: const BoxShadow(blurStyle: BlurStyle.inner, offset: Offset(.5, 0), blurRadius: 0, color: Color(0xFFDCDCDC)),
      shadowInsetBottom: const BoxShadow(blurStyle: BlurStyle.inner, offset: Offset(0, -.5), blurRadius: 0, color: Color(0xFFDCDCDC)),
      shadowInsetLeft: const BoxShadow(blurStyle: BlurStyle.inner, offset: Offset(-.5, 0), blurRadius: 0, color: Color(0xFFDCDCDC)),
      tableShadowColor: const Color(0x14000000),
      scrollbarColor: const Color(0x19000000),
      scrollbarHoverColor: const Color(0x4C000000),
      scrollTrackColor: Colors.white,
    );
  }

  /// 默认暗黑模式
  static TColorScheme get dark {
    return darkOf(TColors.blueDark1);
  }

  /// 暗黑模式-主色
  static TColorScheme darkOf(MaterialColor brandColor) {
    const fontWhite1 = Color(0xE5FFFFFF);
    const fontWhite2 = Color(0x8CFFFFFF);
    const fontWhite3 = Color(0x59FFFFFF);
    const fontWhite4 = Color(0x38FFFFFF);
    const fontGray1 = Color(0xE5000000);
    const fontGray2 = Color(0x99000000);
    const fontGray3 = Color(0x66000000);
    const fontGray4 = Color(0x42000000);
    var warningColor = TColors.orangeDark1;
    var errorColor = TColors.redDark1;
    var successColor = TColors.greenDark1;
    return TColorScheme(
      brandColor: brandColor,
      warningColor: warningColor,
      errorColor: errorColor,
      successColor: successColor,
      gray1: TColors.gray1,
      gray2: TColors.gray2,
      gray3: TColors.gray3,
      gray4: TColors.gray4,
      gray5: TColors.gray5,
      gray6: TColors.gray6,
      gray7: TColors.gray7,
      gray8: TColors.gray8,
      gray9: TColors.gray9,
      gray10: TColors.gray10,
      gray11: TColors.gray11,
      gray12: TColors.gray12,
      gray13: TColors.gray13,
      gray14: TColors.gray14,
      fontWhite1: fontWhite1,
      fontWhite2: fontWhite2,
      fontWhite3: fontWhite3,
      fontWhite4: fontWhite4,
      fontGray1: fontGray1,
      fontGray2: fontGray2,
      fontGray3: fontGray3,
      fontGray4: fontGray4,
      brandColorHover: brandColor.shade600,
      brandColorFocus: brandColor.shade100,
      brandColorActive: brandColor.shade800,
      brandColorDisabled: brandColor.shade200,
      brandColorLight: brandColor.shade50,
      warningColorHover: warningColor.shade300,
      warningColorFocus: warningColor.shade100,
      warningColorActive: warningColor.shade500,
      warningColorDisabled: warningColor.shade200,
      warningColorLight: warningColor.shade50,
      errorColorHover: errorColor.shade400,
      errorColorFocus: errorColor.shade100,
      errorColorActive: errorColor.shade500,
      errorColorDisabled: errorColor.shade200,
      errorColorLight: errorColor.shade50,
      successColorHover: successColor.shade300,
      successColorFocus: successColor.shade100,
      successColorActive: successColor.shade500,
      successColorDisabled: successColor.shade200,
      successColorLight: successColor.shade50,
      maskActive: const Color(0x66000000),
      maskDisabled: const Color(0x99000000),
      bgColorPage: TColors.gray14,
      bgColorContainer: TColors.gray13,
      bgColorContainerHover: TColors.gray12,
      bgColorContainerActive: TColors.gray10,
      bgColorContainerSelect: TColors.gray9,
      bgColorSecondaryContainer: TColors.gray12,
      bgColorSecondaryContainerHover: TColors.gray11,
      bgColorSecondaryContainerActive: TColors.gray9,
      bgColorComponent: TColors.gray11,
      bgColorComponentHover: TColors.gray10,
      bgColorComponentActive: TColors.gray9,
      bgColorComponentDisabled: TColors.gray12,
      bgColorSpecialComponent: Colors.transparent,
      textColorPrimary: fontWhite1,
      textColorSecondary: fontWhite2,
      textColorPlaceholder: fontWhite3,
      textColorDisabled: fontWhite4,
      textColorAnti: Colors.white,
      textColorBrand: brandColor.shade700,
      textColorLink: brandColor.shade700,
      borderLevel1Color: TColors.gray11,
      componentStroke: TColors.gray11,
      borderLevel2Color: TColors.gray9,
      componentBorder: TColors.gray9,
      shadow1: [
        const BoxShadow(offset: Offset(0, 4), blurRadius: 6, color: Color(0x0F000000)),
        const BoxShadow(offset: Offset(0, 1), blurRadius: 10, color: Color(0x14000000)),
        const BoxShadow(offset: Offset(0, 2), blurRadius: 4, color: Color(0x1E000000)),
      ],
      shadow2: [
        const BoxShadow(offset: Offset(0, 8), blurRadius: 10, color: Color(0x1E000000)),
        const BoxShadow(offset: Offset(0, 3), blurRadius: 14, color: Color(0x19000000)),
        const BoxShadow(offset: Offset(0, 5), blurRadius: 5, color: Color(0x28000000)),
      ],
      shadow3: [
        const BoxShadow(offset: Offset(0, 16), blurRadius: 24, color: Color(0x23000000)),
        const BoxShadow(offset: Offset(0, 6), blurRadius: 30, color: Color(0x1E000000)),
        const BoxShadow(offset: Offset(0, 8), blurRadius: 10, color: Color(0x33000000)),
      ],
      shadowInsetTop: const BoxShadow(blurStyle: BlurStyle.inner, offset: Offset(0, .5), blurRadius: 0, color: Color(0xFF5E5E5E)),
      shadowInsetRight: const BoxShadow(blurStyle: BlurStyle.inner, offset: Offset(.5, 0), blurRadius: 0, color: Color(0xFF5E5E5E)),
      shadowInsetBottom: const BoxShadow(blurStyle: BlurStyle.inner, offset: Offset(0, -.5), blurRadius: 0, color: Color(0xFF5E5E5E)),
      shadowInsetLeft: const BoxShadow(blurStyle: BlurStyle.inner, offset: Offset(-.5, 0), blurRadius: 0, color: Color(0xFF5E5E5E)),
      tableShadowColor: const Color(0x8C000000),
      scrollbarColor: const Color(0x19FFFFFF),
      scrollbarHoverColor: const Color(0x4CFFFFFF),
      scrollTrackColor: const Color(0xFF333333),
    );
  }

  /// 根据颜色生成主题
  ///
  /// [seedColor] 种子颜色
  /// [light] 是否为浅色模式
  TColorScheme fromSeed(Color seedColor, {Brightness brightness = Brightness.light}) {
    var materialColor = generateMaterialColor(seedColor, light: brightness == Brightness.light);
    if (brightness == Brightness.light) {
      return lightOf(materialColor);
    } else {
      return darkOf(materialColor);
    }
  }

  TColorScheme copyWith({
    MaterialColor? brandColor,
    MaterialColor? warningColor,
    MaterialColor? errorColor,
    MaterialColor? successColor,
    Color? gray1,
    Color? gray2,
    Color? gray3,
    Color? gray4,
    Color? gray5,
    Color? gray6,
    Color? gray7,
    Color? gray8,
    Color? gray9,
    Color? gray10,
    Color? gray11,
    Color? gray12,
    Color? gray13,
    Color? gray14,
    Color? fontWhite1,
    Color? fontWhite2,
    Color? fontWhite3,
    Color? fontWhite4,
    Color? fontGray1,
    Color? fontGray2,
    Color? fontGray3,
    Color? fontGray4,
    Color? brandColorHover,
    Color? brandColorFocus,
    Color? brandColorActive,
    Color? brandColorDisabled,
    Color? brandColorLight,
    Color? warningColorHover,
    Color? warningColorFocus,
    Color? warningColorActive,
    Color? warningColorDisabled,
    Color? warningColorLight,
    Color? errorColorHover,
    Color? errorColorFocus,
    Color? errorColorActive,
    Color? errorColorDisabled,
    Color? errorColorLight,
    Color? successColorHover,
    Color? successColorFocus,
    Color? successColorActive,
    Color? successColorDisabled,
    Color? successColorLight,
    Color? maskActive,
    Color? maskDisabled,
    Color? bgColorPage,
    Color? bgColorContainer,
    Color? bgColorContainerHover,
    Color? bgColorContainerActive,
    Color? bgColorContainerSelect,
    Color? bgColorSecondaryContainer,
    Color? bgColorSecondaryContainerHover,
    Color? bgColorSecondaryContainerActive,
    Color? bgColorComponent,
    Color? bgColorComponentHover,
    Color? bgColorComponentActive,
    Color? bgColorComponentDisabled,
    Color? bgColorSpecialComponent,
    Color? textColorPrimary,
    Color? textColorSecondary,
    Color? textColorPlaceholder,
    Color? textColorDisabled,
    Color? textColorAnti,
    Color? textColorBrand,
    Color? textColorLink,
    Color? borderLevel1Color,
    Color? componentStroke,
    Color? borderLevel2Color,
    Color? componentBorder,
    List<BoxShadow>? shadow1,
    List<BoxShadow>? shadow2,
    List<BoxShadow>? shadow3,
    BoxShadow? shadowInsetTop,
    BoxShadow? shadowInsetRight,
    BoxShadow? shadowInsetBottom,
    BoxShadow? shadowInsetLeft,
    Color? tableShadowColor,
    Color? scrollbarColor,
    Color? scrollbarHoverColor,
    Color? scrollTrackColor,
  }) {
    return TColorScheme(
      brandColor: brandColor ?? this.brandColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      gray1: gray1 ?? this.gray1,
      gray2: gray2 ?? this.gray2,
      gray3: gray3 ?? this.gray3,
      gray4: gray4 ?? this.gray4,
      gray5: gray5 ?? this.gray5,
      gray6: gray6 ?? this.gray6,
      gray7: gray7 ?? this.gray7,
      gray8: gray8 ?? this.gray8,
      gray9: gray9 ?? this.gray9,
      gray10: gray10 ?? this.gray10,
      gray11: gray11 ?? this.gray11,
      gray12: gray12 ?? this.gray12,
      gray13: gray13 ?? this.gray13,
      gray14: gray14 ?? this.gray14,
      fontWhite1: fontWhite1 ?? this.fontWhite1,
      fontWhite2: fontWhite2 ?? this.fontWhite2,
      fontWhite3: fontWhite3 ?? this.fontWhite3,
      fontWhite4: fontWhite4 ?? this.fontWhite4,
      fontGray1: fontGray1 ?? this.fontGray1,
      fontGray2: fontGray2 ?? this.fontGray2,
      fontGray3: fontGray3 ?? this.fontGray3,
      fontGray4: fontGray4 ?? this.fontGray4,
      brandColorHover: brandColorHover ?? this.brandColorHover,
      brandColorFocus: brandColorFocus ?? this.brandColorFocus,
      brandColorActive: brandColorActive ?? this.brandColorActive,
      brandColorDisabled: brandColorDisabled ?? this.brandColorDisabled,
      brandColorLight: brandColorLight ?? this.brandColorLight,
      warningColorHover: warningColorHover ?? this.warningColorHover,
      warningColorFocus: warningColorFocus ?? this.warningColorFocus,
      warningColorActive: warningColorActive ?? this.warningColorActive,
      warningColorDisabled: warningColorDisabled ?? this.warningColorDisabled,
      warningColorLight: warningColorLight ?? this.warningColorLight,
      errorColorHover: errorColorHover ?? this.errorColorHover,
      errorColorFocus: errorColorFocus ?? this.errorColorFocus,
      errorColorActive: errorColorActive ?? this.errorColorActive,
      errorColorDisabled: errorColorDisabled ?? this.errorColorDisabled,
      errorColorLight: errorColorLight ?? this.errorColorLight,
      successColorHover: successColorHover ?? this.successColorHover,
      successColorFocus: successColorFocus ?? this.successColorFocus,
      successColorActive: successColorActive ?? this.successColorActive,
      successColorDisabled: successColorDisabled ?? this.successColorDisabled,
      successColorLight: successColorLight ?? this.successColorLight,
      maskActive: maskActive ?? this.maskActive,
      maskDisabled: maskDisabled ?? this.maskDisabled,
      bgColorPage: bgColorPage ?? this.bgColorPage,
      bgColorContainer: bgColorContainer ?? this.bgColorContainer,
      bgColorContainerHover: bgColorContainerHover ?? this.bgColorContainerHover,
      bgColorContainerActive: bgColorContainerActive ?? this.bgColorContainerActive,
      bgColorContainerSelect: bgColorContainerSelect ?? this.bgColorContainerSelect,
      bgColorSecondaryContainer: bgColorSecondaryContainer ?? this.bgColorSecondaryContainer,
      bgColorSecondaryContainerHover: bgColorSecondaryContainerHover ?? this.bgColorSecondaryContainerHover,
      bgColorSecondaryContainerActive: bgColorSecondaryContainerActive ?? this.bgColorSecondaryContainerActive,
      bgColorComponent: bgColorComponent ?? this.bgColorComponent,
      bgColorComponentHover: bgColorComponentHover ?? this.bgColorComponentHover,
      bgColorComponentActive: bgColorComponentActive ?? this.bgColorComponentActive,
      bgColorComponentDisabled: bgColorComponentDisabled ?? this.bgColorComponentDisabled,
      bgColorSpecialComponent: bgColorSpecialComponent ?? this.bgColorSpecialComponent,
      textColorPrimary: textColorPrimary ?? this.textColorPrimary,
      textColorSecondary: textColorSecondary ?? this.textColorSecondary,
      textColorPlaceholder: textColorPlaceholder ?? this.textColorPlaceholder,
      textColorDisabled: textColorDisabled ?? this.textColorDisabled,
      textColorAnti: textColorAnti ?? this.textColorAnti,
      textColorBrand: textColorBrand ?? this.textColorBrand,
      textColorLink: textColorLink ?? this.textColorLink,
      borderLevel1Color: borderLevel1Color ?? this.borderLevel1Color,
      componentStroke: componentStroke ?? this.componentStroke,
      borderLevel2Color: borderLevel2Color ?? this.borderLevel2Color,
      componentBorder: componentBorder ?? this.componentBorder,
      shadow1: shadow1 ?? this.shadow1,
      shadow2: shadow2 ?? this.shadow2,
      shadow3: shadow3 ?? this.shadow3,
      shadowInsetTop: shadowInsetTop ?? this.shadowInsetTop,
      shadowInsetRight: shadowInsetRight ?? this.shadowInsetRight,
      shadowInsetBottom: shadowInsetBottom ?? this.shadowInsetBottom,
      shadowInsetLeft: shadowInsetLeft ?? this.shadowInsetLeft,
      tableShadowColor: tableShadowColor ?? this.tableShadowColor,
      scrollbarColor: scrollbarColor ?? this.scrollbarColor,
      scrollbarHoverColor: scrollbarHoverColor ?? this.scrollbarHoverColor,
      scrollTrackColor: scrollTrackColor ?? this.scrollTrackColor,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TColorScheme &&
          runtimeType == other.runtimeType &&
          brandColor == other.brandColor &&
          warningColor == other.warningColor &&
          errorColor == other.errorColor &&
          successColor == other.successColor &&
          gray1 == other.gray1 &&
          gray2 == other.gray2 &&
          gray3 == other.gray3 &&
          gray4 == other.gray4 &&
          gray5 == other.gray5 &&
          gray6 == other.gray6 &&
          gray7 == other.gray7 &&
          gray8 == other.gray8 &&
          gray9 == other.gray9 &&
          gray10 == other.gray10 &&
          gray11 == other.gray11 &&
          gray12 == other.gray12 &&
          gray13 == other.gray13 &&
          gray14 == other.gray14 &&
          fontWhite1 == other.fontWhite1 &&
          fontWhite2 == other.fontWhite2 &&
          fontWhite3 == other.fontWhite3 &&
          fontWhite4 == other.fontWhite4 &&
          fontGray1 == other.fontGray1 &&
          fontGray2 == other.fontGray2 &&
          fontGray3 == other.fontGray3 &&
          fontGray4 == other.fontGray4 &&
          brandColorHover == other.brandColorHover &&
          brandColorFocus == other.brandColorFocus &&
          brandColorActive == other.brandColorActive &&
          brandColorDisabled == other.brandColorDisabled &&
          brandColorLight == other.brandColorLight &&
          warningColorHover == other.warningColorHover &&
          warningColorFocus == other.warningColorFocus &&
          warningColorActive == other.warningColorActive &&
          warningColorDisabled == other.warningColorDisabled &&
          warningColorLight == other.warningColorLight &&
          errorColorHover == other.errorColorHover &&
          errorColorFocus == other.errorColorFocus &&
          errorColorActive == other.errorColorActive &&
          errorColorDisabled == other.errorColorDisabled &&
          errorColorLight == other.errorColorLight &&
          successColorHover == other.successColorHover &&
          successColorFocus == other.successColorFocus &&
          successColorActive == other.successColorActive &&
          successColorDisabled == other.successColorDisabled &&
          successColorLight == other.successColorLight &&
          maskActive == other.maskActive &&
          maskDisabled == other.maskDisabled &&
          bgColorPage == other.bgColorPage &&
          bgColorContainer == other.bgColorContainer &&
          bgColorContainerHover == other.bgColorContainerHover &&
          bgColorContainerActive == other.bgColorContainerActive &&
          bgColorContainerSelect == other.bgColorContainerSelect &&
          bgColorSecondaryContainer == other.bgColorSecondaryContainer &&
          bgColorSecondaryContainerHover == other.bgColorSecondaryContainerHover &&
          bgColorSecondaryContainerActive == other.bgColorSecondaryContainerActive &&
          bgColorComponent == other.bgColorComponent &&
          bgColorComponentHover == other.bgColorComponentHover &&
          bgColorComponentActive == other.bgColorComponentActive &&
          bgColorComponentDisabled == other.bgColorComponentDisabled &&
          bgColorSpecialComponent == other.bgColorSpecialComponent &&
          textColorPrimary == other.textColorPrimary &&
          textColorSecondary == other.textColorSecondary &&
          textColorPlaceholder == other.textColorPlaceholder &&
          textColorDisabled == other.textColorDisabled &&
          textColorAnti == other.textColorAnti &&
          textColorBrand == other.textColorBrand &&
          textColorLink == other.textColorLink &&
          borderLevel1Color == other.borderLevel1Color &&
          componentStroke == other.componentStroke &&
          borderLevel2Color == other.borderLevel2Color &&
          componentBorder == other.componentBorder &&
          shadow1 == other.shadow1 &&
          shadow2 == other.shadow2 &&
          shadow3 == other.shadow3 &&
          shadowInsetTop == other.shadowInsetTop &&
          shadowInsetRight == other.shadowInsetRight &&
          shadowInsetBottom == other.shadowInsetBottom &&
          shadowInsetLeft == other.shadowInsetLeft &&
          tableShadowColor == other.tableShadowColor &&
          scrollbarColor == other.scrollbarColor &&
          scrollbarHoverColor == other.scrollbarHoverColor &&
          scrollTrackColor == other.scrollTrackColor;

  @override
  int get hashCode =>
      brandColor.hashCode ^
      warningColor.hashCode ^
      errorColor.hashCode ^
      successColor.hashCode ^
      gray1.hashCode ^
      gray2.hashCode ^
      gray3.hashCode ^
      gray4.hashCode ^
      gray5.hashCode ^
      gray6.hashCode ^
      gray7.hashCode ^
      gray8.hashCode ^
      gray9.hashCode ^
      gray10.hashCode ^
      gray11.hashCode ^
      gray12.hashCode ^
      gray13.hashCode ^
      gray14.hashCode ^
      fontWhite1.hashCode ^
      fontWhite2.hashCode ^
      fontWhite3.hashCode ^
      fontWhite4.hashCode ^
      fontGray1.hashCode ^
      fontGray2.hashCode ^
      fontGray3.hashCode ^
      fontGray4.hashCode ^
      brandColorHover.hashCode ^
      brandColorFocus.hashCode ^
      brandColorActive.hashCode ^
      brandColorDisabled.hashCode ^
      brandColorLight.hashCode ^
      warningColorHover.hashCode ^
      warningColorFocus.hashCode ^
      warningColorActive.hashCode ^
      warningColorDisabled.hashCode ^
      warningColorLight.hashCode ^
      errorColorHover.hashCode ^
      errorColorFocus.hashCode ^
      errorColorActive.hashCode ^
      errorColorDisabled.hashCode ^
      errorColorLight.hashCode ^
      successColorHover.hashCode ^
      successColorFocus.hashCode ^
      successColorActive.hashCode ^
      successColorDisabled.hashCode ^
      successColorLight.hashCode ^
      maskActive.hashCode ^
      maskDisabled.hashCode ^
      bgColorPage.hashCode ^
      bgColorContainer.hashCode ^
      bgColorContainerHover.hashCode ^
      bgColorContainerActive.hashCode ^
      bgColorContainerSelect.hashCode ^
      bgColorSecondaryContainer.hashCode ^
      bgColorSecondaryContainerHover.hashCode ^
      bgColorSecondaryContainerActive.hashCode ^
      bgColorComponent.hashCode ^
      bgColorComponentHover.hashCode ^
      bgColorComponentActive.hashCode ^
      bgColorComponentDisabled.hashCode ^
      bgColorSpecialComponent.hashCode ^
      textColorPrimary.hashCode ^
      textColorSecondary.hashCode ^
      textColorPlaceholder.hashCode ^
      textColorDisabled.hashCode ^
      textColorAnti.hashCode ^
      textColorBrand.hashCode ^
      textColorLink.hashCode ^
      borderLevel1Color.hashCode ^
      componentStroke.hashCode ^
      borderLevel2Color.hashCode ^
      componentBorder.hashCode ^
      shadow1.hashCode ^
      shadow2.hashCode ^
      shadow3.hashCode ^
      shadowInsetTop.hashCode ^
      shadowInsetRight.hashCode ^
      shadowInsetBottom.hashCode ^
      shadowInsetLeft.hashCode ^
      tableShadowColor.hashCode ^
      scrollbarColor.hashCode ^
      scrollbarHoverColor.hashCode ^
      scrollTrackColor.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<MaterialColor>('brandColor', brandColor, defaultValue: null));
    properties.add(DiagnosticsProperty<MaterialColor>('warningColor', warningColor, defaultValue: null));
    properties.add(DiagnosticsProperty<MaterialColor>('errorColor', errorColor, defaultValue: null));
    properties.add(DiagnosticsProperty<MaterialColor>('successColor', successColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray1', gray1, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray2', gray2, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray3', gray3, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray4', gray4, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray5', gray5, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray6', gray6, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray7', gray7, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray8', gray8, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray9', gray9, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray10', gray10, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray11', gray11, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray12', gray12, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray13', gray13, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('gray14', gray14, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('fontWhite1', fontWhite1, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('fontWhite2', fontWhite2, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('fontWhite3', fontWhite3, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('fontWhite4', fontWhite4, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('fontGray1', fontGray1, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('fontGray2', fontGray2, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('fontGray3', fontGray3, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('fontGray4', fontGray4, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('brandColorHover', brandColorHover, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('brandColorFocus', brandColorFocus, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('brandColorActive', brandColorActive, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('brandColorDisabled', brandColorDisabled, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('brandColorLight', brandColorLight, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('warningColorHover', warningColorHover, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('warningColorFocus', warningColorFocus, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('warningColorActive', warningColorActive, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('warningColorDisabled', warningColorDisabled, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('warningColorLight', warningColorLight, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('errorColorHover', errorColorHover, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('errorColorFocus', errorColorFocus, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('errorColorActive', errorColorActive, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('errorColorDisabled', errorColorDisabled, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('errorColorLight', errorColorLight, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('successColorHover', successColorHover, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('successColorFocus', successColorFocus, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('successColorActive', successColorActive, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('successColorDisabled', successColorDisabled, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('successColorLight', successColorLight, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('maskActive', maskActive, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('maskDisabled', maskDisabled, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorPage', bgColorPage, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorContainer', bgColorContainer, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorContainerHover', bgColorContainerHover, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorContainerActive', bgColorContainerActive, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorContainerSelect', bgColorContainerSelect, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorSecondaryContainer', bgColorSecondaryContainer, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorSecondaryContainerHover', bgColorSecondaryContainerHover, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorSecondaryContainerActive', bgColorSecondaryContainerActive, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorComponent', bgColorComponent, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorComponentHover', bgColorComponentHover, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorComponentActive', bgColorComponentActive, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorComponentDisabled', bgColorComponentDisabled, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('bgColorSpecialComponent', bgColorSpecialComponent, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('textColorPrimary', textColorPrimary, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('textColorSecondary', textColorSecondary, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('textColorPlaceholder', textColorPlaceholder, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('textColorDisabled', textColorDisabled, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('textColorAnti', textColorAnti, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('textColorBrand', textColorBrand, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('textColorLink', textColorLink, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('borderLevel1Color', borderLevel1Color, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('componentStroke', componentStroke, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('borderLevel2Color', borderLevel2Color, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('componentBorder', componentBorder, defaultValue: null));
    properties.add(DiagnosticsProperty<List<BoxShadow>>('shadow1', shadow1, defaultValue: null));
    properties.add(DiagnosticsProperty<List<BoxShadow>>('shadow1', shadow2, defaultValue: null));
    properties.add(DiagnosticsProperty<List<BoxShadow>>('shadow1', shadow3, defaultValue: null));
    properties.add(DiagnosticsProperty<BoxShadow>('shadowInsetTop', shadowInsetTop, defaultValue: null));
    properties.add(DiagnosticsProperty<BoxShadow>('shadowInsetRight', shadowInsetRight, defaultValue: null));
    properties.add(DiagnosticsProperty<BoxShadow>('shadowInsetBottom', shadowInsetBottom, defaultValue: null));
    properties.add(DiagnosticsProperty<BoxShadow>('shadowInsetLeft', shadowInsetLeft, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('tableShadowColor', tableShadowColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('scrollbarColor', scrollbarColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('scrollbarHoverColor', scrollbarHoverColor, defaultValue: null));
    properties.add(DiagnosticsProperty<Color>('scrollTrackColor', scrollTrackColor, defaultValue: null));
  }
}
