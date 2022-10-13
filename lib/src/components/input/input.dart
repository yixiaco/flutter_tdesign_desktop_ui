import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 输入框
/// 用于承载用户信息录入的文本框，常用于表单、对话框等场景，对不同内容的信息录入，可拓展形成多种信息录入形式
class TInput extends TFormItemValidate {
  const TInput({
    Key? key,
    String? name,
    this.defaultValue,
    this.controller,
    this.autofocus = false,
    this.readonly = false,
    FocusNode? focusNode,
    this.clearable = false,
    this.disabled = false,
    this.label,
    this.maxLength,
    this.placeholder,
    this.prefixIcon,
    this.showClearIconOnEmpty = false,
    this.showLimitNumber = false,
    this.autoWidth = false,
    this.size,
    this.status = TInputStatus.defaultStatus,
    this.suffix,
    this.suffixIcon,
    this.tips,
    this.type = TInputType.text,
    this.onBlur,
    this.onChange,
    this.onClear,
    this.onEnter,
    this.onFocus,
    this.onKeyDown,
    this.align = TextAlign.start,
    this.onMouseenter,
    this.onMouseleave,
    this.scrollController,
  }) : super(key: key, name: name, focusNode: focusNode);

  /// 控制正在编辑的文本。
  /// 如果为null，此小部件将创建自己的[TextEditingController]并用[defaultValue]初始化其[TextEditingController.text]。
  final TextEditingController? controller;

  /// 输入框的默认值
  final String? defaultValue;

  /// 自动对焦
  final bool autofocus;

  /// 是否只读
  final bool readonly;

  /// 是否可清空
  final bool clearable;

  /// 是否禁用输入框
  final bool disabled;

  /// 左侧文本
  final String? label;

  /// 用户最多可以输入的最大字符数（Unicode 标量值）。
  /// 如果设置，字符计数器将显示在字段下方，显示已输入的字符数。如果设置为大于 0 的数字，它还将显示允许的最大数字。
  /// 如果设置为[TextField.noMaxLength]则仅显示当前字符数。
  /// 输入[maxLength]个字符后，将忽略其他输入，除非将[maxLengthEnforcement]设置为[MaxLengthEnforcement.none] 。
  /// 文本字段使用[LengthLimitingTextInputFormatter]强制执行长度，该长度在提供的inputFormatters （如果有）之后进行评估。
  /// 此值必须为 null、 TextField.noMaxLength或大于 0。如果为 null（默认值），则可以输入的字符数没有限制。如果设置为[TextField.noMaxLength] ，则不会强制执行任何限制，但仍会显示输入的字符数。
  /// 空白字符（例如换行符、空格、制表符）包含在字符计数中。
  /// 如果[maxLengthEnforcement]为[MaxLengthEnforcement.none] ，则可以输入超过[maxLength]个字符，但是当超出限制时，错误计数器和分隔符将切换到[decoration]的[InputDecoration.errorStyle]
  final int? maxLength;

  /// 占位符
  final String? placeholder;

  /// 组件前置图标
  final Widget? prefixIcon;

  /// 输入框内容为空时，悬浮状态是否显示清空按钮，默认不显示
  final bool showClearIconOnEmpty;

  /// 是否在右侧显示字数限制文本
  final bool showLimitNumber;

  /// 宽度随内容自适应
  final bool autoWidth;

  /// 输入框尺寸。可选项：small/medium/large. 参考[TComponentSize]
  /// 默认值为[TThemeData.size]
  final TComponentSize? size;

  /// 输入框状态。可选项：default/success/warning/error
  final TInputStatus status;

  /// 后置图标前的后置内容
  final Widget? suffix;

  /// 组件后置图标。
  final Widget? suffixIcon;

  /// 输入框下方提示文本，会根据不同的 status 呈现不同的样式。
  final String? tips;

  /// 输入框类型。可选项：text/password
  final TInputType type;

  /// 失去焦点时触发
  final TInputCallBack? onBlur;

  /// 输入框值发生变化时触发
  final TInputCallBack? onChange;

  /// 清空按钮点击时触发
  final TCallback? onClear;

