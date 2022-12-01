import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/src/basic/functions.dart';

class TPopupVisible extends ValueNotifier<bool> {
  TPopupVisible([super.value = false]);
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
  contextMenu,

  /// 由子组件通知是否触发浮层的打开或关闭事件
  notifier,

  /// 完全由[TPopupVisible]控制浮层的显示与关闭
  none;

  /// 当前配置是否为true
  bool isTrue({
    bool hover = false,
    bool click = false,
    bool focus = false,
    bool contextMenu = false,
    bool notifier = false,
    bool none = false,
  }) {
    switch (this) {
      case TPopupTrigger.hover:
        return hover;
      case TPopupTrigger.click:
        return click;
      case TPopupTrigger.focus:
        return focus;
      case TPopupTrigger.contextMenu:
        return contextMenu;
      case TPopupTrigger.notifier:
        return notifier;
      case TPopupTrigger.none:
        return none;
    }
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

/// 浮层事件通知,由子组件向父元素通知打开或关闭浮层
class TPopupNotification extends Notification {
  const TPopupNotification();
}

const popupNotification = TPopupNotification();
