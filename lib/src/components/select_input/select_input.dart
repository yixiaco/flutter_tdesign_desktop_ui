import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/src/components/input/type.dart';
import 'package:tdesign_desktop_ui/src/components/select_input/type.dart';

/// 筛选器输入框
/// 定义：筛选器通用输入框
class TSelectInput extends StatefulWidget {
  const TSelectInput({
    Key? key,
    required this.allowInput,
    required this.autoWidth,
    required this.borderless,
    required this.clearable,
    this.collapsedItems,
    this.disabled = false,
    this.inputValue,
    this.defaultInputValue,
    this.keys,
    this.label,
    required this.loading,
    required this.minCollapsedNum,
    required this.multiple,
    this.panel,
    required this.placeholder,
    this.popupProps,
    this.popupVisible,
    required this.readonly,
    required this.status,
    this.suffix,
    this.suffixIcon,
    this.tag,
  }) : super(key: key);

  /// 是否允许输入
  final bool allowInput;

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 无边框模式
  final bool borderless;

  /// 是否可清空
  final bool clearable;

  /// 标签过多的情况下，折叠项内容，默认为 `+N`。
  /// 如果需要悬浮就显示其他内容，可以使用 `collapsedItems` 自定义。
  /// `value` 表示所有标签值，`collapsedTags` 表示折叠标签值，`count` 表示总标签数量
  final void Function(dynamic value, dynamic collapsedTags, int count)? collapsedItems;

  /// 是否禁用
  final bool disabled;

  /// 输入框的值
  final String? inputValue;

  /// 输入框的值，非受控属性
  final String? defaultInputValue;

  /// 定义字段别名
  final SelectInputKeys? keys;

  /// 左侧文本
  final Widget? label;

  /// 是否处于加载状态
  final bool loading;

  /// 最小折叠数量，用于标签数量过多的情况下折叠选中项，超出该数值的选中项折叠。值为 0 则表示不折叠
  final int minCollapsedNum;

  /// 是否为多选模式，默认为单选
  final bool multiple;

  /// 下拉框内容，可完全自定义
  final Widget? panel;

  /// 占位符
  final String placeholder;

  /// 透传 Popup 浮层组件全部属性
  final dynamic popupProps;

  /// 是否显示下拉框
  final ValueNotifier<bool>? popupVisible;

  /// 只读状态，值为真会隐藏输入框，且无法打开下拉框
  final bool readonly;

  /// 输入框状态
  final TInputStatus status;

  /// 后置图标前的后置内容
  final Widget? suffix;

  /// 组件后置图标
  final Widget? suffixIcon;

  /// 自定义标签的内部内容，每一个标签的当前值。注意和 valueDisplay 区分，valueDisplay 是用来定义全部标签内容，而非某一个标签
  final String? tag;

  @override
  State<TSelectInput> createState() => _TSelectInputState();
}

class _TSelectInputState extends State<TSelectInput> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
