import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/src/basic/functions.dart';
import 'package:tdesign_desktop_ui/src/theme/theme.dart';

/// 弹出层主题数据
class TPopupThemeData with Diagnosticable {
  const TPopupThemeData();
}

/// 弹出层主题
class TPopupTheme extends InheritedTheme {
  final TPopupThemeData data;

  const TPopupTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

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

/// 触发浮层出现的方式。可选项：hover/click/focus/context-menu
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
