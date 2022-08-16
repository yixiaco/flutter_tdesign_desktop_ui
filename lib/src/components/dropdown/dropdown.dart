import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 下拉菜单
/// 用于承载过多的操作集合，通过下拉拓展的形式，收纳更多的操作。
class TDropdown<T> extends StatelessWidget {
  const TDropdown({
    Key? key,
    this.direction = TDropdownDirection.right,
    this.disabled = false,
    this.hideAfterItemClick = true,
    this.maxColumnWidth = 100,
    this.minColumnWidth = 10,
    this.maxHeight = 300,
    required this.options,
    this.placement = TPopupPlacement.bottomLeft,
    this.trigger = TPopupTrigger.hover,
    this.onClick,
    required this.child,
  }) : super(key: key);

  /// 多层级操作时，子层级展开方向
  final TDropdownDirection direction;

  /// 是否禁用组件
  final bool disabled;

  /// 点击选项后是否自动隐藏弹窗
  final bool hideAfterItemClick;

  /// 选项最大宽度，内容超出时，显示为省略号。
  final double maxColumnWidth;

  /// 选项最小宽度
  final double minColumnWidth;

  /// 弹窗最大高度。统一控制每一列的高度
  final double maxHeight;

  /// 下拉操作项
  final List<TDropdownOption<T>> options;

  /// 弹窗定位方式，可选值同 Popup 组件
  final TPopupPlacement placement;

  /// 触发下拉显示的方式
  final TPopupTrigger trigger;

  /// 下拉操作项点击时触发
  final TValueChange<TDropdownOption<T>>? onClick;

  /// 子组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TPopup(
      content: _TDropdownMenu<T>(
        minColumnWidth: minColumnWidth,
        maxColumnWidth: maxColumnWidth,
        maxHeight: maxHeight,
        options: options,
      ),
      placement: placement,
      trigger: trigger,
      destroyOnClose: false,
      child: child,
    );
  }
}

/// 下拉菜单面板
class _TDropdownMenu<T> extends StatefulWidget {
  const _TDropdownMenu({
    Key? key,
    required this.maxColumnWidth,
    required this.minColumnWidth,
    required this.maxHeight,
    required this.options,
  }) : super(key: key);

  /// 选项最大宽度，内容超出时，显示为省略号。
  final double maxColumnWidth;

  /// 选项最小宽度
  final double minColumnWidth;

  /// 弹窗最大高度。统一控制每一列的高度
  final double maxHeight;

  /// 下拉操作项
  final List<TDropdownOption<T>> options;

  @override
  State<_TDropdownMenu<T>> createState() => _TDropdownMenuState<T>();
}

class _TDropdownMenuState<T> extends State<_TDropdownMenu<T>> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: widget.minColumnWidth,
          maxWidth: widget.maxColumnWidth,
          maxHeight: widget.maxHeight,
        ),
        child: ScrollConfiguration(
          behavior: const CupertinoScrollBehavior(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.options.length, (index) {
                return _TDropdownItem<T>(
                  option: widget.options[index],
                );
              }),
            ),
          ),
        ),
        // child: ListView.builder(
        //   shrinkWrap: true,
        //   addRepaintBoundaries: false,
        //   itemBuilder: (context, index) {
        //     return _TDropdownItem<T>(
        //       option: widget.options[index],
        //     );
        //   },
        //   itemCount: widget.options.length,
        // ),
      ),
    );
  }
}

/// 下拉菜单面板子项
class _TDropdownItem<T> extends StatefulWidget {
  const _TDropdownItem({
    Key? key,
    required this.option,
  }) : super(key: key);

  final TDropdownOption<T> option;

  @override
  State<_TDropdownItem<T>> createState() => _TDropdownItemState<T>();
}

class _TDropdownItemState<T> extends State<_TDropdownItem<T>> {
  @override
  Widget build(BuildContext context) {
    return widget.option.content;
  }
}
