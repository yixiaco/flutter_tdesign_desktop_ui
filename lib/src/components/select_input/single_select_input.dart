import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 筛选器输入框单选
class TSingleSelectInput<T extends SelectInputValue> extends StatefulWidget {
  const TSingleSelectInput({
    super.key,
    this.size,
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
    this.placement,
    this.trigger,
    this.showArrow,
    this.onOpen,
    this.onClose,
    this.showDuration = const Duration(milliseconds: 250),
    this.hideDuration = const Duration(milliseconds: 150),
    this.destroyOnClose = false,
    this.popupStyle,
    this.popupVisible,
    this.readonly = false,
    this.status,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.tips,
    this.textAlign = TextAlign.left,
    this.value,
    this.onBlur,
    this.onClear,
    this.onEnter,
    this.onFocus,
    this.onInputChange,
    this.onMouseenter,
    this.onMouseleave,
    this.onPopupVisibleChange,
    this.focusNode,
    this.autofocus = false,
    this.valueDisplay,
  });

  /// 尺寸
  final TComponentSize? size;

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
  /// 浮层出现位置
  final TPopupPlacement? placement;

  /// 触发浮层出现的方式
  final TPopupTrigger? trigger;

  /// 是否显示浮层箭头
  final bool? showArrow;

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
  final TPopupVisible? popupVisible;

  /// 只读状态，值为真会隐藏输入框，且无法打开下拉框
  final bool readonly;

  /// 输入框状态
  final TInputStatus? status;

  /// 组件前置图标
  final Widget? prefixIcon;

  /// 后置图标前的后置内容
  final Widget? suffix;

  /// 组件后置图标
  final Widget? suffixIcon;

  /// 输入框下方提示文本，会根据不同的 status 呈现不同的样式
  final Widget? tips;

  /// 文本对齐方式
  final TextAlign textAlign;

  /// 全部标签值。值为数组表示多个标签，值为非数组表示单个数值。
  final T? value;

  /// 失去焦点时触发
  final void Function(T? value, TSelectInputFocusContext context)? onBlur;

  /// 清空按钮点击时触发
  final VoidCallback? onClear;

  /// 按键按下 Enter 时触发
  final void Function(T? value, String inputValue)? onEnter;

  /// 聚焦时触发
  final void Function(T? value, String inputValue)? onFocus;

  /// 输入框值发生变化时触发，context.trigger 表示触发输入框值变化的来源：文本输入触发、清除按钮触发等
  final void Function(String value, InputValueChangeContext trigger)? onInputChange;

  /// 进入输入框时触发
  final PointerEnterEventListener? onMouseenter;

  /// 离开输入框时触发
  final PointerExitEventListener? onMouseleave;

  /// 下拉框显示或隐藏时触发。
  final void Function(bool visible)? onPopupVisibleChange;

  /// 自定义值呈现的全部内容
  final String Function(T? value)? valueDisplay;

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  @override
  State<TSingleSelectInput<T>> createState() => _TSingleSelectInputState<T>();
}

class _TSingleSelectInputState<T extends SelectInputValue> extends State<TSingleSelectInput<T>> {
  TextEditingController? _textController;

  TextEditingController get effectiveTextEditingController =>
      widget.inputController ?? (_textController ??= TextEditingController(text: widget.defaultInputValue));

  late ValueNotifier<bool> showClearIcon;

  bool _isHovered = false;

  @override
  void initState() {
    showClearIcon = ValueNotifier(false);
    effectiveTextEditingController.text = widget.value?.label ?? '';
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TSingleSelectInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _valueChange();
    }
  }

  @override
  void dispose() {
    showClearIcon.dispose();
    _textController?.dispose();
    super.dispose();
  }

  void _valueChange() {
    var value = widget.value;
    if (widget.valueDisplay != null) {
      effectiveTextEditingController.text = widget.valueDisplay!(value);
    } else {
      effectiveTextEditingController.text = value?.label ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? panel;
    if (widget.panel != null) {
      panel = LimitedBox(
        maxWidth: 1000,
        child: widget.panel,
      );
    }
    var trigger = widget.trigger ?? (widget.allowInput ? TPopupTrigger.focus : TPopupTrigger.notifier);
    return TPopup(
      disabled: widget.disabled || widget.readonly,
      showDuration: widget.showDuration,
      hideDuration: widget.hideDuration,
      onOpen: widget.onOpen,
      onClose: widget.onClose,
      destroyOnClose: widget.destroyOnClose,
      visible: widget.popupVisible,
      style: const TPopupStyle(followBoxWidth: true).merge(widget.popupStyle),
      content: panel,
      trigger: trigger,
      placement: widget.placement ?? TPopupPlacement.bottomLeft,
      showArrow: widget.showArrow ?? false,
      hideEmptyPopup: true,
      child: Builder(
        builder: (context) {
          return TInput(
            onTap: () {
              if(trigger == TPopupTrigger.notifier) {
                popupNotification.dispatch(context);
              }
            },
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            controller: effectiveTextEditingController,
            readonly: !widget.allowInput || widget.readonly,
            disabled: widget.disabled,
            autoWidth: widget.autoWidth,
            tips: widget.tips,
            onChange: (text) {
              widget.onInputChange?.call(text, InputValueChangeContext.input);
            },
            align: widget.textAlign,
            status: widget.status,
            onEnter: (value) {
              widget.onEnter?.call(widget.value, value);
            },
            placeholder: widget.placeholder,
            onMouseenter: (event) {
              _isHovered = true;
              _handleClearChange();
              widget.onMouseenter?.call(event);
            },
            onMouseleave: (event) {
              _isHovered = false;
              _handleClearChange();
              widget.onMouseleave?.call(event);
            },
            onFocus: (text) {
              widget.onFocus?.call(widget.value, text);
            },
            onBlur: (text) {
              widget.onBlur?.call(widget.value, TSelectInputFocusContext(inputValue: text));
              _valueChange();
            },
            label: widget.label,
            prefixIcon: widget.prefixIcon,
            suffix: widget.suffix,
            suffixIcon:
                !widget.disabled && widget.loading ? const TLoading(size: TComponentSize.small) : _buildSuffixIcon(),
            borderless: widget.borderless,
            size: widget.size,
          );
        }
      ),
    );
  }

  /// 构建后缀icon
  Widget? _buildSuffixIcon() {
    return TClearIcon(
      onClick: () {
        effectiveTextEditingController.clear();
        widget.onClear?.call();
      },
      show: showClearIcon,
      icon: widget.suffixIcon,
    );
  }

  /// 处理清理icon状态变更
  void _handleClearChange() {
    if ((widget.value != null || effectiveTextEditingController.text.isNotEmpty) &&
        widget.clearable &&
        !widget.disabled &&
        !widget.readonly &&
        _isHovered) {
      showClearIcon.value = true;
    } else {
      showClearIcon.value = false;
    }
  }
}
