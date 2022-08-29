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
}

/// 菜单属性抽象对象
abstract class TMenuProps {
  const TMenuProps();
}

/// 二级菜单
class TSubMenuProps<T> extends TMenuProps {
  const TSubMenuProps({
    this.children = const [],
    this.content,
    this.disabled = false,
    this.icon,
    this.title,
    required this.value,
  });

  /// 子菜单
  final List<TMenuProps> children;

  /// 菜单项内容
  final Widget? content;

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
class TMenuItemProps<T> extends TMenuProps {
  const TMenuItemProps({
    this.content,
    this.disabled = false,
    this.href,
    this.icon,
    this.replace = false,
    this.router,
    this.target,
    this.to,
    required this.value,
    this.onClick,
  });

  /// 菜单项内容
  final Widget? content;

  /// 是否禁用菜单项展开/收起/跳转等功能
  final bool disabled;

  /// 跳转链接
  final String? href;

  /// 图标。
  final Widget? icon;

  /// 路由跳转是否采用覆盖的方式
  final bool replace;

  /// 路由对象。如果项目存在 Router，则默认使用 Router。
  final Route? router;

  /// 链接或路由跳转方式。可选项：_blank/_self/_parent/_top
  final String? target;

  /// 路由跳转目标，当且仅当 Router 存在时，该 API 有效。
  final String? to;

  /// 菜单项唯一标识
  final T value;

  /// 点击时触发
  final GestureTapCallback? onClick;
}

class TMenuGroupProps extends TMenuProps {
  const TMenuGroupProps({
    required this.title,
    this.children = const [],
  });

  /// 菜单组标题。
  final Widget title;

  /// 子菜单
  final List<TMenuProps> children;
}
