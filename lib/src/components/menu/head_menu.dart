import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

part 'components/head_menu/head_menu_layout.dart';

part 'components/head_menu/head_menu_props.dart';

part 'components/head_menu/sub_head_menu.dart';

part 'components/head_menu/head_menu_item.dart';

/// 导航菜单-顶部导航
/// 用于承载网站的架构，并提供跳转的菜单列表。
class THeadMenu<T> extends StatefulWidget {
  const THeadMenu({
    super.key,
    this.expandType,
    this.logo,
    this.operations,
    this.theme,
    required this.controller,
    this.onChange,
    this.onExpand,
    this.menus = const [],
  });

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
  late List<TMenuProps<T>> tabsChildren;
  late THeadMenuThemeData headMenuTheme;

  @override
  void initState() {
    tabsChildren = [];
    widget.controller.addListener(_notifyUpdate);
    super.initState();
  }

  @override
  void dispose() {
    tabsChildren.clear();
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
    if (widget.expandType != oldWidget.expandType) {
      widget.controller.expanded.clear();
      tabsChildren.clear();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    headMenuTheme = TDefaultMenuTheme.headMenuOf(context);
  }

  void _notifyUpdate() {
    var expandType = widget.expandType ?? headMenuTheme.expandType ?? TMenuExpandType.normal;
    if (expandType == TMenuExpandType.normal) {
      tabsChildren.clear();
      if (widget.controller.expanded.isNotEmpty) {
        var first = widget.controller.expanded.first;
        for (var element in widget.menus) {
          var props = element as TSubMenuProps<T>;
          if (first == props.value) {
            tabsChildren.addAll(props.children);
            break;
          }
        }
      }
    }
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        if(mounted) {
          setState(() {});
        }
      });
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var menuTheme = widget.theme ?? headMenuTheme.theme ?? (theme.isLight ? TMenuTheme.light : TMenuTheme.dark);
    var menuBorderColor = menuTheme.isLight ? colorScheme.componentStroke : Colors.transparent;
    var stroke = BorderSide(color: menuBorderColor);
    var textColor = theme.isLight ? colorScheme.fontGray2 : menuItemHoverColorDark;
    var expandType = widget.expandType ?? headMenuTheme.expandType ?? TMenuExpandType.normal;

    Widget? logo;
    Widget? operations;
    Widget? tabs;

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
          child: widget.operations!,
        ),
      );
    }

    if (tabsChildren.isNotEmpty) {
      tabs = Container(
        decoration: BoxDecoration(
          border: Border(top: stroke),
        ),
        child: _buildTabs(theme, colorScheme),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 64,
                child: Row(
                  children: [
                    if (logo != null) logo,
                    _buildWrapTextStyle(
                      theme,
                      textColor,
                      Expanded(
                        child: TSingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(children: children),
                        ),
                      ),
                    ),
                    if (operations != null) operations,
                  ],
                ),
              ),
              if (tabs != null) _buildWrapTextStyle(theme, textColor, tabs),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建选项卡
  Widget _buildTabs(TThemeData theme, TColorScheme colorScheme) {
    return TTabsStyle(
      data: TTabsStyleData(
        backgroundColor: theme.isLight ? null : colorScheme.gray11,
        buttonStyle: TTabsButtonStyle(
          textColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return colorScheme.textColorDisabled;
            }
            if (states.contains(MaterialState.selected)) {
              return colorScheme.brandColor;
            }
            return theme.isLight ? colorScheme.textColorSecondary : Colors.white;
          }),
          backgroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.transparent;
            }
            if (states.contains(MaterialState.hovered)) {
              return theme.isLight ? colorScheme.bgColorContainerHover : colorScheme.gray10;
            }
            return Colors.transparent;
          }),
          rippleColor: theme.isLight ? null : colorScheme.gray9,
        ),
      ),
      child: TTabs<T>(
        size: TComponentSize.small,
        softWrap: false,
        value: widget.controller.value,
        onChange: (value) {
          widget.controller.value = value;
        },
        list: List.generate(
          tabsChildren.length,
          (index) {
            var tab = tabsChildren[index];
            if (tab is TMenuItemProps<T>) {
              return TTabsPanel(label: tab.content!, value: tab.value);
            } else if (tab is TSubMenuProps<T>) {
              return TTabsPanel(label: tab.title!, value: tab.value);
            } else {
              throw FlutterError('二级菜单只支持TMenuItemProps和TSubMenuProps，不支持TMenuGroupProps或其他对象');
            }
          },
        ),
      ),
    );
  }

  Widget _buildWrapTextStyle(TThemeData theme, Color textColor, Widget child) {
    return DefaultTextStyle.merge(
      style: theme.fontData.fontBodyMedium.merge(TextStyle(
        overflow: TextOverflow.ellipsis,
        color: textColor,
      )),
      child: IconTheme.merge(
        data: IconThemeData(
          color: textColor,
          size: 20,
        ),
        child: child,
      ),
    );
  }
}
