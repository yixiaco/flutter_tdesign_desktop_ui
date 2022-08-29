import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 导航菜单-侧边导航
/// 用于承载网站的架构，并提供跳转的菜单列表。
class TMenu<T> extends StatefulWidget {
  const TMenu({
    Key? key,
    this.collapsed = false,
    this.expandMutex = false,
    this.expandType = TMenuExpandType.normal,
    this.logo,
    this.operations,
    this.theme,
    required this.controller,
    this.width = 232,
    this.foldingWidth,
    this.onChange,
    this.onExpand,
    this.menus = const [],
  }) : super(key: key);

  /// 是否收起菜单
  final bool collapsed;

  /// 同级别互斥展开
  final bool expandMutex;

  /// 二级菜单展开方式，平铺展开和浮层展开。
  final TMenuExpandType expandType;

  /// 站点 LOGO。
  final Widget? logo;

  /// 导航操作区域。
  final Widget? operations;

  /// 菜单风格
  final TMenuTheme? theme;

  /// 选项控制
  final TMenuController<T> controller;

  /// 菜单展开时的宽度
  final double width;

  /// 菜单折叠时的宽度
  final double? foldingWidth;

  /// 激活菜单项发生变化时触发
  final void Function(T value)? onChange;

  /// 展开的菜单项发生变化时触发
  final void Function(List<T> value)? onExpand;

  /// 菜单项
  final List<TMenuProps> menus;

  @override
  State<TMenu<T>> createState() => _TMenuState<T>();
}

class _TMenuState<T> extends State<TMenu<T>> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
