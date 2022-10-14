import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

const double _kInputNumberWidthS = 120; // 数字输入组件宽度 小
const double _kInputNumberWidth = 144; // 数字输入组件宽度 中
const double _kInputNumberWidthL = 168; // 数字输入组件宽度 大

const double _kInputNumberButtonWidthS = 24; // 数字输入框操作按钮宽度 小
const double _kInputNumberButtonWidth = 32; // 数字输入框操作按钮的宽度 中
const double _kInputNumberButtonWidthL = 40; // 数字输入框操作按钮宽度 大

const double _kInputNumberButtonHeightS = 24; // 数字输入框操作按钮高度 小
const double _kInputNumberButtonHeight = 32; // 数字输入框操作按钮的高度 中
const double _kInputNumberButtonHeightL = 40; // 数字输入框操作按钮高度 大

const double _kInputNumberRightWidthS = 88; // 右侧调整数字输入组件宽度 小
const double _kInputNumberRightWidth = 96; // 右侧调整数字输入组件宽度 中
const double _kInputNumberRightWidthL = 120; // 右侧调整数字输入组件宽度 大

const double _kInputNumberRightButtonWidthS = 32; // 右侧调整数字输入框操作按钮宽度 小
const double _kInputNumberRightButtonWidth = 32; // 右侧调整数字输入框操作按钮宽度 中
const double _kInputNumberRightButtonWidthL = 40; // 右侧调整数字输入框操作按钮宽度 大

const double _kInputNumberButtonColumnHeightS = 10; //  右侧调整数字操作按钮的高度 中
const double _kInputNumberButtonColumnHeight = 14; //  右侧调整数字操作按钮的高度 中
const double _kInputNumberButtonColumnHeightL = 18; //  右侧调整数字操作按钮的高度 大

/// 数字输入框
/// 数字输入框由增加、减少按钮、数值输入组成。每次点击增加按钮（或减少按钮），数字增长（或减少）的量是恒定的。
class TInputNumber<T> extends TFormItemValidate {
  const TInputNumber({
    Key? key,
    String? name,
    FocusNode? focusNode,
    this.align,
    this.autoWidth = false,
    this.decimalPlaces = 0,
    this.disabled = false,
    this.inputFormatters,
    this.label,
    this.max,
    this.min,
    this.placeholder,
    this.readonly = false,
    this.size,
    this.status = TInputStatus.defaultStatus,
    this.step = 1,
    this.suffix,
    this.theme = TInputNumberTheme.row,
    this.tips,
    this.inputTips,
    this.value,
    this.defaultValue,
    this.onBlur,
    this.onChange,
    this.onEnter,
    this.onFocus,
    this.onKeyDown,
    this.onValidate,
    this.onMouseenter,
    this.onMouseleave,
    this.scrollController,
    this.keyboardType,
    this.restorationId,
    this.autofocus = false,
  })  : assert(T == num || T == String || T == int || T == double),
        super(key: key, name: name, focusNode: focusNode);

  /// 文本内容位置，居左/居中/居右
  final TextAlign? align;

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 小数位数
  final int decimalPlaces;

  /// 禁用组件
  final bool disabled;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// 左侧文本
  final Widget? label;

  /// 最大值。如果是大数，请传入字符串
  final dynamic max;

  /// 最小值。如果是大数，请传入字符串
  final dynamic min;

  /// 占位符
  final String? placeholder;

  /// 只读状态
  final bool readonly;

  /// 组件尺寸
  final TComponentSize? size;

  /// 文本框状态。
  final TInputStatus status;

  /// 数值改变步数，可以是小数。如果是大数，请保证数据类型为字符串。
  final dynamic step;

  /// 后置内容。
  final Widget? suffix;

  /// 按钮布局
  final TInputNumberTheme theme;

  /// 提示文本，会根据不同的 status 呈现不同的样式。
  final Widget? tips;

  /// 输入框下方提示文本，会根据不同的 status 呈现不同的样式。
  final Widget? inputTips;

  /// 数字输入框的值。当值为 '' 时，输入框显示为空
  final T? value;

  /// 数字输入框的值。当值为 '' 时，输入框显示为空。非受控属性
  final T? defaultValue;

  /// 失去焦点时触发
  final VoidCallback? onBlur;

  /// 值变化时触发。
  final void Function(T? value)? onChange;

