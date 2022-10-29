import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

typedef TInputNumberFormatCallback = String Function(String value, String? fixedNumber);

/// 数字输入框
/// 数字输入框由增加、减少按钮、数值输入组成。每次点击增加按钮（或减少按钮），数字增长（或减少）的量是恒定的。
class TInputNumber<T> extends TFormItemValidate {
  const TInputNumber({
    super.key,
    super.name,
    super.focusNode,
    this.align,
    this.autoWidth = false,
    this.decimalPlaces,
    this.disabled = false,
    this.format,
    this.label,
    this.max,
    this.min,
    this.placeholder,
    this.readonly = false,
    this.size,
    this.status,
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
    this.autocorrect = true,
  })  : assert(T == num || T == String || T == int || T == double);

  /// 文本内容位置，居左/居中/居右
  final TextAlign? align;

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 小数位数
  final int? decimalPlaces;

  /// 禁用组件
  final bool disabled;

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final TInputNumberFormatCallback? format;

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
  final TInputStatus? status;

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

  /// 自动修正值在[min]和[max]之间，并自动格式化不规范的字符串
  final bool autocorrect;

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
    if (widget.value != oldWidget.value && _text != widget.value) {
      _controller.text = widget.value?.toString() ?? '';
      _handle();
      _text = _controller.text;
      if (_text != widget.value) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          if (mounted) {
            _handleChange();
          }
        });
      }
    }
  }

  TInputStatus get status => formItemState?.inputStatus ?? widget.status ?? TInputStatus.defaultStatus;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? theme.size;
    // tips颜色
    var tipsColor = status.lazyValueOf(
      defaultStatus: () => colorScheme.textColorPlaceholder,
      success: () => colorScheme.successColor,
      warning: () => colorScheme.warningColor,
      error: () => colorScheme.errorColor,
    );
    Size? buttonSize;
    TButtonStyle buttonStyle;
    TextAlign? align = widget.align;
    Widget? suffixIcon;
    switch (widget.theme) {
      case TInputNumberTheme.column:
        align ??= TextAlign.center;
        buttonSize = Size(
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
        buttonStyle = TButtonStyle(
          fixedSize: MaterialStatePropertyAll(buttonSize),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused)) {
              return colorScheme.bgColorComponentHover;
            }
            return colorScheme.bgColorSecondaryContainer;
          }),
        );
        suffixIcon = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TButton(
              disabled: _disabled || (_max != null && _current >= _max!),
              style: buttonStyle,
              radius: const BorderRadius.only(topRight: Radius.circular(2)),
              softWrap: true,
              onPressed: _handleAdd,
              child: _buildRightIcon(colorScheme, size, theme, TIcons.chevronUp),
            ),
            const SizedBox(height: 2),
            TButton(
              disabled: _disabled || (_min != null && _current <= _min!),
              style: buttonStyle,
              radius: const BorderRadius.only(bottomRight: Radius.circular(2)),
              softWrap: true,
              onPressed: _handleRemove,
              child: _buildRightIcon(colorScheme, size, theme, TIcons.chevronDown),
            ),
          ],
        );
        break;
      case TInputNumberTheme.row:
        align ??= TextAlign.center;
        buttonSize = Size(
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
        break;
      case TInputNumberTheme.normal:
        align ??= TextAlign.left;
        break;
    }
    Widget child = TInputTheme(
      data: TInputThemeData(
        status: formItemState?.inputStatus,
        borderColor: formItemState?.borderColor,
        boxShadow: formItemState?.shadows,
      ),
      child: TInput(
        disabled: _disabled,
        controller: _controller,
        focusNode: effectiveFocusNode,
        align: align,
        size: size,
        onBlur: (text) {
          _handleFormat();
          widget.onBlur?.call();
        },
        format: widget.format != null ? (text) => widget.format!(text, _places(text)?.toString()) : null,
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
        keyboardType: widget.keyboardType,
        autofocus: widget.autofocus,
        autoWidth: widget.autoWidth,
        tips: widget.inputTips,
        scrollController: widget.scrollController,
        suffixPadding: widget.theme == TInputNumberTheme.column ? const EdgeInsets.only(right: 0) : null,
      ),
    );

    switch (widget.theme) {
      case TInputNumberTheme.column:
        break;
      case TInputNumberTheme.row:
        child = TSpace(
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
            Flexible(child: child),
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
        break;
      case TInputNumberTheme.normal:
    }

    if (!widget.autoWidth) {
      double minWidth;
      if (widget.theme == TInputNumberTheme.column) {
        minWidth = size.sizeOf(
            small: _kInputNumberRightWidthS, medium: _kInputNumberRightWidth, large: _kInputNumberRightWidthL);
      } else {
        minWidth = size.sizeOf(small: _kInputNumberWidthS, medium: _kInputNumberWidth, large: _kInputNumberWidthL);
      }
      child = ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: minWidth,
          maxWidth: minWidth,
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

  Widget _buildRightIcon(TColorScheme colorScheme, TComponentSize size, TThemeData theme, IconData icon) {
    return Builder(
      builder: (context) {
        var states = TMaterialStateScope.of(context)!;
        Color color = colorScheme.textColorSecondary;
        if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused)) {
          color = colorScheme.textColorPrimary;
        }
        if (states.contains(MaterialState.disabled)) {
          color = colorScheme.textColorDisabled;
        }
        return Center(
          child: Icon(
            icon,
            size: size.sizeOf(
              small: theme.fontData.fontSize,
              medium: theme.fontData.fontSizeBase,
              large: theme.fontData.fontSizeL,
            ),
            color: color,
          ),
        );
      }
    );
  }

  /// 处理递增事件
  void _handleAdd() {
    if (widget.readonly) {
      return;
    }
    if (_controller.text.isEmpty) {
      _controller.text = '0';
    }
    _handle(handle: (number) => number + _step);
    _handleChange();
  }

  /// 处理递减事件
  void _handleRemove() {
    if (widget.readonly) {
      return;
    }
    if (_controller.text.isEmpty) {
      _controller.text = '0';
    }
    _handle(handle: (number) => number - _step);
    _handleChange();
  }

  /// 格式化字符串
  void _handleFormat() {
    _handle();
    if (widget.value != _text) {
      _handleChange();
    }
  }

  void _handle({Decimal Function(Decimal number)? handle, String? text}) {
    text ??= _controller.text;
    if (text.isNotEmpty) {
      var number = Decimal.tryParse(text);
      if (number != null) {
        var result = handle?.call(number) ?? number;
        bool exceedMaximum = _max != null && result > _max!;
        bool belowMinimum = _min != null && result < _min!;
        if (belowMinimum && widget.autocorrect) {
          result = _min!;
        } else if (exceedMaximum && widget.autocorrect) {
          result = _max!;
        }
        if (widget.decimalPlaces != null) {
          result = result.floor(scale: widget.decimalPlaces!);
        }
        _controller.text = result.toString();
        _text = _controller.text;
        widget.onValidate?.call(exceedMaximum, belowMinimum);
        return;
      }
    }
    if (_text.isNotEmpty && widget.autocorrect) {
      _handle(text: _text);
    }
  }

  void _handleChange() {
    widget.onChange?.call(formItemValue);
    formChange();
  }

  Decimal? _places(String text) {
    if (text.isEmpty) {
      return null;
    }
    if (widget.decimalPlaces != null) {
      return Decimal.tryParse(text)?.floor(scale: widget.decimalPlaces!);
    }
    return null;
  }

  T? _format(String text) {
    if (text.isEmpty) {
      return null;
    }
    if (T == int) {
      return int.tryParse(text) as T?;
    } else if (T == double) {
      return double.tryParse(text) as T?;
    } else if (T == num) {
      return num.tryParse(text) as T?;
    }
    return text as T?;
  }

  @override
  FocusNode? get focusNode => effectiveFocusNode;

  @override
  get formItemValue {
    return _format(_text);
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
    widget.onChange?.call(formItemValue);
  }
}
