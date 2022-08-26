import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

import 'types.dart';

/// 折叠面板
/// 可以将较多或较复杂的内容进行分组，分组内容区可以折叠展开或隐藏。
class TCollapse<T> extends StatefulWidget {
  const TCollapse({
    Key? key,
    this.borderless = false,
    this.defaultExpandAll = false,
    this.disabled = false,
    this.showExpandIcon = true,
    this.expandIcon,
    this.expandIconPlacement = TCollapseExpandIconPlacement.left,
    this.expandMutex = false,
    this.expandOnRowClick = true,
    this.value,
    this.onChange,
    required this.panels,
  }) : super(key: key);

  /// 是否为无边框模式
  final bool borderless;

  /// 默认是否展开全部
  final bool defaultExpandAll;

  /// 是否禁用面板展开/收起操作
  final bool disabled;

  /// 值为 false 则不显示展开图标
  /// 值为 true 显示默认图标
  final bool showExpandIcon;

  /// 展开图标。值为 undefined 显示默认图标；否则显示自定义展开图标。
  final Widget? expandIcon;

  /// 展开图标的位置，左侧或右侧。
  final TCollapseExpandIconPlacement expandIconPlacement;

  /// 每个面板互斥展开，每次只展开一个面板
  final bool expandMutex;

  /// 是否允许点击整行标题展开面板
  final bool expandOnRowClick;

  /// 展开的面板集合
  final List<T>? value;

  /// 切换面板时触发，返回变化的值
  final void Function(int index, T? value, bool expand)? onChange;

  /// 面板数据
  final List<TCollapsePanel> panels;

  @override
  State<TCollapse<T>> createState() => _TCollapseState<T>();
}

class _TCollapseState<T> extends State<TCollapse<T>> {
  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    return IconTheme(
      data: IconThemeData(
        size: theme.fontData.fontSizeTitleMedium,
        color: colorScheme.textColorPrimary,
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: colorScheme.textColorPrimary,
        ).merge(theme.fontData.fontBodyMedium),
        child: Container(
          color: colorScheme.bgColorContainer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.panels.length, (index) {
              var panel = widget.panels[index];
              return _TCollapsePanel(
                expand: widget.value?.contains(panel.value ?? index) ?? false,
                disabled: widget.disabled || (panel.disabled ?? false),
                showExpandIcon: widget.showExpandIcon,
                expandIcon: widget.expandIcon,
                expandIconPlacement: widget.expandIconPlacement,
                expandOnRowClick: widget.expandOnRowClick,
                panel: panel,
                onChange: (expand) => widget.onChange?.call(index, panel.value, expand),
              );
            }),
          ),
        ),
      ),
    );
  }
}

/// 折叠单面板
class _TCollapsePanel<T> extends StatefulWidget {
  const _TCollapsePanel({
    Key? key,
    required this.expand,
    required this.disabled,
    required this.showExpandIcon,
    this.expandIcon,
    required this.expandIconPlacement,
    required this.expandOnRowClick,
    this.onChange,
    required this.panel,
  }) : super(key: key);

  /// 是否展开
  final bool expand;

  /// 是否禁用面板展开/收起操作
  final bool disabled;

  /// 值为 false 则不显示展开图标
  /// 值为 true 显示默认图标
  final bool showExpandIcon;

  /// 展开图标。值为 undefined 显示默认图标；否则显示自定义展开图标。
  final Widget? expandIcon;

  /// 展开图标的位置，左侧或右侧。
  final TCollapseExpandIconPlacement expandIconPlacement;

  /// 是否允许点击整行标题展开面板
  final bool expandOnRowClick;

  /// 切换面板时触发
  final void Function(bool expand)? onChange;

  /// 面板数据
  final TCollapsePanel panel;

  @override
  State<_TCollapsePanel> createState() => _TCollapsePanelState();
}

class _TCollapsePanelState extends State<_TCollapsePanel> {
  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: theme.fontData.fontSizeTitleSmall,
          ),
          child: Container(
            height: 46,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: TVar.spacer1),
                  child: const Icon(TIcons.chevronRight),
                ),
                if (widget.panel.header != null) widget.panel.header!,
              ],
            ),
          ),
        ),
        if (widget.panel.content != null)
          Container(
            padding: const EdgeInsets.only(top: 12, right: 16, bottom: 12, left: 40),
            color: colorScheme.bgColorSecondaryContainer,
            child: widget.panel.content!,
          ),
      ],
    );
  }
}
