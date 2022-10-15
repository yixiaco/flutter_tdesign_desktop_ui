import 'package:flutter/widgets.dart';

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

  @override
  State<TSelectInput> createState() => _TSelectInputState();
}

class _TSelectInputState extends State<TSelectInput> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
