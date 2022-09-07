import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

part 'part/head_menu/head_menu_layout.dart';

part 'part/head_menu/head_menu_props.dart';

part 'part/head_menu/sub_head_menu.dart';

part 'part/head_menu/head_menu_item.dart';

/// 导航菜单-顶部导航
/// 用于承载网站的架构，并提供跳转的菜单列表。
class THeadMenu<T> extends StatefulWidget {
  const THeadMenu({
    Key? key,
    this.expandType,
    this.logo,
    this.operations,
    this.theme,
    required this.controller,
    this.onChange,
    this.onExpand,
    this.menus = const [],
  }) : super(key: key);

  /// 二级菜单展开方式，平铺展开和浮层展开。
  final TMenuExpandType? expandType;

  /// 站点 LOGO。
  final Widget? logo;

  /// 导航操作区域。
  final List<Widget>? operations;

  /// 菜单风格
  final TMenuTheme? theme;

  /// 选项控制
  final TMenuController<T> controller;

  /// 激活菜单项发生变化时触发
  final void Function(T value)? onChange;

  /// 展开的菜单项发生变化时触发
  final void Function(Set<T> value)? onExpand;

  /// 菜单项
  final List<TMenuProps<T>> menus;

  @override
  State<THeadMenu<T>> createState() => _THeadMenuState<T>();
}

class _THeadMenuState<T> extends State<THeadMenu<T>> {
  @override
  void initState() {
    widget.controller.addListener(_notifyUpdate);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_notifyUpdate);
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant THeadMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_notifyUpdate);
      widget.controller.addListener(_notifyUpdate);
    }
  }

  void _notifyUpdate() {
    if (mounted) {
      setState(() {});
    } else {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _notifyUpdate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var headMenuTheme = TDefaultMenuTheme.headMenuOf(context);
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var menuTheme = widget.theme ?? headMenuTheme.theme ?? (theme.isLight ? TMenuTheme.light : TMenuTheme.dark);
    // var textColor = menuTheme.isLight ? colorScheme.fontGray2 : colorScheme.fontWhite2;
    var menuBorderColor = menuTheme.isLight ? colorScheme.componentStroke : colorScheme.gray10;
    var expandType = widget.expandType ?? headMenuTheme.expandType ?? TMenuExpandType.normal;

    Widget? logo;
    Widget? operations;

    List<Widget> children = List.generate(widget.menus.length, (index) {
      var menu = widget.menus[index];
      return _THeadMenuLayout<T>(
        props: _THeadMenuItemLayoutProps<T>(
          parent: null,
          controller: widget.controller,
          currentProps: menu,
          index: index,
          menus: widget.menus,
          theme: menuTheme,
          level: 1,
          expandType: expandType,
          onChange: widget.onChange,
          onExpand: widget.onExpand,
        ),
      );
    });

    if (widget.logo != null) {
      logo = Container(
        margin: const EdgeInsets.only(right: 32),
        child: widget.logo!,
      );
    }

    if (widget.operations != null) {
      operations = Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        alignment: Alignment.centerLeft,
        child: TDefaultMenuTheme<TMenuThemeParentData>(
          data: THeadMenuThemeData(
            theme: menuTheme,
            expandType: expandType,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: widget.operations!,
          ),
        ),
      );
    }

    return DefaultTextStyle.merge(
      style: theme.fontData.fontBodyMedium.merge(TextStyle(
        color: colorScheme.textColorPrimary,
      )),
      child: IconTheme.merge(
        data: IconThemeData(
          color: colorScheme.textColorPrimary,
        ),
        child: Container(
          color: menuTheme.isLight ? Colors.white : colorScheme.gray13,
          height: 64,
          child: Row(
            children: [
              if (logo != null) logo,
              Expanded(
                child: Row(
                  children: children,
                ),
              ),
              if (operations != null) operations,
            ],
          ),
        ),
      ),
    );
  }
}
