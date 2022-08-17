import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 多层级操作时，子层级展开方向
enum TDropdownDirection {
  /// 向左展开
  left,

  /// 向右展开
  right;
}

class TDropdownOption<T> {
  const TDropdownOption({
    this.active = false,
    required this.content,
    this.disabled = false,
    this.divider = false,
    this.value,
    this.children,
    this.onClick,
  });

  /// 是否高亮当前操作项
  final bool active;

  /// 下拉操作项内容
  final Widget content;

  /// 是否禁用操作项
  final bool disabled;

  /// 是否显示操作项之间的分隔线（分隔线默认在下方）
  final bool divider;

  /// 下拉操作项唯一标识
  final T? value;

  /// 子选项
  final List<TDropdownOption<T>>? children;

  /// 点击时触发
  final TValueChange<TDropdownOption<T>>? onClick;

  /// 文本内容
  static TDropdownOption<T> text<T>({
    bool active = false,
    required String content,
    bool disabled = false,
    bool divider = false,
    T? value,
    List<TDropdownOption<T>>? children,
    TValueChange<TDropdownOption<T>>? onClick,
  }) {
    return TDropdownOption<T>(
      active: active,
      content: Text(content),
      disabled: disabled,
      divider: divider,
      value: value,
      children: children,
      onClick: onClick,
    );
  }
}
