import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

const double _kMenuWidth = 232;
const double _kMenuFoldingWidth = 64;

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
    this.foldingWidth = 64,
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
  final double? width;

  /// 菜单折叠时的宽度
  final double? foldingWidth;

  /// 激活菜单项发生变化时触发
  final void Function(T value)? onChange;

  /// 展开的菜单项发生变化时触发
  final void Function(List<T> value)? onExpand;

  /// 菜单项
  final List<TMenuProps<T>> menus;

  @override
  State<TMenu<T>> createState() => _TMenuState<T>();
}

class _TMenuState<T> extends State<TMenu<T>> {
  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var menuTheme = widget.theme ?? (theme.isLight ? TMenuTheme.light : TMenuTheme.dark);

    List<Widget> children = List.generate(widget.menus.length, (index) {
      var menu = widget.menus[index];
      return _TMenuButton(
        menuProps: menu,
        index: index,
        menus: widget.menus,
      );
    });

    return DefaultTextStyle.merge(
      style: theme.fontData.fontBodyMedium.merge(TextStyle(
        overflow: TextOverflow.ellipsis,
        color: menuTheme.isLight ? colorScheme.fontGray2 : colorScheme.fontWhite2,
      )),
      child: Container(
        color: menuTheme.isLight ? Colors.white : colorScheme.gray13,
        width: widget.collapsed ? widget.foldingWidth ?? _kMenuFoldingWidth : widget.width ?? _kMenuWidth,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: AnimatedSize(
          duration: TVar.animDurationSlow,
          curve: const Cubic(.645, .045, .355, 1),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    );
  }
}

class _TMenuButton<T> extends StatelessWidget {
  const _TMenuButton({
    Key? key,
    required this.menuProps,
    required this.index,
    required this.menus,
  }) : super(key: key);

  /// 菜单项
  final TMenuProps<T> menuProps;

  /// 下标
  final int index;

  /// 菜单项
  final List<TMenuProps<T>> menus;

  @override
  Widget build(BuildContext context) {
    if (menuProps is TMenuItemProps) {
      return _TMenuItemButton(
        menuProps: menuProps as TMenuItemProps<T>,
        index: index,
        menus: menus,
      );
    }
    return Container();
  }
}

class _TMenuItemButton<T> extends StatefulWidget {
  const _TMenuItemButton({
    Key? key,
    required this.menuProps,
    required this.index,
    required this.menus,
  }) : super(key: key);

  /// 菜单项
  final TMenuItemProps<T> menuProps;

  /// 下标
  final int index;

  /// 菜单项
  final List<TMenuProps<T>> menus;

  @override
  State<_TMenuItemButton<T>> createState() => _TMenuItemButtonState<T>();
}

class _TMenuItemButtonState<T> extends State<_TMenuItemButton<T>> {
  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var count = widget.menus.length;
    var isFirst = widget.index == 0;
    var isLast = widget.index == count - 1;
    // var isInner = !isFirst && !isLast;
    // 波纹颜色
    var fixedRippleColor = theme.isLight ? colorScheme.gray3 : colorScheme.gray11;

    return TRipple(
      fixedRippleColor: fixedRippleColor,
      radius: BorderRadius.circular(TVar.borderRadiusDefault),
      builder: (context, states) {
        return SizedBox(
          height: 36,
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: isFirst ? 0 : 4, bottom: isLast ? 0 : 4),
            padding: const EdgeInsets.only(right: 10, left: 16),
            child: widget.menuProps.content,
          ),
        );
      },
    );
  }
}
