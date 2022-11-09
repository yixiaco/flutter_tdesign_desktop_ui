import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

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
    this.bufferSize = 20,
    this.isFixedRowHeight = false,
    this.rowHeight,
    this.threshold = 100,
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

abstract class TOption {
  const TOption();
}

/// [TSelect]数据项
class TSelectOption extends TOption {
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TSelectOption && runtimeType == other.runtimeType && label == other.label && value == other.value;

  @override
  int get hashCode => label.hashCode ^ value.hashCode;

  TSelectOption copyWith({
    bool? checkAll,
    Widget? child,
    bool? disabled,
    String? label,
    dynamic value,
  }) {
    return TSelectOption(
      checkAll: checkAll ?? this.checkAll,
      child: child ?? this.child,
      disabled: disabled ?? this.disabled,
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }
}

///  [TSelect]数据项分组
class TSelectOptionGroup extends TOption {
  const TSelectOptionGroup({
    this.divider = true,
    required this.group,
    this.children = const [],
  });

  final bool divider;

  /// 分组名称
  final String group;

  /// [TSelect]数据项
  final List<TSelectOption> children;

  TSelectOptionGroup copyWith({
    bool? divider,
    String? group,
    List<TSelectOption>? children,
  }) {
    return TSelectOptionGroup(
      divider: divider ?? this.divider,
      group: group ?? this.group,
      children: children ?? this.children,
    );
  }
}

class TSelectChangeContext {
  /// 表示选中值的完整对象，数组长度一定和 value 相同；
  /// 当value中的值在options中不存在时，数组中为null
  final List<TOption?> selectedOptions;

  /// 表示当前操作的选项，不一定存在。
  final TOption? option;

  /// 表示触发变化的来源
  final TSelectValueChangeTrigger trigger;

  const TSelectChangeContext({
    required this.selectedOptions,
    this.option,
    required this.trigger,
  });
}

class TSelectPopupDataChannel {
  final dynamic value;

  /// 可编辑文本字段的控制器
  final TextEditingController textController;

  /// 选项
  final List<TOption> options;

  /// 是否可搜索
  final bool filterable;

  /// 自定义过滤方法，用于对现有数据进行搜索过滤，判断是否过滤某一项数据。
  final FutureOr<bool> Function(String filterWords, TSelectOption option)? filter;

  /// 组件大小
  final TComponentSize size;

  /// 是否为加载状态
  final bool loading;

  /// 远程加载时显示的文字，支持自定义。如加上超链接。
  final Widget? loadingText;

  /// 当下拉列表为空时显示的内容。
  final Widget? empty;

  /// 用于控制多选数量，值为 0 则不限制
  final int max;

  /// 是否允许多选
  final bool multiple;

  /// 点击事件
  final void Function(TSelectOption option, bool check) onClick;

  const TSelectPopupDataChannel({
    this.value,
    required this.textController,
    required this.options,
    required this.filterable,
    this.filter,
    required this.size,
    required this.loading,
    this.loadingText,
    this.empty,
    required this.max,
    required this.multiple,
    required this.onClick,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TSelectPopupDataChannel &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          textController == other.textController &&
          options == other.options &&
          filterable == other.filterable &&
          filter == other.filter &&
          size == other.size &&
          loading == other.loading &&
          loadingText == other.loadingText &&
          empty == other.empty &&
          max == other.max &&
          multiple == other.multiple &&
          onClick == other.onClick;

  @override
  int get hashCode =>
      value.hashCode ^
      textController.hashCode ^
      options.hashCode ^
      filterable.hashCode ^
      filter.hashCode ^
      size.hashCode ^
      loading.hashCode ^
      loadingText.hashCode ^
      empty.hashCode ^
      max.hashCode ^
      multiple.hashCode ^
      onClick.hashCode;
}