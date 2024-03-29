part of '../../menu.dart';

/// 布局属性
class _TMenuItemLayoutProps<T> {
  /// 父级菜单项
  final _TMenuItemLayoutProps<T>? parent;

  /// 菜单控制器
  final TMenuController<T> controller;

  /// 是否收起菜单
  final bool collapsed;

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

  /// 同级别互斥展开
  final bool expandMutex;

  /// 二级菜单展开方式，平铺展开和浮层展开。
  final TMenuExpandType expandType;

  /// 菜单展开时的宽度
  final double width;

  /// 菜单折叠时的宽度
  final double foldingWidth;

  /// 激活菜单项发生变化时触发
  final void Function(T value)? onChange;

  /// 展开的菜单项发生变化时触发
  final void Function(Set<T> value)? onExpand;

  const _TMenuItemLayoutProps({
    this.parent,
    required this.controller,
    required this.collapsed,
    required this.currentProps,
    required this.index,
    required this.menus,
    required this.theme,
    required this.level,
    required this.expandMutex,
    required this.expandType,
    required this.width,
    required this.foldingWidth,
    this.onChange,
    this.onExpand,
  });

  _TMenuItemLayoutProps<T> copyWith({
    _TMenuItemLayoutProps<T>? parent,
    TMenuController<T>? controller,
    bool? collapsed,
    TMenuProps<T>? currentProps,
    int? index,
    List<TMenuProps<T>>? menus,
    TMenuTheme? theme,
    int? level,
    bool? expandMutex,
    TMenuExpandType? expandType,
    double? width,
    double? foldingWidth,
    void Function(T value)? onChange,
    void Function(Set<T> value)? onExpand,
  }) {
    return _TMenuItemLayoutProps<T>(
      parent: parent ?? this.parent,
      controller: controller ?? this.controller,
      collapsed: collapsed ?? this.collapsed,
      currentProps: currentProps ?? this.currentProps,
      index: index ?? this.index,
      menus: menus ?? this.menus,
      theme: theme ?? this.theme,
      level: level ?? this.level,
      expandMutex: expandMutex ?? this.expandMutex,
      expandType: expandType ?? this.expandType,
      width: width ?? this.width,
      foldingWidth: foldingWidth ?? this.foldingWidth,
      onChange: onChange ?? this.onChange,
      onExpand: onExpand ?? this.onExpand,
    );
  }
}
