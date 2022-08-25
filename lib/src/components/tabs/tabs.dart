import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 标签按钮
part '_tab_button.dart';

/// 标签icon按钮
part '_tab_icon_button.dart';

/// 标签Label
part '_tab_label.dart';

/// 标签下划线
part '_tab_painter.dart';

/// 选项卡
/// 用于承载同一层级下不同页面或类别的组件，方便用户在同一个页面框架下进行快速切换。
class TTabs<T> extends StatefulWidget {
  const TTabs({
    Key? key,
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
  }) : super(key: key);

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

  /// 当前下标
  int get _index => list.indexWhere((element) => element.value == value);

  @override
  State<TTabs<T>> createState() => _TTabsState<T>();
}

class _TTabsState<T> extends State<TTabs<T>> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    if (widget._index != -1) {
      _pageController = PageController(initialPage: widget._index);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void didUpdateWidget(covariant TTabs<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return _buildLabel();
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
