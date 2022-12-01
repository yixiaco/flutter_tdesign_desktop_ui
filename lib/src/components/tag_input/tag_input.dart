import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

typedef TTagInputCollapsedItemsCallback = Widget Function(List<String> value, List<String> collapsedTags, int count);

/// 标签输入框
/// 用于输入文本标签
class TTagInput extends TFormItemValidate {
  const TTagInput({
    super.key,
    this.autoWidth = false,
    this.clearable = false,
    this.collapsedItems,
    this.disabled = false,
    this.dragSort = false,
    this.excessTagsDisplayType = TTagExcessTagsDisplayType.breakLine,
    this.textController,
    this.defaultInputValue,
    this.label,
    this.max,
    this.minCollapsedNum = 0,
    this.placeholder,
    this.readonly = false,
    this.allowInput = true,
    this.size,
    this.status,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.tag,
    this.tips,
    this.controller,
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
    this.tagTheme = TTagTheme.defaultTheme,
    this.tagVariant = TTagVariant.dark,
    this.textAlign = TextAlign.left,
    this.borderless = false,
    this.enterClearInput = true,
    this.onTap,
    this.onKeyDown,
    this.onKeyPress,
    this.onKeyUp,
    this.autofocus = false,
    super.focusNode,
    super.name,
  });

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 是否可清空
  final bool clearable;

  /// 标签过多的情况下，折叠项内容，默认为 +N。如果需要悬浮就显示其他内容，可以使用 collapsedItems 自定义。
  /// value 表示标签值，collapsedTags 表示折叠标签值，count 表示总标签数量
  final TTagInputCollapsedItemsCallback? collapsedItems;

  /// 是否禁用标签输入框
  final bool disabled;

  /// 拖拽调整标签顺序
  final bool dragSort;

  /// 标签超出时的呈现方式，有两种：横向滚动显示 和 换行显示
  final TTagExcessTagsDisplayType excessTagsDisplayType;

  /// 输入框的值
  final TextEditingController? textController;

  /// 输入框的值。非受控属性
  final String? defaultInputValue;

  /// 左侧文本
  final Widget? label;

  /// 最大允许输入的标签数量
  final int? max;

  /// 最小折叠数量，用于标签数量过多的情况下折叠选中项，超出该数值的选中项折叠。值为 0 则表示不折叠
  final int minCollapsedNum;

  /// 占位符
  final String? placeholder;

  /// 只读状态，值为真会隐藏标签移除按钮和输入框
  final bool readonly;

  /// 是否允许输入
  final bool allowInput;

  /// 尺寸
  final TComponentSize? size;

  /// 输入框状态
  final TInputStatus? status;

  /// 组件前置图标
  final Widget? prefixIcon;

  /// 后置图标前的后置内容
  final Widget? suffix;

  /// 组件后置图标
  final Widget? suffixIcon;

  /// 自定义标签的内部内容，每一个标签的当前值。注意和 valueDisplay 区分，valueDisplay 是用来定义全部标签内容，而非某一个标签
  final String Function(int index, String value)? tag;

  /// 输入框下方提示文本，会根据不同的 status 呈现不同的样式
  final Widget? tips;

  /// 值
  final TTagInputController? controller;

  /// 默认值
  final List<String>? defaultValue;

  /// 自定义值呈现的全部内容，参数为所有标签的值。
  final List<Widget> Function(List<String> value, void Function(int index, String item) onClose)? valueDisplay;

  /// 失去焦点时触发
  final void Function(List<String> value, String inputValue)? onBlur;

  /// 值变化时触发，参数 `context.trigger` 表示数据变化的触发来源；`context.index` 指当前变化项的下标；`context.item` 指当前变化项；
  final void Function(List<String> value, TagInputChangeContext context)? onChange;

  /// 清空按钮点击时触发
  final VoidCallback? onClear;

  /// 拖拽排序时触发
  final void Function(TagInputDragSortContext context)? onDragSort;

  /// 按键按下 Enter 时触发
  final void Function(List<String> value)? onEnter;

  /// 聚焦时触发
  final void Function(List<String> value, String inputValue)? onFocus;

  /// 输入框值发生变化时触发，`context.trigger` 表示触发输入框值变化的来源：文本输入触发、清除按钮触发、回车键触发等
  final void Function(String value, InputValueChangeContext context)? onInputChange;

  /// 进入输入框时触发
  final PointerEnterEventListener? onMouseenter;

  /// 离开输入框时触发
  final PointerExitEventListener? onMouseleave;

  /// 移除单个标签时触发
  final void Function(TagInputRemoveContext context)? onRemove;

  /// 标签主题
  final TTagTheme tagTheme;

  /// 标签风格变体
  final TTagVariant tagVariant;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 无边框模式
  final bool borderless;

