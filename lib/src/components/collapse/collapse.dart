import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 折叠面板
/// 可以将较多或较复杂的内容进行分组，分组内容区可以折叠展开或隐藏。
class TCollapse<T> extends StatefulWidget {
  const TCollapse({
    super.key,
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
  });

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
  final List<dynamic>? value;

  /// 切换面板时触发，返回变化的值
  final void Function(List<dynamic> value)? onChange;

  /// 面板数据
  final List<TCollapsePanel<T>> panels;

  @override
  State<TCollapse<T>> createState() => _TCollapseState<T>();
}

class _TCollapseState<T> extends State<TCollapse<T>> {
  @override
  void initState() {
    super.initState();
    // 默认展开时，初始化后调用onChange
    if (widget.defaultExpandAll) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onChange?.call(List.generate(widget.panels.length, (index) => widget.panels[index].value ?? index));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var checkValue = widget.value;

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
          decoration: BoxDecoration(
            color: colorScheme.bgColorContainer,
            border: widget.borderless ? null : Border.all(color: colorScheme.componentBorder),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.panels.length, (index) {
              var panel = widget.panels[index];
              var value = panel.value ?? index;
              return _TCollapsePanel<T>(
                expand: checkValue?.contains(value) ?? false,
                disabled: widget.disabled || (panel.disabled ?? false),
                showExpandIcon: widget.showExpandIcon,
                expandIcon: widget.expandIcon,
                expandIconPlacement: widget.expandIconPlacement,
                expandOnRowClick: widget.expandOnRowClick,
                panel: panel,
                last: widget.panels.length - 1 == index,
                borderless: widget.borderless,
                onChange: (expand) {
                  if (widget.expandMutex) {
                    widget.onChange?.call(expand ? [value] : []);
                  } else {
                    var list = checkValue?.toList() ?? [];
                    if (expand) {
                      if (!list.contains(value)) {
                        list.add(value);
                      }
                    } else {
                      list.remove(value);
                    }
                    widget.onChange?.call(list);
                  }
                },
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
    super.key,
    required this.expand,
    required this.disabled,
    required this.showExpandIcon,
    this.expandIcon,
    required this.expandIconPlacement,
    required this.expandOnRowClick,
    this.onChange,
    required this.panel,
    required this.last,
    required this.borderless,
  });

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
  final TCollapsePanel<T> panel;

  /// 排序最后
  final bool last;

  /// 是否无边框
  final bool borderless;

  @override
  State<_TCollapsePanel<T>> createState() => _TCollapsePanelState<T>();
}

class _TCollapsePanelState<T> extends State<_TCollapsePanel<T>> {
  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    Widget? icon = _buildIcon();

    Widget child = _buildHeader(theme, icon);

    var borderSide = widget.last || widget.borderless ? BorderSide.none : BorderSide(color: colorScheme.componentBorder);
    var disabledColor = widget.disabled ? colorScheme.bgColorComponentDisabled : null;
    var bgColor = widget.borderless ? null : disabledColor ?? colorScheme.bgColorSecondaryContainer;

    return Container(
      color: disabledColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          if (widget.panel.content != null)
            AnimatedCrossFade(
              firstChild: Container(height: 0.0),
              secondChild: FractionallySizedBox(
                widthFactor: 1,
                child: Container(
                  padding: const EdgeInsets.only(top: 12, right: 16, bottom: 12, left: 40),
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border(bottom: borderSide),
                  ),
                  child: widget.panel.content!,
                ),
              ),
              firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
              secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
              sizeCurve: Curves.fastOutSlowIn,
              crossFadeState: widget.expand ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
              layoutBuilder: (topChild, topChildKey, bottomChild, bottomChildKey) {
                // 是否销毁
                if (widget.panel.destroyOnCollapse) {
                  bottomChild = Container(height: 0.0);
                }
                return AnimatedCrossFade.defaultLayoutBuilder(topChild, topChildKey, bottomChild, bottomChildKey);
              },
            ),
        ],
      ),
    );
  }

  /// 头部
  Widget _buildHeader(TThemeData theme, Widget? icon) {
    var colorScheme = theme.colorScheme;
    var borderSide = widget.last && !widget.expand || widget.borderless ? BorderSide.none : BorderSide(color: colorScheme.componentBorder);
    Widget header = DefaultTextStyle.merge(
      style: TextStyle(fontSize: theme.fontData.fontSizeTitleSmall),
      child: Container(
        height: 46,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          border: Border(bottom: borderSide),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.expandIconPlacement == TCollapseExpandIconPlacement.left && icon != null) icon,
                if (widget.panel.header != null) widget.panel.header!,
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.panel.headerRightContent != null) widget.panel.headerRightContent!,
                if (widget.expandIconPlacement == TCollapseExpandIconPlacement.right && icon != null) icon,
              ],
            ),
          ],
        ),
      ),
    );
    Widget child;
    if (widget.expandOnRowClick) {
      child = TMaterialStateButton(
        disabled: widget.disabled,
        onTap: () => widget.onChange?.call(!widget.expand),
        builder: (context, states) {
          return header;
        },
      );
    } else {
      child = header;
    }
    return child;
  }

  /// 箭头icon
  Widget? _buildIcon() {
    if (!widget.showExpandIcon) {
      return null;
    }
    Widget chevronIcon = TFakeArrow(
      placement: widget.expand ? TFakeArrowPlacement.bottom : TFakeArrowPlacement.right,
      child: widget.panel.expandIcon ?? widget.expandIcon,
    );
    if (widget.expandIconPlacement == TCollapseExpandIconPlacement.left) {
      chevronIcon = Padding(
        padding: EdgeInsets.only(right: TVar.spacer1),
        child: chevronIcon,
      );
    } else {
      chevronIcon = Padding(
        padding: EdgeInsets.only(left: TVar.spacer1),
        child: chevronIcon,
      );
    }
    Widget icon = TMaterialStateButton(
      disabled: widget.disabled,
      onTap: () => widget.onChange?.call(!widget.expand),
      builder: (context, states) {
        return chevronIcon;
      },
    );
    return icon;
  }
}
