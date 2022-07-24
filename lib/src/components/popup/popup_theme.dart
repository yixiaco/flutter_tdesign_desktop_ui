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