  /// 回车键按下时触发
  final VoidCallback? onEnter;

  /// 获取焦点时触发
  final VoidCallback? onFocus;

  /// 键盘按下时触发
  final VoidCallback? onKeyDown;

  /// 最大值或最小值校验结束后触发，exceedMaximum 表示超出最大值，belowMinimum 表示小于最小值
  final void Function(bool exceedMaximum, bool belowMinimum)? onValidate;

  /// 鼠标进入事件
  final PointerEnterEventListener? onMouseenter;

  /// 鼠标离开事件
  final PointerExitEventListener? onMouseleave;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// {@macro tdesign.components.inputBase.restorationId}
  final String? restorationId;

  /// 自动聚焦
  final bool autofocus;

  @override
  TFormItemValidateState<TInputNumber<T>> createState() => _TInputNumberState<T>();
}

class _TInputNumberState<T> extends TFormItemValidateState<TInputNumber<T>> {
  late TextEditingController _controller;
  FocusNode? _focusNode;

  FocusNode get effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  late String _text;

  /// 是否禁用
  bool get _disabled => formDisabled || widget.disabled;

  Decimal get _current => _text.isEmpty ? Decimal.zero : Decimal.parse(_text);

  Decimal get _step => Decimal.parse(widget.step.toString());

  Decimal? get _min => widget.min != null ? Decimal.parse(widget.min.toString()) : null;