  /// 按下enter事件清除input文本
  final bool enterClearInput;

  /// {@macro tdesign.components.inputBase.onTap}
  final GestureTapCallback? onTap;

  /// 键盘按下时触发
  final TInputKeyEvent? onKeyDown;

  /// 按下字符键时触发（keydown -> keypress -> keyup）
  final TInputKeyEvent? onKeyPress;

  /// 释放键盘时触发
  final TInputKeyEvent? onKeyUp;

  /// 自动聚焦
  final bool autofocus;

  @override
  TFormItemValidateState<TTagInput> createState() => _TTagInputState();
}

class _TTagInputState extends TFormItemValidateState<TTagInput> {
  TTagInputController? _controller;

  TTagInputController get effectiveController =>
      widget.controller ?? (_controller ??= TTagInputController(value: widget.defaultValue));

  TextEditingController? _textController;

  TextEditingController get effectiveTextController =>
      widget.textController ?? (_textController ??= TextEditingController(text: widget.defaultInputValue));

  FocusNode? _focusNode;

  FocusNode get effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  late ValueNotifier<bool> showClearIcon;

  /// 组件禁用状态
  bool get disabled => formDisabled || widget.disabled;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    showClearIcon = ValueNotifier(false);
  }

  @override
  void dispose() {
    showClearIcon.dispose();
    _controller?.dispose();
    _textController?.dispose();
    _focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: effectiveController,
      builder: (BuildContext context, Widget? child) {
        return TInput(
          onTap: widget.onTap,
          padding: EdgeInsets.only(left: TVar.spacerS, right: TVar.spacer),
          borderless: widget.borderless,
          align: widget.textAlign,
          disabled: disabled,
          readonly: !widget.allowInput || widget.readonly,
          controller: effectiveTextController,
          focusNode: effectiveFocusNode,
          autofocus: widget.autofocus,
          autoWidth: widget.autoWidth,
          breakLine: widget.excessTagsDisplayType == TTagExcessTagsDisplayType.breakLine,
          prefixIcon: widget.prefixIcon,
          prefixPadding: EdgeInsets.only(left: TVar.spacerS),
          suffixIcon: TClearIcon(
            onClick: _handleClear,
            show: showClearIcon,
            icon: widget.suffixIcon,
          ),
          label: widget.label,
          size: widget.size,
          status: widget.status,
          suffix: widget.suffix,
          tips: widget.tips,
          prefixLabels: _buildTags(),
          onMouseenter: (event) {
            _isHovered = true;
            _handleClearIconChange();
            widget.onMouseenter?.call(event);
          },
          onMouseleave: (event) {
            _isHovered = false;
            _handleClearIconChange();
            widget.onMouseleave?.call(event);
          },
          onKeyDown: _handleBackspace,
          onKeyPress: widget.onKeyPress,
          onKeyUp: widget.onKeyUp,
          placeholder: effectiveController.value.isNotEmpty ? '' : widget.placeholder,
          onEnter: _handleEnter,
          onFocus: (text) => widget.onFocus?.call(effectiveController.value, text),
          onBlur: (text) => widget.onBlur?.call(effectiveController.value, text),
          onChange: (text) {
            _handleClearIconChange();
            widget.onInputChange?.call(effectiveTextController.text, InputValueChangeContext.input);
          },
        );
      },
    );
  }

  /// 构建标签
  List<Widget> _buildTags() {
    List<Widget> defaultValueDisplay(List<String> value, void Function(int index, String item) onClose) {
      int length = value.length;
      if (widget.minCollapsedNum > 0 && value.length > widget.minCollapsedNum) {
        length = widget.minCollapsedNum;
      }
      Widget buildTag(int index) {
        var item = value[index];
        return TTag(
          closable: !disabled && !widget.readonly,
          theme: widget.tagTheme,
          variant: widget.tagVariant,
          child: Text(widget.tag?.call(index, item) ?? item),
          onClose: () {
            onClose(index, item);
          },
        );
      }

      return [
        ...List.generate(length, (index) {
          Widget tag = buildTag(index);
          // 拖拽
          if (widget.dragSort) {
            var item = value[index];
            tag = MouseRegion(
              cursor: SystemMouseCursors.basic,
              child: Draggable<_TagInputDraggableData>(
                data: _TagInputDraggableData(
                  current: item,
                  currentIndex: index,
                ),
                feedback: Opacity(opacity: 0.6, child: tag),
                child: DragTarget<_TagInputDraggableData>(
                  builder: (context, candidateData, rejectedData) {
                    if (candidateData.isNotEmpty) {
                      var divider = TDivider(
                        layout: Axis.vertical,
                        color: TTheme.of(context).colorScheme.brandColor,
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                      );
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (candidateData[0]!.currentIndex >= index) divider,
                          buildTag(index),
                          if (candidateData[0]!.currentIndex < index) divider,
                        ],
                      );
                    }
                    return buildTag(index);
                  },
                  onWillAccept: (data) {
                    return data != null;
                  },
                  onAccept: (data) {
                    var currentIndex = data.currentIndex;
                    var current = data.current;
                    effectiveController.moveIndex(currentIndex, index);
                    var tagInputDragSortContext = TagInputDragSortContext(
                      newTags: effectiveController.value,
                      currentIndex: currentIndex,
                      current: current,
                      targetIndex: index,
                      target: item,
                    );
                    widget.onDragSort?.call(tagInputDragSortContext);
                  },
                ),
              ),
            );
          }
          return Padding(
            padding: EdgeInsets.only(right: TVar.spacerS),
            child: tag,
          );
        }),
        if (value.length > length)
          Padding(
            padding: EdgeInsets.only(right: TVar.spacerS),
            child: widget.collapsedItems?.call(value, value.sublist(length), value.length - length) ??
                TTag(
                  theme: widget.tagTheme,
                  variant: widget.tagVariant,
                  child: Text('+${value.length - length}'),
                ),
          ),
      ];
    }

    return (widget.valueDisplay ?? defaultValueDisplay).call(effectiveController.value, _tagRemove);
  }

  /// 处理退格键
  void _handleBackspace(String text, KeyEvent event) {
    widget.onKeyDown?.call(text, event);
    if (event.physicalKey == PhysicalKeyboardKey.backspace && text.isEmpty) {
      var lastIndex = effectiveController.value.lastIndex;
      var item = effectiveController.value[lastIndex];
      effectiveController.removeLast();
      widget.onRemove?.call(TagInputRemoveContext(
        value: effectiveController.value,
        index: lastIndex,
        item: item,
        trigger: TagInputRemoveTrigger.backspace,
      ));
      _handleValueChange(TagInputTriggerSource.backspace, index: lastIndex, item: item);
    }
  }

  /// 处理回车键
  void _handleEnter(String text) {
    if (text.isNotEmpty) {
      if (widget.enterClearInput) {
        effectiveTextController.clear();
      }
      effectiveFocusNode.requestFocus();
      if (widget.max == null || effectiveController.value.length < widget.max!) {
        effectiveController.add(text);
      }
      _handleClearIconChange();
      widget.onInputChange?.call(text, InputValueChangeContext.enter);
      _handleValueChange(TagInputTriggerSource.enter, item: text);
    }
    widget.onEnter?.call(effectiveController.value);
  }

  /// 标签删除事件
  void _tagRemove(int index, String item) {
    widget.onRemove?.call(TagInputRemoveContext(
      value: effectiveController.value,
      index: index,
      item: item,
      trigger: TagInputRemoveTrigger.tagRemove,
    ));
    effectiveController.removeAt(index);
    _handleValueChange(TagInputTriggerSource.tagRemove, index: index, item: item);
  }

  /// 处理清理icon状态变更
  void _handleClearIconChange() {
    if ((effectiveController.value.isNotEmpty || effectiveTextController.text.isNotEmpty) &&
        widget.clearable &&
        !disabled &&
        !widget.readonly &&
        _isHovered) {
      showClearIcon.value = true;
    } else {
      showClearIcon.value = false;
    }
  }

  /// 处理值变更
  void _handleValueChange(TagInputTriggerSource triggerSource, {int? index, String? item}) {
    formChange();
    widget.onChange
        ?.call(effectiveController.value, TagInputChangeContext(trigger: triggerSource, index: index, item: item));
  }

  /// 处理清空事件
  void _handleClear() {
    showClearIcon.value = false;
    effectiveController.clear();
    effectiveTextController.clear();
    widget.onClear?.call();
    widget.onInputChange?.call(effectiveTextController.text, InputValueChangeContext.clear);
    _handleValueChange(TagInputTriggerSource.clear);
  }

  @override
  FocusNode? get focusNode => effectiveFocusNode;

  @override
  get formItemValue => effectiveController.value;

  @override
  void reset(TFormResetType type) {
    switch (type) {
      case TFormResetType.empty:
        effectiveController.clear();
        break;
      case TFormResetType.initial:
        effectiveController.value = widget.defaultValue ?? [];
        break;
    }
    widget.onChange?.call(
      effectiveController.value,
      const TagInputChangeContext(trigger: TagInputTriggerSource.reset, item: null),
    );
  }
}

/// 拖拽数据
class _TagInputDraggableData<T> {
  const _TagInputDraggableData({
    required this.currentIndex,
    required this.current,
  });

  final int currentIndex;
  final T current;
}
