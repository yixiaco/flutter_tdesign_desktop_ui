import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 标签按钮
part 'components/tab_button.dart';

/// 标签icon按钮
part 'components/tab_icon_button.dart';

/// 标签Label
part 'components/tab_label.dart';

/// 标签下划线
part 'components/tab_painter.dart';

/// 面板
part 'components/tab_panel.dart';

/// 选项卡
/// 用于承载同一层级下不同页面或类别的组件，方便用户在同一个页面框架下进行快速切换。
class TTabs<T> extends StatefulWidget {
  const TTabs({
    super.key,
    this.addable = false,
    this.disabled = false,
    this.dragSort = false,
    required this.value,
    required this.list,
    this.placement = TTabsPlacement.top,
    this.size,
    this.theme = TTabsTheme.normal,
    this.onAdd,
    this.onChange,
    this.onDragSort,
    this.onRemove,
    this.crossAxisAlignment,
    this.mainAxisSize,
    this.softWrap = true,
    this.mainAxisAlignment,
  });

  /// 选项卡是否可增加
  final bool addable;

  /// 是否禁用选项卡
  final bool disabled;

  /// 是否开启拖拽调整顺序
  final bool dragSort;

  /// 激活的选项卡值
  final T? value;

  ///	选项卡列表
  final List<TTabsPanel<T>> list;

  /// 选项卡位置
  final TTabsPlacement placement;

  /// 组件尺寸
  final TComponentSize? size;

  /// 选项卡风格
  final TTabsTheme theme;

  /// 点击添加选项卡时触发
  final void Function()? onAdd;

  /// 激活的选项卡发生变化时触发
  final void Function(T value)? onChange;

  /// 拖拽排序时触发
  final void Function(int currentIndex, T current, int targetIndex, T target)? onDragSort;

  /// 删除选项卡时触发
  final void Function(T value, int index)? onRemove;

  /// 交叉轴对齐方式
  final CrossAxisAlignment? crossAxisAlignment;

  /// 主轴大小
  final MainAxisSize? mainAxisSize;

  /// 主轴对齐方式
  final MainAxisAlignment? mainAxisAlignment;

  /// 是否缩小包装
  final bool softWrap;

  /// 当前下标
  int get _index => list.indexWhere((element) => element.value == value);

  @override
  State<TTabs<T>> createState() => _TTabsState<T>();
}

class _TTabsState<T> extends State<TTabs<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TTabs<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var style = TTabsStyle.of(context);
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? theme.size;

    Widget child = _buildLabel();
    Widget panel = _TabPanel(
      list: widget.list,
      index: widget._index,
      value: widget.value,
    );
    CrossAxisAlignment? crossAxisAlignment = widget.crossAxisAlignment;
    MainAxisSize? mainAxisSize = widget.mainAxisSize;
    MainAxisAlignment? mainAxisAlignment = widget.mainAxisAlignment;
    switch (widget.placement) {
      case TTabsPlacement.top:
        mainAxisSize ??= MainAxisSize.min;
        if (widget.softWrap) {
          crossAxisAlignment ??= CrossAxisAlignment.start;
        } else {
          crossAxisAlignment ??= CrossAxisAlignment.stretch;
        }
        if(mainAxisSize == MainAxisSize.max) {
          panel = Expanded(child: panel);
        }
        child = FixedCrossFlex(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          direction: Axis.vertical,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: [child, panel],
        );
        break;
      case TTabsPlacement.bottom:
        mainAxisSize ??= MainAxisSize.min;
        if (widget.softWrap) {
          crossAxisAlignment ??= CrossAxisAlignment.start;
        } else {
          crossAxisAlignment ??= CrossAxisAlignment.stretch;
        }
        if(mainAxisSize == MainAxisSize.max) {
          panel = Expanded(child: panel);
        }
        child = FixedCrossFlex(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          direction: Axis.vertical,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: [panel, child],
        );
        break;
      case TTabsPlacement.left:
        crossAxisAlignment ??= CrossAxisAlignment.start;
        if (widget.softWrap) {
          mainAxisSize ??= MainAxisSize.min;
        } else {
          mainAxisSize ??= MainAxisSize.max;
        }
        if(mainAxisSize == MainAxisSize.max) {
          panel = Expanded(child: panel);
        }
        child = FixedCrossFlex(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
          direction: Axis.horizontal,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: [child, panel],
        );
        break;
      case TTabsPlacement.right:
        crossAxisAlignment ??= CrossAxisAlignment.start;
        if (widget.softWrap) {
          mainAxisSize ??= MainAxisSize.min;
        } else {
          mainAxisSize ??= MainAxisSize.max;
        }
        if(mainAxisSize == MainAxisSize.max) {
          panel = Expanded(child: panel);
        }
        child = FixedCrossFlex(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          crossAxisAlignment: crossAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: [panel, child],
        );
        break;
    }
    return Container(
      color: style.backgroundColor ?? colorScheme.bgColorContainer,
      child: IconTheme(
        data: IconThemeData(
          size: theme.fontData.fontSizeL,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: colorScheme.textColorPrimary,
            fontFamily: theme.fontFamily,
            fontSize: size.lazySizeOf(
              small: () => theme.fontData.fontSizeBodyMedium,
              medium: () => theme.fontData.fontSizeBodyMedium,
              large: () => theme.fontData.fontSizeBodyLarge,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  /// 构建标签
  Widget _buildLabel() {
    return _TabsLabel(
      addable: widget.addable,
      disabled: widget.disabled,
      dragSort: widget.dragSort,
      value: widget.value,
      list: widget.list,
      placement: widget.placement,
      size: widget.size,
      theme: widget.theme,
      onAdd: widget.onAdd,
      onChange: widget.onChange,
      onDragSort: widget.onDragSort,
      onRemove: widget.onRemove,
    );
  }
}
