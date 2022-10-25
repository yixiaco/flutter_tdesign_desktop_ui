import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 筛选器输入框单选
class TSelectInputSingle<T extends SelectInputValue> extends StatefulWidget {
  const TSelectInputSingle({
    Key? key,
    this.allowInput = false,
    this.autoWidth = false,
    this.borderless = false,
    this.clearable = false,
    this.disabled = false,
    this.inputController,
    this.defaultInputValue,
    this.label,
    this.loading = false,
    this.panel,
    this.placeholder,
    this.onOpen,
    this.onClose,
    this.showDuration = const Duration(milliseconds: 250),
    this.hideDuration = const Duration(milliseconds: 150),
    this.destroyOnClose = true,
    this.popupStyle,
    this.popupVisible,
    this.readonly = false,
    this.status = TInputStatus.defaultStatus,
    this.suffix,
    this.suffixIcon,
    this.tips,
    this.textAlign = TextAlign.left,
    this.controller,
    this.valueDisplay,
    this.onBlur,
    this.onClear,
    this.onEnter,
    this.onFocus,
    this.onInputChange,
    this.onMouseenter,
    this.onMouseleave,
    this.onPopupVisibleChange,
  }) : super(key: key);

  /// 是否允许输入
  final bool allowInput;

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 无边框模式
  final bool borderless;

  /// 是否可清空
  final bool clearable;

  /// 是否禁用
  final bool disabled;

  /// 输入框的值
  final TextEditingController? inputController;

  /// 输入框的值，非受控属性
  final String? defaultInputValue;

  /// 左侧文本
  final Widget? label;

  /// 是否处于加载状态
  final bool loading;

  /// 下拉框内容，可完全自定义
  final Widget? panel;

  /// 占位符
  final String? placeholder;

  /// Popup 浮层组件属性
  /// 打开事件
  final TCallback? onOpen;

  /// 关闭事件
  final TCallback? onClose;

  /// hover和focus时，显示的延迟
  final Duration showDuration;

  /// hover和focus时，隐藏的延迟
  final Duration hideDuration;

  /// 是否在关闭浮层时销毁浮层，默认为false.
  /// 因为一般不需要维护浮层内容的状态，这可以显著提升运行速度
  final bool destroyOnClose;

  /// 浮层样式
  final TPopupStyle? popupStyle;

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

  /// 输入框下方提示文本，会根据不同的 status 呈现不同的样式
  final Widget? tips;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 全部标签值。值为数组表示多个标签，值为非数组表示单个数值。
  final TSelectInputSingleController<T>? controller;

  /// 自定义值呈现的全部内容，参数为所有标签的值。
  final Widget Function(TSelectInputSingleController<T> value, void Function(int index, T item) onClose)? valueDisplay;

  /// 失去焦点时触发
  final void Function(TSelectInputFocusContext context)? onBlur;

  /// 清空按钮点击时触发
  final VoidCallback? onClear;

  /// 按键按下 Enter 时触发
  final void Function(TSelectInputSingleController<T> value, String inputValue)? onEnter;

  /// 聚焦时触发
  final void Function(TSelectInputSingleController<T> value, String inputValue, String tagInputValue)? onFocus;

  /// 输入框值发生变化时触发，context.trigger 表示触发输入框值变化的来源：文本输入触发、清除按钮触发等
  final void Function(String value, InputValueChangeContext trigger)? onInputChange;

  /// 进入输入框时触发
  final PointerEnterEventListener? onMouseenter;

  /// 离开输入框时触发
  final PointerExitEventListener? onMouseleave;

  /// 下拉框显示或隐藏时触发。
  final void Function(bool visible)? onPopupVisibleChange;

  @override
  State<TSelectInputSingle<T>> createState() => _TSelectInputSingleState<T>();
}

class _TSelectInputSingleState<T extends SelectInputValue> extends State<TSelectInputSingle<T>> {
  TextEditingController? _textController;

  TextEditingController get effectiveTextEditingController =>
      widget.inputController ?? (_textController ??= TextEditingController(text: widget.defaultInputValue));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TInput(
      readonly: !widget.allowInput || widget.readonly,
      disabled: widget.disabled,
      controller: effectiveTextEditingController,
    );
  }
}