  /// 回车键按下时触发
  final TInputCallBack? onEnter;

  /// 获得焦点时触发
  final TInputCallBack? onFocus;

  /// 键盘按下时触发
  final TInputKeyEvent? onKeyDown;

  /// 文本对齐方式
  final TextAlign align;

  /// 鼠标进入事件
  final PointerEnterEventListener? onMouseenter;

  /// 鼠标离开事件
  final PointerExitEventListener? onMouseleave;

  /// 滚动控制器
  final ScrollController? scrollController;

  @override
  TFormItemValidateState createState() => _TInputState();
}

class _TInputState extends TFormItemValidateState<TInput> {
  FocusNode? _focusNode;

  FocusNode get effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController? _controller;

  /// 有效文本控制器
  TextEditingController get effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController(text: widget.defaultValue));

  /// 是否拥有焦点
  bool isFocused = false;

  /// 是否悬停
  bool isHover = false;

  /// 是否临时查看密码
  bool look = false;

  late ValueNotifier<bool> showClearIcon;

  /// 缓存旧字符串
  String? _text;

  /// 组件禁用状态
  bool get disabled => formDisabled || widget.disabled;

  @override
  void initState() {
    _text = effectiveController.text;
    showClearIcon = ValueNotifier(false);
    effectiveFocusNode.onKeyEvent = _onKeyEvent;
    effectiveFocusNode.addListener(_focusChange);
    effectiveController.addListener(_textChange);
    super.initState();
  }

  KeyEventResult _onKeyEvent(FocusNode node, KeyEvent event) {
    widget.onKeyDown?.call(effectiveController.text, event);
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _text = null;
    showClearIcon.dispose();
    effectiveFocusNode.onKeyEvent = null;
    effectiveFocusNode.removeListener(_focusChange);
    effectiveController.removeListener(_textChange);
    _focusNode?.dispose();
    _controller?.dispose();
    super.dispose();
  }

  /// 焦点变更事件
  void _focusChange() {
    setState(() {
      isFocused = effectiveFocusNode.hasFocus;
    });
    if (effectiveFocusNode.hasFocus) {
      widget.onFocus?.call(effectiveController.text);
    } else {
      widget.onBlur?.call(effectiveController.text);
    }
  }

  /// 文本发生变化时触发
  void _textChange() {
    if (_text != effectiveController.text) {
      _text = effectiveController.text;
      if (!widget.showClearIconOnEmpty && effectiveController.text.isEmpty) {
        showClearIcon.value = false;
      } else if (isHover) {
        showClearIcon.value = true;
      }
      formItemState?.validate(trigger: TFormRuleTrigger.change);
      widget.onChange?.call(effectiveController.text);
    }
  }

  @override
  void didUpdateWidget(TInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_focusChange);
      (widget.focusNode ?? _focusNode)?.addListener(_focusChange);
    }
    if (widget.controller != oldWidget.controller) {
      (oldWidget.controller ?? _controller)?.removeListener(_textChange);
      (widget.controller ?? _controller)?.addListener(_textChange);
    }
    effectiveFocusNode.onKeyEvent = _onKeyEvent;
  }

  static double inputHeightS = 4;
  static double inputHeightDefault = 7;
  static double inputHeightL = 9;

  /// 获取字体大小
  double getFontSize(TThemeData theme, TComponentSize size) {
    return size.sizeOf(
      small: theme.fontData.fontSizeS,
      medium: theme.fontData.fontSizeBase,
      large: theme.fontData.fontSizeL,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var inputTheme = TInputTheme.of(context);
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? inputTheme.size ?? theme.size;

    var fontSize = getFontSize(theme, size);
    MouseCursor? cursor;
    if (disabled) {
      cursor = SystemMouseCursors.noDrop;
    } else if (widget.readonly) {
      cursor = SystemMouseCursors.click;
    }
    var onePx = 1 / MediaQuery.of(context).devicePixelRatio;

    // 边框样式
    var border = MaterialStateProperty.resolveWith((states) {
      List<BoxShadow>? shadows;
      Color color = widget.status.lazyValueOf(
        defaultStatus: () {
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.borderLevel2Color;
          }
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            shadows = formItemState?.shadows ??
                [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 0,
                    spreadRadius: 2,
                    color: colorScheme.brandColorFocus,
                    blurStyle: BlurStyle.outer,
                  )
                ];
          }
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed)) {
            return colorScheme.brandColor;
          }
          return colorScheme.borderLevel2Color;
        },
        success: () {
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            shadows = formItemState?.shadows ??
                [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 0,
                    spreadRadius: 2,
                    color: colorScheme.successColorFocus,
                    blurStyle: BlurStyle.outer,
                  )
                ];
          }
          return colorScheme.successColor;
        },
        warning: () {
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            shadows = formItemState?.shadows ??
                [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 0,
                    spreadRadius: 2,
                    color: colorScheme.warningColorFocus,
                    blurStyle: BlurStyle.outer,
                  )
                ];
          }
          return colorScheme.warningColor;
        },
        error: () {
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            shadows = formItemState?.shadows ??
                [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 0,
                    spreadRadius: 2,
                    color: colorScheme.errorColorFocus,
                    blurStyle: BlurStyle.outer,
                  )
                ];
          }
          return colorScheme.errorColor;
        },
      );
      return BoxDecoration(
        backgroundBlendMode: BlendMode.src,
        border: Border.all(width: onePx, color: formItemState?.borderColor ?? color),
        borderRadius: inputTheme.borderRadius ?? BorderRadius.circular(TVar.borderRadiusDefault),
        boxShadow: shadows,
        color: inputTheme.backgroundColor ??
            (disabled ? colorScheme.bgColorComponentDisabled : colorScheme.bgColorSpecialComponent),
      );
    });
    // tips颜色
    var tipsColor = widget.status.lazyValueOf(
      defaultStatus: () => colorScheme.textColorPlaceholder,
      success: () => colorScheme.successColor,
      warning: () => colorScheme.warningColor,
      error: () => colorScheme.errorColor,
    );
    // icon颜色
    var iconColor = widget.status.lazyValueOf(
      defaultStatus: () => isFocused ? colorScheme.brandColor : colorScheme.borderLevel2Color,
      success: () => colorScheme.successColor,
      warning: () => colorScheme.warningColor,
      error: () => colorScheme.errorColor,
    );

    List<Widget?> prefixIconList = [];
    List<Widget?> suffixIconList = [];
    Widget? prefixIcon;
    Widget? suffixIcon;

    if (widget.prefixIcon != null) {
      prefixIconList.add(widget.prefixIcon);
    }
    // 密码框icon
    if (widget.type == TInputType.password) {
      if (widget.prefixIcon == null) {
        prefixIconList.add(Icon(TIcons.lockOn, color: iconColor));
      }
      suffixIconList.add(
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => setState(() {
              look = !look;
            }),
            child: Icon(look ? TIcons.browse : TIcons.browseOff, color: colorScheme.textColorPlaceholder),
          ),
        ),
      );
    }

    // 可清理icon
    if (widget.clearable) {
      suffixIconList.add(
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              effectiveController.clear();
              widget.onClear?.call();
            },
            child: ValueListenableBuilder<bool>(
              valueListenable: showClearIcon,
              builder: (context, value, child) {
                return Visibility(
                  visible: value,
                  child: Icon(TIcons.closeCircleFilled, color: colorScheme.textColorPlaceholder),
                );
              },
            ),
          ),
        ),
      );
    }

    // maxLength
    if (widget.maxLength != null && widget.maxLength! > 0 && widget.showLimitNumber) {
      suffixIconList.add(
        AnimatedBuilder(
          animation: effectiveController,
          builder: (BuildContext context, Widget? child) {
            return Text(
              '${effectiveController.text.length}/${widget.maxLength}',
              style: theme.fontData.fontBodyMedium.merge(TextStyle(
                color: colorScheme.textColorPlaceholder,
              )),
            );
          },
        ),
      );
    }

    // label
    if (widget.label != null) {
      prefixIconList.add(Text(
        widget.label!,
        style: TextStyle(
          fontFamily: theme.fontFamily,
          fontSize: getFontSize(theme, size),
          color: disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
        ),
      ));
    }
    if (prefixIconList.isNotEmpty) {
      prefixIcon = Padding(
        padding: const EdgeInsets.only(left: 8, right: 2),
        child: TSpace(
          breakLine: true,
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: prefixIconList,
        ),
      );
    }

    suffixIconList.add(widget.suffixIcon);
    suffixIconList.add(widget.suffix);

    if (suffixIconList.isNotEmpty) {
      suffixIcon = Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: TSpace(
          breakLine: true,
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: suffixIconList.reversed.toList(),
        ),
      );
    }

    return MouseRegion(
      onEnter: (event) {
        isHover = true;
        showClearIcon.value = widget.showClearIconOnEmpty || effectiveController.text.isNotEmpty;
        widget.onMouseenter?.call(event);
      },
      onExit: (event) {
        isHover = false;
        showClearIcon.value = false;
        widget.onMouseleave?.call(event);
      },
      child: TInputBox(
        enabled: !disabled,
        controller: effectiveController,
        autofocus: widget.autofocus,
        readOnly: widget.readonly,
        focusNode: effectiveFocusNode,
        cursorWidth: 1,
        style: TextStyle(
          fontFamily: theme.fontFamily,
          fontSize: fontSize,
          color: disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
        ),
        cursorColor: colorScheme.textColorPrimary,
        selectionColor: colorScheme.brandColor5,
        textAlign: widget.align,
        mouseCursor: cursor,
        keyboardAppearance: theme.brightness,
        maxLength: widget.maxLength ?? inputTheme.maxLength,
        obscureText: widget.type == TInputType.password && !look,
        textAlignVertical: TextAlignVertical.center,
        scrollController: widget.scrollController,
        onSubmitted: (value) {
          if (widget.onEnter == null) {
            TForm.of(context)?.submit();
          } else {
            widget.onEnter?.call(value);
          }
        },
        border: border,
        placeholder: widget.placeholder ?? GlobalTDesignLocalizations.of(context).inputPlaceholder,
        placeholderStyle: MaterialStatePropertyAll(TextStyle(
          fontFamily: theme.fontFamily,
          fontSize: fontSize,
          color: disabled ? colorScheme.textColorDisabled : colorScheme.textColorPlaceholder,
        )),
        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
          vertical: size.sizeOf(small: inputHeightS, medium: inputHeightDefault, large: inputHeightL),
          horizontal: 8,
        )),
        tips: MaterialStateProperty.resolveWith((states) {
          if (widget.tips == null) return null;
          return Text(
            widget.tips!,
            style: TextStyle(
              fontFamily: theme.fontFamily,
              fontSize: theme.fontData.fontSizeS,
              color: tipsColor,
            ),
          );
        }),
        prefix: MaterialStateProperty.resolveWith((states) {
          if (prefixIcon == null) return null;
          return IconTheme(
            data: IconThemeData(
                size: 16,
                color: widget.status.lazyValueOf(
                  defaultStatus: () =>
                      states.contains(MaterialState.focused) ? colorScheme.brandColor : colorScheme.borderLevel2Color,
                  success: () => colorScheme.successColor,
                  warning: () => colorScheme.warningColor,
                  error: () => colorScheme.errorColor,
                )),
            child: prefixIcon,
          );
        }),
        suffix: MaterialStateProperty.resolveWith((states) {
          if (suffixIcon == null) return null;
          return IconTheme(
            data: const IconThemeData(size: 16),
            child: suffixIcon,
          );
        }),
        forceLine: !widget.autoWidth,
      ),
    );
  }

  @override
  FocusNode? get focusNode => effectiveFocusNode;

  @override
  get formItemValue => effectiveController.text;

  @override
  void reset(TFormResetType type) {
    switch (type) {
      case TFormResetType.empty:
        effectiveController.text = '';
        break;
      case TFormResetType.initial:
        effectiveController.text = widget.defaultValue ?? '';
        break;
    }
  }
}
