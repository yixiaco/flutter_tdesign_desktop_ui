import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// Select 选择器
class TSelect<T extends TSelectOption> extends StatefulWidget {
  const TSelect({
    super.key,
    this.autoWidth = false,
    this.borderless = false,
    this.clearable = false,
    this.collapsedItems,
    this.creatable = false,
    this.disabled = false,
    this.empty,
    this.filter,
    this.filterable = false,
    this.inputProps,
    this.textController,
    this.loading = false,
    this.loadingText,
    this.max = 0,
    this.minCollapsedNum = 0,
    this.multiple = false,
    this.options,
    this.panelBottomContent,
    this.panelTopContent,
    this.placeholder,
    this.popupProps,
    this.popupVisible,
    this.prefixIcon,
    this.readonly = false,
    this.reserveKeyword = false,
    this.scroll,
    this.showArrow = true,
    this.size,
    this.status = TInputStatus.defaultStatus,
    this.tips,
    this.value,
    this.defaultValue,
    this.valueType = TSelectValueType.value,
    this.singleValueDisplay,
    this.multipleValueDisplay,
    this.onBlur,
    this.onClear,
    this.onCreate,
    this.onEnter,
    this.onChange,
    this.onFocus,
    this.onInputChange,
    this.onMouseenter,
    this.onMouseleave,
    this.onPopupVisibleChange,
    this.onRemove,
    this.onSearch,
    this.focusNode,
    this.autofocus = false,
  }) : assert(!multiple || multiple && value is List);

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 无边框模式
  final bool borderless;

  /// 是否可以清空选项
  final bool clearable;

  /// 多选情况下，用于设置折叠项内容，默认为 +N。如果需要悬浮就显示其他内容，可以使用 collapsedItems 自定义
  final TSelectInputCollapsedItemsCallback<T>? collapsedItems;

  /// 是否允许用户创建新条目，需配合 filterable 使用
  final bool creatable;

  /// 是否禁用组件
  final bool disabled;

  /// 当下拉列表为空时显示的内容。
  final Widget? empty;

  /// 自定义过滤方法，用于对现有数据进行搜索过滤，判断是否过滤某一项数据。
  final FutureOr<bool> Function(String filterWords, T option)? filter;

  /// 是否可搜索
  final bool filterable;

  /// 透传 Input 输入框组件的全部属性
  final dynamic inputProps;

  /// 输入框的控制器
  final TextEditingController? textController;

  /// 是否为加载状态
  final bool loading;

  /// 远程加载时显示的文字，支持自定义。如加上超链接。
  final Widget? loadingText;

  /// 用于控制多选数量，值为 0 则不限制
  final int max;

  /// 最小折叠数量，用于多选情况下折叠选中项，超出该数值的选中项折叠。值为 0 则表示不折叠
  final int minCollapsedNum;

  /// 是否允许多选
  final bool multiple;

  /// 数据化配置选项内容。
  final List<T>? options;

  /// 面板内的底部内容。
  final Widget? panelBottomContent;

  /// 面板内的顶部内容。
  final Widget? panelTopContent;

  /// 占位符
  final String? placeholder;

  /// 透传给 popup 组件的全部属性
  final dynamic popupProps;

  /// 是否显示下拉框。
  final TPopupVisible? popupVisible;

  /// 组件前置图标。
  final Widget? prefixIcon;

  /// 只读状态，值为真会隐藏输入框，且无法打开下拉框
  final bool readonly;

  /// 多选且可搜索时，是否在选中一个选项后保留当前的搜索关键词
  final bool reserveKeyword;

  /// 懒加载和虚拟滚动。为保证组件收益最大化，当数据量小于阈值 scroll.threshold 时，无论虚拟滚动的配置是否存在，组件内部都不会开启虚拟滚动，scroll.threshold 默认为 100
  final TSelectScroll? scroll;

  /// 是否显示右侧箭头，默认显示
  final bool showArrow;

  /// 组件尺寸
  final TComponentSize? size;

  /// 输入框状态
  final TInputStatus status;

  /// 输入框下方提示文本，会根据不同的 status 呈现不同的样式。
  final Widget? tips;

  /// {@template tdesign.components.select.value}
  /// 选中值
  /// [value],多选时为List<dynamic>,单选时为dynamic
  /// {@endtemplate}
  final dynamic value;

  /// 选中值。非受控属性
  final dynamic defaultValue;

  /// 用于控制选中值的类型。假设数据选项为：[{ label: '姓名', value: 'name' }]，value 表示值仅返回数据选项中的 value， object 表示值返回全部数据。
  /// 可选项：value/object
  final TSelectValueType valueType;

  /// 自定义值呈现的全部内容
  final String Function(T? value)? singleValueDisplay;

  /// 自定义值呈现的全部内容，参数为所有标签的值。
  final List<Widget> Function(List<T> value, void Function(int index, T item) onClose)? multipleValueDisplay;

  /// 失去焦点时触发
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value)? onBlur;

  /// 清空按钮点击时触发
  final VoidCallback? onClear;

  /// 当选择新创建的条目时触发
  final void Function(String value)? onCreate;

  /// 按键按下 Enter 时触发
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value, String inputValue)? onEnter;

  /// 聚焦时触发
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value)? onFocus;

  /// 输入框值发生变化时触发，context.trigger 表示触发输入框值变化的来源：文本输入触发、清除按钮触发等
  final void Function(String value, InputValueChangeContext trigger)? onInputChange;

  /// 进入输入框时触发
  final PointerEnterEventListener? onMouseenter;

  /// 离开输入框时触发
  final PointerExitEventListener? onMouseleave;

  /// 下拉框显示或隐藏时触发。
  final void Function(bool visible)? onPopupVisibleChange;

  /// 多选模式下，选中数据被移除时触发
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value, T data)? onRemove;

  /// 输入值变化时，触发搜索事件。主要用于远程搜索新数据
  final void Function(String filterWords)? onSearch;

  /// 选中值变化时触发。
  /// context.trigger 表示触发变化的来源；
  /// context.selectedOptions 表示选中值的完整对象，数组长度一定和 value 相同；
  /// context.option 表示当前操作的选项，不一定存在。
  /// {@macro tdesign.components.select.value}
  final void Function(dynamic value, {List<T> selectedOptions, TSelectValueChangeTrigger trigger})? onChange;

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  @override
  State<TSelect> createState() => _TSelectState();
}

class _TSelectState extends State<TSelect> {
  @override
  Widget build(BuildContext context) {
    return TSelectInput();
  }
}
