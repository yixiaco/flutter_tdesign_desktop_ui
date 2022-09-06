part of '../../head_menu.dart';

/// 顶部导航菜单布局属性
class _THeadMenuItemLayoutProps<T> {
  /// 父级菜单项
  final _THeadMenuItemLayoutProps<T>? parent;

  /// 菜单控制器
  final TMenuController<T> controller;

  /// 当前菜单项
  final TMenuProps<T> currentProps;

  /// 下标
  final int index;

  /// 同级菜单项
  final List<TMenuProps<T>> menus;

  /// 菜单风格
  final TMenuTheme theme;

  /// 层级
  final int level;

  /// 二级菜单展开方式，平铺展开和浮层展开。
  final TMenuExpandType expandType;

  /// 激活菜单项发生变化时触发
  final void Function(T value)? onChange;

  /// 展开的菜单项发生变化时触发
  final void Function(Set<T> value)? onExpand;

  const _THeadMenuItemLayoutProps({
    this.parent,
    required this.controller,
    required this.currentProps,
    required this.index,
    required this.menus,
    required this.theme,
    required this.level,
    required this.expandType,
    this.onChange,
    this.onExpand,
  });

  _THeadMenuItemLayoutProps<T> copyWith({
    _THeadMenuItemLayoutProps<T>? parent,
    TMenuController<T>? controller,
    TMenuProps<T>? currentProps,
    int? index,
    List<TMenuProps<T>>? menus,
    TMenuTheme? theme,
    int? level,
    TMenuExpandType? expandType,
    void Function(T value)? onChange,
    void Function(Set<T> value)? onExpand,
  }) {
    return _THeadMenuItemLayoutProps<T>(
      parent: parent ?? this.parent,
      controller: controller ?? this.controller,
      currentProps: currentProps ?? this.currentProps,
      index: index ?? this.index,
      menus: menus ?? this.menus,
      theme: theme ?? this.theme,
      level: level ?? this.level,
      expandType: expandType ?? this.expandType,
      onChange: onChange ?? this.onChange,
      onExpand: onExpand ?? this.onExpand,
    );
  }
}
