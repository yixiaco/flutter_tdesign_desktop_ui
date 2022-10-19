import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/src/components/tag_input/type.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

typedef TTagInputCollapsedItemsCallback = Widget Function(List<String> collapsedTags, int count);

/// 标签输入框
/// 用于输入文本标签
class TTagInput extends TFormItemValidate {
  const TTagInput({
    Key? key,
    this.autoWidth = false,
    this.clearable = false,
    this.collapsedItems,
    this.disabled = false,
    this.dragSort = false,
    this.textController,
    this.defaultInputValue,
    this.label,
    this.max,
    this.minCollapsedNum,
    this.placeholder,
    this.readonly = false,
    this.size,
    this.status = TInputStatus.defaultStatus,
    this.suffix,
    this.suffixIcon,
    this.tag,
    this.tips,
    this.value,
    this.defaultValue,
    this.valueDisplay,
    this.onBlur,
    this.onChange,
    this.onClear,
    this.onDragSort,
    this.onEnter,
    this.onFocus,
    this.onInputChange,
    this.onMouseenter,
    this.onMouseleave,
    this.onRemove,
    FocusNode? focusNode,
    String? name,
  }) : super(key: key, name: name, focusNode: focusNode);

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 是否可清空
  final bool clearable;

  /// 标签过多的情况下，折叠项内容，默认为 +N。如果需要悬浮就显示其他内容，可以使用 collapsedItems 自定义。value 表示标签值，collapsedTags 表示折叠标签值，count 表示总标签数量
  final TTagInputCollapsedItemsCallback? collapsedItems;

  /// 是否禁用标签输入框
  final bool disabled;

  /// 拖拽调整标签顺序
  final bool dragSort;

  /// 输入框的值
  final TextEditingController? textController;

  /// 输入框的值。非受控属性
  final String? defaultInputValue;

  /// 左侧文本
  final Widget? label;

  /// 最大允许输入的标签数量
  final int? max;

  /// 最小折叠数量，用于标签数量过多的情况下折叠选中项，超出该数值的选中项折叠。值为 0 则表示不折叠
  final int? minCollapsedNum;

  /// 占位符
  final String? placeholder;

  /// 只读状态，值为真会隐藏标签移除按钮和输入框
  final bool readonly;

  /// 尺寸
  final TComponentSize? size;

  /// 输入框状态
  final TInputStatus status;

  /// 后置图标前的后置内容
  final Widget? suffix;

  /// 组件后置图标
  final Widget? suffixIcon;

  /// 自定义标签的内部内容，每一个标签的当前值。注意和 valueDisplay 区分，valueDisplay 是用来定义全部标签内容，而非某一个标签
  final String Function(String value)? tag;

  /// 输入框下方提示文本，会根据不同的 status 呈现不同的样式
  final Widget? tips;

  /// 值
  final List<String>? value;

  /// 默认值
  final List<String>? defaultValue;

  /// 自定义值呈现的全部内容，参数为所有标签的值。
  final Widget Function(List<String> value, void Function(int index, String? item) onClose)? valueDisplay;

  /// 失去焦点时触发
  final void Function(List<String> value)? onBlur;

  /// 值变化时触发，参数 `context.trigger` 表示数据变化的触发来源；`context.index` 指当前变化项的下标；`context.item` 指当前变化项；
  final void Function(List<String> value, TagInputChangeContext context)? onChange;

  /// 清空按钮点击时触发
  final VoidCallback? onClear;

  /// 拖拽排序时触发
  final void Function(TagInputDragSortContext context)? onDragSort;

  /// 按键按下 Enter 时触发
  final void Function(List<String> value)? onEnter;

  /// 聚焦时触发
  final void Function(List<String> value)? onFocus;

  /// 输入框值发生变化时触发，`context.trigger` 表示触发输入框值变化的来源：文本输入触发、清除按钮触发、回车键触发等
  final void Function(String value, InputValueChangeContext context)? onInputChange;

  /// 进入输入框时触发
  final VoidCallback? onMouseenter;

  /// 离开输入框时触发
  final VoidCallback? onMouseleave;

  /// 移除单个标签时触发
  final void Function(TagInputRemoveContext context)? onRemove;

  @override
  TFormItemValidateState<TTagInput> createState() => _TTagInputState();
}

class _TTagInputState extends TFormItemValidateState<TTagInput> {
  FocusNode? _focusNode;

  FocusNode get effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController? _controller;

  late TextEditingController _formatController;

  /// 有效文本控制器
  TextEditingController get effectiveController =>
      widget.textController ?? (_controller ??= TextEditingController(text: widget.defaultInputValue));

  /// 是否拥有焦点
  bool isFocused = false;

  /// 是否悬停
  bool isHover = false;

  /// 组件禁用状态
  bool get disabled => formDisabled || widget.disabled;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(border: Border.all()),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Wrap(
                children: [
                  const Text('prefix'),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 155),
                    child: TInputBox(
                      style: TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      selectionColor: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            Text('suffix'),
            Text('suffix'),
          ],
        ),
      ),
    );
  }

  @override
  get formItemValue => widget.value;

  @override
  void reset(TFormResetType type) {
    switch (type) {
      case TFormResetType.empty:
        widget.onChange?.call([], const TagInputChangeContext(trigger: TagInputTriggerSource.clear, item: null));
        break;
      case TFormResetType.initial:
        widget.onChange?.call(widget.defaultValue ?? [], const TagInputChangeContext(trigger: TagInputTriggerSource.clear, item: null));
        break;
    }
  }
}
