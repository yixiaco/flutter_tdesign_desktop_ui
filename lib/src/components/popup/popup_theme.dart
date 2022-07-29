import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
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
    T? top,
    T? left,
    T? right,
    T? bottom,
    T? topLeft,
    T? topRight,
    T? bottomLeft,
    T? bottomRight,
    T? leftTop,
    T? leftBottom,
    T? rightTop,
    T? rightBottom,
  }) {
    switch (this) {
      case TPopupPlacement.top:
        return top;
      case TPopupPlacement.left:
        return left;
      case TPopupPlacement.right:
        return right;
      case TPopupPlacement.bottom:
        return bottom;
      case TPopupPlacement.topLeft:
        return topLeft;
      case TPopupPlacement.topRight:
        return topRight;
      case TPopupPlacement.bottomLeft:
        return bottomLeft;
      case TPopupPlacement.bottomRight:
        return bottomRight;
      case TPopupPlacement.leftTop:
        return leftTop;
      case TPopupPlacement.leftBottom:
        return leftBottom;
      case TPopupPlacement.rightTop:
        return rightTop;
      case TPopupPlacement.rightBottom:
        return rightBottom;
    }
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
      top: top,
      topLeft: topLeft,
      topRight: topRight,
      bottom: bottom,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
      left: left,
      leftTop: leftTop,
      leftBottom: leftBottom,
      right: right,
      rightTop: rightTop,
      rightBottom: rightBottom,
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
