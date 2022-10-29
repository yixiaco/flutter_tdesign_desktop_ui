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

/// 浮层出现位置
enum TPopupPlacement {
  /// 上
  top,

  /// 左
  left,

  /// 右
  right,

  /// 下
  bottom,

  /// 上左
  topLeft,

  /// 上右
  topRight,

  /// 下左
  bottomLeft,

  /// 下右
  bottomRight,

  /// 左上
  leftTop,

  /// 左下
  leftBottom,

  /// 右上
  rightTop,

  /// 右下
  rightBottom;

  /// 是否是垂直方向
  bool isVertical() {
    switch (this) {
      case TPopupPlacement.top:
        return true;
      case TPopupPlacement.left:
        return false;
      case TPopupPlacement.right:
        return false;
      case TPopupPlacement.bottom:
        return true;
      case TPopupPlacement.topLeft:
        return true;
      case TPopupPlacement.topRight:
        return true;
      case TPopupPlacement.bottomLeft:
        return true;
      case TPopupPlacement.bottomRight:
        return true;
      case TPopupPlacement.leftTop:
        return false;
      case TPopupPlacement.leftBottom:
        return false;
      case TPopupPlacement.rightTop:
        return false;
      case TPopupPlacement.rightBottom:
        return false;
    }
  }

  /// 是否在上方
  bool isTop() {
    switch (this) {
      case TPopupPlacement.top:
        return true;
      case TPopupPlacement.topLeft:
        return true;
      case TPopupPlacement.topRight:
        return true;
      default:
        return false;
    }
  }

  /// 是否在下方
  bool isBottom() {
    switch (this) {
      case TPopupPlacement.bottom:
        return true;
      case TPopupPlacement.bottomLeft:
        return true;
      case TPopupPlacement.bottomRight:
        return true;
      default:
        return false;
    }
  }

  /// 是否在左边
  bool isLeft() {
    switch (this) {
      case TPopupPlacement.left:
        return true;
      case TPopupPlacement.leftTop:
        return true;
      case TPopupPlacement.leftBottom:
        return true;
      default:
        return false;
    }
  }

  /// 是否在右边
  bool isRight() {
    switch (this) {
      case TPopupPlacement.right:
        return true;
      case TPopupPlacement.rightTop:
        return true;
      case TPopupPlacement.rightBottom:
        return true;
      default:
        return false;
    }
  }

  /// 取值的快捷方式
  T? valueOf<T>({
    TSupplier<T>? top,
    TSupplier<T>? left,
    TSupplier<T>? right,
    TSupplier<T>? bottom,
    TSupplier<T>? topLeft,
    TSupplier<T>? topRight,
    TSupplier<T>? bottomLeft,
    TSupplier<T>? bottomRight,
    TSupplier<T>? leftTop,
    TSupplier<T>? leftBottom,
    TSupplier<T>? rightTop,
    TSupplier<T>? rightBottom,
  }) {
    switch (this) {
      case TPopupPlacement.top:
        return top?.call();
      case TPopupPlacement.left:
        return left?.call();
      case TPopupPlacement.right:
        return right?.call();
      case TPopupPlacement.bottom:
        return bottom?.call();
      case TPopupPlacement.topLeft:
        return topLeft?.call();
      case TPopupPlacement.topRight:
        return topRight?.call();
      case TPopupPlacement.bottomLeft:
        return bottomLeft?.call();
      case TPopupPlacement.bottomRight:
        return bottomRight?.call();
      case TPopupPlacement.leftTop:
        return leftTop?.call();
      case TPopupPlacement.leftBottom:
        return leftBottom?.call();
      case TPopupPlacement.rightTop:
        return rightTop?.call();
      case TPopupPlacement.rightBottom:
        return rightBottom?.call();
    }
  }

  /// 返回四边值的快捷方法
  T sides<T>({required T top, required T left, required T right, required T bottom}) {
    return valueOf(
      top: () => top,
      topLeft: () => top,
      topRight: () => top,
      bottom: () => bottom,
      bottomLeft: () => bottom,
      bottomRight: () => bottom,
      left: () => left,
      leftTop: () => left,
      leftBottom: () => left,
      right: () => right,
      rightTop: () => right,
      rightBottom: () => right,
    )!;
  }

  /// 取值的快捷方式
  bool isTrue({
    bool top = false,
    bool left = false,
    bool right = false,
    bool bottom = false,
    bool topLeft = false,
    bool topRight = false,
    bool bottomLeft = false,
    bool bottomRight = false,
    bool leftTop = false,
    bool leftBottom = false,
    bool rightTop = false,
    bool rightBottom = false,
  }) {
    return valueOf<bool>(
      top: () => top,
      topLeft: () => topLeft,
      topRight: () => topRight,
      bottom: () => bottom,
      bottomLeft: () => bottomLeft,
      bottomRight: () => bottomRight,
      left: () => left,
      leftTop: () => leftTop,
      leftBottom: () => leftBottom,
      right: () => right,
      rightTop: () => rightTop,
      rightBottom: () => rightBottom,
    )!;
  }
}

/// 触发浮层出现的方式。可选项：hover/click/focus/contextMenu
enum TPopupTrigger {
  /// 悬浮时触发
  hover,

  /// 点击触发
  click,

  /// 获取焦点时触发
  focus,

  /// 右键触发
  contextMenu;

  /// 当前配置是否为true
  bool isTrue({bool hover = false, bool click = false, bool focus = false, bool contextMenu = false}) {
    switch (this) {
      case TPopupTrigger.hover:
        return hover;
      case TPopupTrigger.click:
        return click;
      case TPopupTrigger.focus:
        return focus;
      case TPopupTrigger.contextMenu:
        return contextMenu;
    }
  }
}
