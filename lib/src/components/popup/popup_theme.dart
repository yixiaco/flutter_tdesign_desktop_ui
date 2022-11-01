import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层主题数据
class TPopupThemeData with Diagnosticable {
  const TPopupThemeData({
    this.style,
  });

  /// 浮层样式
  final TPopupStyle? style;

  TPopupThemeData copyWith({
    TPopupStyle? style,
  }) {
    return TPopupThemeData(
      style: style ?? this.style,
    );
  }

  @override
  bool operator ==(Object other) => identical(this, other) || other is TPopupThemeData && runtimeType == other.runtimeType && style == other.style;

  @override
  int get hashCode => style.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TPopupStyle>('style', style, defaultValue: null));
  }
}

/// 弹出层主题
class TPopupTheme extends InheritedTheme {
  final TPopupThemeData data;

  const TPopupTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// 来自封闭给定上下文的最近主题实例的数据
  static TPopupThemeData of(BuildContext context) {
    final TPopupTheme? theme = context.dependOnInheritedWidgetOfExactType<TPopupTheme>();
    return theme?.data ?? TTheme.of(context).popupThemeData;
  }

  @override
  bool updateShouldNotify(TPopupTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TPopupTheme(data: data, child: child);
  }
}

/// 浮层样式
class TPopupStyle {
  const TPopupStyle({
    this.backgroundColor,
    this.padding,
    this.margin,
    this.radius,
    this.border,
    this.width,
    this.height,
    this.constraints,
    this.transform,
    this.transformAlignment,
    this.followBoxWidth,
    this.shadows,
  });

  /// 浮层背景色
  final Color? backgroundColor;

  /// 浮层padding
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 边框圆角
  final BorderRadius? radius;

  /// 边框
  final BubbleBoxBorder? border;

  /// 浮层宽度
  final double? width;

  /// 浮层高度
  final double? height;

  /// 应用于子程序的附加约束。构造函数的' width '和' height '参数与' constraints '参数结合在一起来设置这个属性。
  /// [padding]在约束内。
  final BoxConstraints? constraints;

  /// 在绘制容器之前应用的变换矩阵。
  final Matrix4? transform;

  /// 如果指定了[transform]，则原点相对于容器大小的对齐方式。当[transform]为空时，该属性的值将被忽略。
  /// 参见:[Transform.alignment]，它由此属性设置。
  final AlignmentGeometry? transformAlignment;

  /// 最小宽度跟随组件大小
  final bool? followBoxWidth;

  /// 覆盖默认阴影
  final List<BoxShadow>? shadows;

  TPopupStyle copyWith({
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BorderRadius? radius,
    BubbleBoxBorder? border,
    double? width,
    double? height,
    BoxConstraints? constraints,
    Matrix4? transform,
    AlignmentGeometry? transformAlignment,
    bool? followBoxWidth,
    List<BoxShadow>? shadows,
  }) {
    return TPopupStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      radius: radius ?? this.radius,
      border: border ?? this.border,
      width: width ?? this.width,
      height: height ?? this.height,
      constraints: constraints ?? this.constraints,
      transform: transform ?? this.transform,
      transformAlignment: transformAlignment ?? this.transformAlignment,
      followBoxWidth: followBoxWidth ?? this.followBoxWidth,
      shadows: shadows ?? this.shadows,
    );
  }

  TPopupStyle merge([TPopupStyle? style]) {
    return TPopupStyle(
      backgroundColor: backgroundColor ?? style?.backgroundColor,
      padding: padding ?? style?.padding,
      margin: margin ?? style?.margin,
      radius: radius ?? style?.radius,
      border: border ?? style?.border,
      width: width ?? style?.width,
      height: height ?? style?.height,
      constraints: constraints ?? style?.constraints,
      transform: transform ?? style?.transform,
      transformAlignment: transformAlignment ?? style?.transformAlignment,
      followBoxWidth: followBoxWidth ?? style?.followBoxWidth,
      shadows: shadows ?? style?.shadows,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TPopupStyle &&
          runtimeType == other.runtimeType &&
          backgroundColor == other.backgroundColor &&
          padding == other.padding &&
          margin == other.margin &&
          radius == other.radius &&
          border == other.border &&
          width == other.width &&
          height == other.height &&
          constraints == other.constraints &&
          transform == other.transform &&
          transformAlignment == other.transformAlignment &&
          followBoxWidth == other.followBoxWidth &&
          shadows == other.shadows;

  @override
  int get hashCode =>
      backgroundColor.hashCode ^
      padding.hashCode ^
      margin.hashCode ^
      radius.hashCode ^
      border.hashCode ^
      width.hashCode ^
      height.hashCode ^
      constraints.hashCode ^
      transform.hashCode ^
      transformAlignment.hashCode ^
      followBoxWidth.hashCode ^
      shadows.hashCode;
}
