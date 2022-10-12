import 'package:flutter/widgets.dart';

/// 二级菜单展开方式
enum TMenuExpandType {
  /// 平铺展开
  normal,

  /// 浮层展开
  popup;
}

/// 菜单风格
enum TMenuTheme {
  /// 亮
  light,

  /// 暗
  dark;

  /// 是否是亮色主题
  bool get isLight => this == TMenuTheme.light;
}

/// 菜单属性抽象对象
abstract class TMenuProps<T> {
  const TMenuProps();
}

/// 二级菜单
class TSubMenuProps<T> extends TMenuProps<T> {
  const TSubMenuProps({
    this.children = const [],
    this.disabled = false,
    this.icon,
    this.title,
    required this.value,
  });

  /// 子菜单
  final List<TMenuProps<T>> children;

  /// 是否禁用菜单项展开/收起/跳转等功能
  final bool disabled;

  /// 菜单项图标。
  final Widget? icon;

  /// 二级菜单内容
  final Widget? title;

  /// 菜单项唯一标识
  final T value;
}

/// 菜单项
class TMenuItemProps<T> extends TMenuProps<T> {
  const TMenuItemProps({
    this.content,
    this.disabled = false,
    this.icon,
    required this.value,
    this.onClick,
  });

  /// 菜单项内容
  final Widget? content;

  /// 是否禁用菜单项展开/收起/跳转等功能
  final bool disabled;

  /// 图标。
  final Widget? icon;

  /// 菜单项唯一标识
  final T value;

  /// 点击时触发
  final GestureTapCallback? onClick;
}

class TMenuGroupProps<T> extends TMenuProps<T> {
  const TMenuGroupProps({
    required this.title,
    this.children = const [],
  });

  /// 菜单组标题。
  final Widget title;

  /// 子菜单
  final List<TMenuProps<T>> children;
}