  Decimal? get _max => widget.max != null ? Decimal.parse(widget.max.toString()) : null;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.value?.toString() ?? widget.defaultValue?.toString());
    _text = _controller.text;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode?.dispose();
  }

  @override
  void didUpdateWidget(covariant TInputNumber<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value?.toString() ?? '';
      _handle();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? theme.size;
    // tips颜色
    var tipsColor = widget.status.lazyValueOf(
      defaultStatus: () => colorScheme.textColorPlaceholder,
      success: () => colorScheme.successColor,
      warning: () => colorScheme.warningColor,
      error: () => colorScheme.errorColor,
    );

    var buttonSize = Size(
      size.sizeOf(
        small: _kInputNumberButtonWidthS,
        medium: _kInputNumberButtonWidth,
        large: _kInputNumberButtonWidthL,
      ),
      size.sizeOf(
        small: _kInputNumberButtonHeightS,
        medium: _kInputNumberButtonHeight,
        large: _kInputNumberButtonHeightL,
      ),
    );
    TextAlign? align = widget.align;

    switch (widget.theme) {
      case TInputNumberTheme.column:
        align ??= TextAlign.center;
        break;
      case TInputNumberTheme.row:
        align ??= TextAlign.center;
        break;
      case TInputNumberTheme.normal:
        align ??= TextAlign.left;
    }
    Widget child = TSpace(
      spacing: 4,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.theme == TInputNumberTheme.row)
          TButton(
            disabled: _disabled || (_min != null && _current <= _min!),
            style: TButtonStyle(fixedSize: MaterialStatePropertyAll(buttonSize)),
            variant: TButtonVariant.outline,
            icon: TIcons.remove,
            onPressed: _handleRemove,
          ),
        Expanded(child: _buildInput(theme, align)),
        if (widget.theme == TInputNumberTheme.row)
          TButton(
            disabled: _disabled || (_max != null && _current >= _max!),
            style: TButtonStyle(fixedSize: MaterialStatePropertyAll(buttonSize)),
            variant: TButtonVariant.outline,
            icon: TIcons.add,
            onPressed: _handleAdd,
          ),
      ],
    );
    if (!widget.autoWidth) {
      child = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: size.sizeOf(small: _kInputNumberWidthS, medium: _kInputNumberWidth, large: _kInputNumberWidthL),
          maxWidth: size.sizeOf(small: _kInputNumberWidthS, medium: _kInputNumberWidth, large: _kInputNumberWidthL),
        ),
        child: child,
      );
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        if (widget.tips != null)
          DefaultTextStyle(
            style: TextStyle(
              fontFamily: theme.fontFamily,
              fontSize: theme.fontData.fontSizeS,
              color: tipsColor,
            ),
            child: widget.tips!,
          )
      ],
    );
  }

  /// 构建输入框
  Widget _buildInput(TThemeData theme, TextAlign textAlign) {
    var size = widget.size ?? theme.size;
    var buttonSize = Size(
      size.sizeOf(
        small: _kInputNumberRightButtonWidthS,
        medium: _kInputNumberRightButtonWidth,
        large: _kInputNumberRightButtonWidthL,
      ),
      size.sizeOf(
        small: _kInputNumberButtonColumnHeightS,
        medium: _kInputNumberButtonColumnHeight,
        large: _kInputNumberButtonColumnHeightL,
      ),
    );
    Widget? suffixIcon;
    if(widget.theme == TInputNumberTheme.column) {
      suffixIcon = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TButton(
            disabled: _disabled || (_min != null && _current <= _min!),
            style: TButtonStyle(fixedSize: MaterialStatePropertyAll(buttonSize)),
            radius: BorderRadius.zero,
            softWrap: true,
            onPressed: _handleRemove,
            child: MaterialStateWidget.resolveWith((states) {
              return Center(
                child: Icon(TIcons.chevronUp, size: size.sizeOf(
                  small: theme.fontData.fontSize,
                  medium: theme.fontData.fontSizeBase,
                  large: theme.fontData.fontSizeL,
                )),
              );
            }),
          ),
          const SizedBox(height: 2),
          TButton(
            disabled: _disabled || (_max != null && _current >= _max!),
            style: TButtonStyle(fixedSize: MaterialStatePropertyAll(buttonSize)),
            radius: BorderRadius.zero,
            softWrap: true,
            onPressed: _handleAdd,
            child: MaterialStateWidget.resolveWith((states) {
              return Center(
                child: Icon(TIcons.chevronDown, size: size.sizeOf(
                  small: theme.fontData.fontSize,
                  medium: theme.fontData.fontSizeBase,
                  large: theme.fontData.fontSizeL,
                )),
              );
            }),
          ),
        ],
      );
    }
    return TInput(
      disabled: _disabled,
      controller: _controller,
      focusNode: effectiveFocusNode,
      align: textAlign,
      size: size,
      onBlur: (text) {
        _handleFormat();
        widget.onBlur?.call();
      },
      onEnter: (text) => widget.onEnter?.call(),
      onFocus: (text) => widget.onFocus?.call(),
      onKeyDown: (text, event) => widget.onKeyDown?.call(),
      onMouseenter: widget.onMouseenter,
      onMouseleave: widget.onMouseleave,
      status: widget.status,
      suffix: widget.suffix,
      suffixIcon: suffixIcon,
      label: widget.label,
      placeholder: widget.placeholder,
      readonly: widget.readonly,
      restorationId: widget.restorationId,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      autofocus: widget.autofocus,
      autoWidth: widget.autoWidth,
      tips: widget.inputTips,
      scrollController: widget.scrollController,
      suffixPadding: widget.theme == TInputNumberTheme.column ? const EdgeInsets.only(right: 1) : null,
    );
  }

  /// 处理递增事件
  void _handleAdd() {
    _handle(handle: (number) => number + _step);
    widget.onChange?.call(formItemValue);
  }

  /// 处理递减事件
  void _handleRemove() {
    _handle(handle: (number) => number - _step);
    widget.onChange?.call(formItemValue);
  }

  /// 格式化字符串
  void _handleFormat() {
    _handle();
    widget.onChange?.call(formItemValue);
  }

  void _handle({Decimal Function(Decimal number)? handle, String? text}) {
    text ??= _controller.text;
    if (text.isNotEmpty) {
      var number = Decimal.tryParse(text);
      if (number != null) {
        var result = handle?.call(number) ?? number;
        if (_min != null && result < _min!) {
          result = _min!;
        } else if (_max != null && result > _max!) {
          result = _max!;
        }
        _controller.text = result.toString();
        _text = _controller.text;
        return;
      }
    }
    _handle(text: _text);
  }

  @override
  get formItemValue {
    if (_text.isEmpty) {
      return null;
    }
    if (T == int) {
      return int.parse(_text);
    } else if (T == double) {
      return double.parse(_text);
    } else if (T == num) {
      return num.parse(_text);
    }
    return _text;
  }

  @override
  void reset(TFormResetType type) {
    switch (type) {
      case TFormResetType.empty:
        _controller.text = '';
        _text = _controller.text;
        break;
      case TFormResetType.initial:
        _controller.text = widget.defaultValue?.toString() ?? '';
        _text = _controller.text;
        break;
    }
  }
}
