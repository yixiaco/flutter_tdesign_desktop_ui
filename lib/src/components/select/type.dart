import 'package:flutter/widgets.dart';

class TSelectScroll {
  /// 表示除可视区域外，额外渲染的行数，避免快速滚动过程中，新出现的内容来不及渲染从而出现空白
  final int bufferSize;

  /// 表示每行内容是否同一个固定高度，仅在 `scroll.type` 为 `virtual` 时有效，该属性设置为 `true` 时，
  /// 可用于简化虚拟滚动内部计算逻辑，提升性能，此时则需要明确指定 `scroll.rowHeight` 属性的值
  final bool isFixedRowHeight;

  /// 行高，不会给元素添加样式高度，仅作为滚动时的行高参考。
  /// 一般情况不需要设置该属性。如果设置，可尽量将该属性设置为每行平均高度，从而使得滚动过程更加平滑
  final double? rowHeight;

  /// 启动虚拟滚动的阈值。为保证组件收益最大化，当数据量小于阈值 `scroll.threshold` 时，无论虚拟滚动的配置是否存在，组件内部都不会开启虚拟滚动
  final int threshold;

  /// 滚动加载类型，有两种：懒加载和虚拟滚动。
  /// <br />值为 `lazy` ，表示滚动时会进行懒加载，非可视区域内的内容将不会默认渲染，直到该内容可见时，才会进行渲染，并且已渲染的内容滚动到不可见时，不会被销毁；
  /// <br />值为`virtual`时，表示会进行虚拟滚动，无论滚动条滚动到哪个位置，同一时刻，仅渲染该可视区域内的内容，当需要展示的数据量较大时，建议开启该特性
  final TSelectScrollType type;

  const TSelectScroll({
    required this.bufferSize,
    required this.isFixedRowHeight,
    this.rowHeight,
    required this.threshold,
    required this.type,
  });
}

enum TSelectScrollType {
  lazy,
  virtual;
}

enum TSelectValueType {
  value,
  object;
}

enum TSelectValueChangeTrigger {
  clear,
  tagRemove,
  backspace,
  check,
  uncheck;
}

/// [TSelect]数据项
class TSelectOption {
  const TSelectOption({
    this.checkAll = false,
    this.child,
    this.disabled = false,
    required this.label,
    this.value,
  });

  /// 当前选项是否为全选，全选可以在顶部，也可以在底部。点击当前选项会选中禁用态除外的全部选项，即使是分组选择器也会选中全部选项
  final bool checkAll;

  /// 用于定义复杂的选项内容。
  final Widget? child;

  /// 是否禁用该选项
  final bool disabled;

  /// 选项名称
  final String label;

  /// 选项值
  final dynamic value;
}
