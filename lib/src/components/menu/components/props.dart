part of '../menu.dart';

/// 布局属性
class _TMenuItemLayoutProps<T> {
  /// 菜单控制器
  final TMenuController<T> controller;

  /// 是否收起菜单
  final bool collapsed;

  /// 菜单项
  final TMenuProps<T> menuProps;

  /// 下标
  final int index;

  /// 菜单项
  final List<TMenuProps<T>> menus;

  /// 菜单风格
  final TMenuTheme theme;

  /// 层级
  final int level;

  const _TMenuItemLayoutProps({
    required this.controller,
    required this.collapsed,
    required this.menuProps,
    required this.index,
    required this.menus,
    required this.theme,
    required this.level,
  });

  _TMenuItemLayoutProps<T> copyWith({
    TMenuController<T>? controller,
    bool? collapsed,
    TMenuProps<T>? menuProps,
    int? index,
    List<TMenuProps<T>>? menus,
    TMenuTheme? theme,
    int? level,
  }) {
    return _TMenuItemLayoutProps<T>(
      controller: controller ?? this.controller,
      collapsed: collapsed ?? this.collapsed,
      menuProps: menuProps ?? this.menuProps,
      index: index ?? this.index,
      menus: menus ?? this.menus,
      theme: theme ?? this.theme,
      level: level ?? this.level,
    );
  }
}
