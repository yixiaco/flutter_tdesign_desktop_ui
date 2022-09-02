import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

part 'components/menu_group.dart';

part 'components/menu_item.dart';

part 'components/menu_layout.dart';

part 'components/props.dart';

part 'components/sub_menu.dart';

const double _kMenuWidth = 232;
const double _kMenuFoldingWidth = 64;

/// 导航菜单-侧边导航
/// 用于承载网站的架构，并提供跳转的菜单列表。
class TMenu<T> extends StatefulWidget {
  const TMenu({
    Key? key,
    this.collapsed,
    this.expandMutex,
    this.expandType,
    this.logo,
    this.operations,
    this.theme,
    required this.controller,
    this.width,
    this.foldingWidth,
    this.onChange,
    this.onExpand,
    this.menus = const [],
  }) : super(key: key);

  /// 是否收起菜单
  final bool? collapsed;

  /// 同级别互斥展开
  final bool? expandMutex;

  /// 二级菜单展开方式，平铺展开和浮层展开。
  final TMenuExpandType? expandType;

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
  final void Function(Set<T> value)? onExpand;

  /// 菜单项
  final List<TMenuProps<T>> menus;

  @override
  State<TMenu<T>> createState() => _TMenuState<T>();
}

class _TMenuState<T> extends State<TMenu<T>> {
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
  void didUpdateWidget(covariant TMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_notifyUpdate);
      widget.controller.addListener(_notifyUpdate);
    }
  }

  void _notifyUpdate() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var defaultMenuTheme = TDefaultMenuTheme.of(context);
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var menuTheme = widget.theme ?? defaultMenuTheme.theme ?? (theme.isLight ? TMenuTheme.light : TMenuTheme.dark);
    var textColor = menuTheme.isLight ? colorScheme.fontGray2 : colorScheme.fontWhite2;
    var menuBorderColor = menuTheme.isLight ? colorScheme.componentStroke : colorScheme.gray10;
    var stroke = BorderSide(color: menuBorderColor);
    var collapsed = widget.collapsed ?? defaultMenuTheme.collapsed ?? false;
    var expandMutex = widget.expandMutex ?? defaultMenuTheme.expandMutex ?? false;
    var expandType = widget.expandType ?? defaultMenuTheme.expandType ?? TMenuExpandType.normal;
    var width = widget.width ?? defaultMenuTheme.width ?? _kMenuWidth;
    var foldingWidth = widget.foldingWidth ?? defaultMenuTheme.foldingWidth ?? _kMenuFoldingWidth;

    Widget? logo;
    Widget? operations;

    List<Widget> children = List.generate(widget.menus.length, (index) {
      var menu = widget.menus[index];
      return _TMenuLayout<T>(
        props: _TMenuItemLayoutProps<T>(
          parent: null,
          controller: widget.controller,
          collapsed: collapsed,
          currentProps: menu,
          index: index,
          menus: widget.menus,
          theme: menuTheme,
          level: 1,
          expandMutex: expandMutex,
          expandType: expandType,
          onChange: widget.onChange,
          onExpand: widget.onExpand,
        ),
      );
    });

    if (widget.logo != null) {
      logo = Container(
        decoration: BoxDecoration(
          border: Border(bottom: stroke),
        ),
        alignment: Alignment.centerLeft,
        height: 64,
        child: widget.logo!,
      );
    }
    if (widget.operations != null) {
      operations = Container(
        decoration: BoxDecoration(
          border: Border(top: stroke),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        alignment: Alignment.bottomLeft,
        child: TDefaultMenuTheme(
          data: TMenuThemeData(
            collapsed: collapsed,
            headMenu: false,
            theme: menuTheme,
            width: width,
            expandMutex: expandMutex,
            expandType: expandType,
            foldingWidth: foldingWidth,
          ),
          child: UnconstrainedBox(child: widget.operations!),
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
        child: AnimatedContainer(
          duration: TVar.animDurationSlow,
          curve: const Cubic(.645, .045, .355, 1),
          color: menuTheme.isLight ? Colors.white : colorScheme.gray13,
          width: collapsed ? foldingWidth : width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (logo != null) logo,
                    Flexible(
                      child: DefaultTextStyle.merge(
                        style: theme.fontData.fontBodyMedium.merge(TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: textColor,
                        )),
                        child: IconTheme.merge(
                          data: IconThemeData(
                            color: textColor,
                            size: 20,
                          ),
                          child: TSingleChildScrollView(
                            child: AnimatedPadding(
                              duration: TVar.animDurationSlow,
                              curve: const Cubic(.645, .045, .355, 1),
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: children,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
