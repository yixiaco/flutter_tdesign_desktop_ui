import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

// const double _kInputHeightPaddingS = 4;
// const double _kInputHeightPaddingDefault = 7;
// const double _kInputHeightPaddingL = 9.5;
const double _kInputHeightS = 24;
const double _kInputHeightDefault = 32;
const double _kInputHeightL = 40;

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
    this.prefixLabels,
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
    this.align = TextAlign.left,
    this.onMouseenter,
    this.onMouseleave,
    this.scrollController,
    this.inputFormatters,
    this.keyboardType,
    this.restorationId,
    this.obscuringCharacter = '•',
    this.prefixPadding,
    this.suffixPadding,
    this.format,
    this.inputConstraints,
    this.breakLine = false,
  }) : super(key: key, name: name, focusNode: focusNode);

  /// 控制正在编辑的文本。
  /// 如果为null，此小部件将创建自己的[TextEditingController]并用[defaultValue]初始化其[TextEditingController.text]。
  final TextEditingController? controller;

  /// 输入框的默认值
  final String? defaultValue;

  /// 自动聚焦
  final bool autofocus;

  /// 是否只读
  final bool readonly;

  /// 是否可清空
  final bool clearable;

  /// 是否禁用输入框
  final bool disabled;

  /// 左侧文本
  final Widget? label;

  /// 用户最多可以输入的文本长度，一个中文等于一个计数长度。值小于等于 0 的时候，则表示不限制输入长度。
  final int? maxLength;

  /// 占位符
  final String? placeholder;

  /// 组件前置图标
  final Widget? prefixIcon;

  /// 多个前缀label
  final List<Widget>? prefixLabels;

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
  final Widget? tips;

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

  /// {@macro flutter.widgets.editableText.inputFormatters}
  final List<TextInputFormatter>? inputFormatters;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType? keyboardType;

  /// {@macro tdesign.components.inputBase.restorationId}
  final String? restorationId;

  /// {@macro flutter.widgets.editableText.obscuringCharacter}
  final String obscuringCharacter;

  /// 前缀内边距
  final EdgeInsetsGeometry? prefixPadding;

  /// 后缀内边距
  final EdgeInsetsGeometry? suffixPadding;

  /// 指定输入框展示值的格式
  final String Function(String text)? format;

  /// 输入框约束（不包含前缀、后缀）
  final BoxConstraints? inputConstraints;

  /// 可换行，前缀会、输入框在[Wrap]包装下换行，后缀单独居中显示
  final bool breakLine;

  @override
  TFormItemValidateState createState() => _TInputState();

  /// 默认border样式
  static MaterialStateProperty<BoxDecoration> defaultInputBorder({
    required BuildContext context,
    required bool disabled,
    TInputStatus status = TInputStatus.defaultStatus,
    TFormItemState? formItemState,
  }) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var inputTheme = TInputTheme.of(context);
    var onePx = 1 / MediaQuery.of(context).devicePixelRatio;
    // 边框样式
    return MaterialStateProperty.resolveWith((states) {
      List<BoxShadow>? shadows;
      Color color;
      switch (status) {
        case TInputStatus.defaultStatus:
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            shadows = [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 0,
                spreadRadius: 2,
                color: colorScheme.brandColorFocus,
                blurStyle: BlurStyle.outer,
              )
            ];
          }
          color = colorScheme.borderLevel2Color;
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed)) {
            color = colorScheme.brandColor;
          }
          if (states.contains(MaterialState.disabled)) {
            color = colorScheme.borderLevel2Color;
          }
          break;
        case TInputStatus.success:
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            shadows = [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 0,
                spreadRadius: 2,
                color: colorScheme.successColorFocus,
                blurStyle: BlurStyle.outer,
              )
            ];
          }
          color = colorScheme.successColor;
          if (states.contains(MaterialState.disabled) && states.contains(MaterialState.hovered)) {
            color = colorScheme.borderLevel2Color;
          }
          break;
        case TInputStatus.warning:
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            shadows = [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 0,
                spreadRadius: 2,
                color: colorScheme.warningColorFocus,
                blurStyle: BlurStyle.outer,
              )
            ];
          }
          color = colorScheme.warningColor;
          if (states.contains(MaterialState.disabled) && states.contains(MaterialState.hovered)) {
            color = colorScheme.borderLevel2Color;
          }
          break;
        case TInputStatus.error:
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            shadows = [
              BoxShadow(
                offset: const Offset(0, 0),
                blurRadius: 0,
                spreadRadius: 2,
                color: colorScheme.errorColorFocus,
                blurStyle: BlurStyle.outer,
              )
            ];
          }
          color = colorScheme.errorColor;
          if (states.contains(MaterialState.disabled) && states.contains(MaterialState.hovered)) {
            color = colorScheme.borderLevel2Color;
          }
          break;
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        shadows = formItemState?.shadows ?? inputTheme.boxShadow ?? shadows;
      }
      return BoxDecoration(
        backgroundBlendMode: BlendMode.src,
        border: Border.all(width: onePx, color: formItemState?.borderColor ?? inputTheme.borderColor ?? color),
        borderRadius: inputTheme.borderRadius ?? BorderRadius.circular(TVar.borderRadiusDefault),
        boxShadow: shadows,
        color: inputTheme.backgroundColor ??
            (disabled ? colorScheme.bgColorComponentDisabled : colorScheme.bgColorSpecialComponent),
      );
    });
  }
}

class _TInputState extends TFormItemValidateState<TInput> {
  FocusNode? _focusNode;

  FocusNode get effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  TextEditingController? _controller;

  late TextEditingController _formatController;

  /// 有效文本控制器
  TextEditingController get effectiveController =>
      widget.controller ?? (_controller ??= TextEditingController(text: widget.defaultValue));

  /// 是否拥有焦点
  bool _isFocused = false;

  /// 是否悬停
  bool _isHover = false;

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
    _formatController =
        TextEditingController(text: widget.format?.call(effectiveController.text) ?? effectiveController.text);
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
    _formatController.dispose();
    super.dispose();
  }

  /// 焦点变更事件
  void _focusChange() {
    setState(() {
      _isFocused = effectiveFocusNode.hasFocus;
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
      _formatController.text = widget.format?.call(effectiveController.text) ?? effectiveController.text;
      if (!widget.showClearIconOnEmpty && effectiveController.text.isEmpty) {
        showClearIcon.value = false;
      } else if (_isHover) {
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
    var cursor = TMaterialStateMouseCursor.textable;

    // 边框样式
    var border = TInput.defaultInputBorder(
      context: context,
      disabled: disabled,
      formItemState: formItemState,
      status: widget.status,
    );
    // tips颜色
    var tipsColor = widget.status.lazyValueOf(
      defaultStatus: () => colorScheme.textColorPlaceholder,
      success: () => colorScheme.successColor,
      warning: () => colorScheme.warningColor,
      error: () => colorScheme.errorColor,
    );
    // icon颜色
    var iconColor = widget.status.lazyValueOf(
      defaultStatus: () => _isFocused ? colorScheme.brandColor : colorScheme.borderLevel2Color,
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
        _buildClearIcon(colorScheme),
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
      prefixIconList.add(DefaultTextStyle(
        style: TextStyle(
          fontFamily: theme.fontFamily,
          fontSize: getFontSize(theme, size),
          color: disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
        ),
        child: widget.label!,
      ));
    }
    if (widget.prefixLabels != null) {
      prefixIconList.addAll(List.generate(widget.prefixLabels!.length, (index) {
        return DefaultTextStyle(
          style: TextStyle(
            fontFamily: theme.fontFamily,
            fontSize: getFontSize(theme, size),
            color: disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
            overflow: TextOverflow.ellipsis,
          ),
          child: widget.prefixLabels![index],
        );
      }));
    }
    prefixIconList = prefixIconList.where((element) => element != null).toList();

    suffixIconList.add(widget.suffixIcon);
    suffixIconList.add(widget.suffix);
    suffixIconList.removeWhere((element) => element == null);

    if (suffixIconList.isNotEmpty) {
      suffixIcon = IconTheme(
        data: const IconThemeData(size: 16),
        child: Padding(
          padding: widget.suffixPadding ?? const EdgeInsets.only(right: 8.0),
          child: TSpace(
            breakLine: true,
            spacing: 2,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: suffixIconList.reversed.toList(),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          onEnter: (event) {
            _handleHovered(true);
            widget.onMouseenter?.call(event);
          },
          onExit: (event) {
            _handleHovered(false);
            widget.onMouseleave?.call(event);
          },
          child: TInputBase(
            decorationBuilder: (decorationContext) {
              Widget? placeholder;
              if (decorationContext.controller.text.isEmpty) {
                placeholder = Text(
                  widget.placeholder ?? GlobalTDesignLocalizations.of(context).inputPlaceholder,
                  style: TextStyle(
                    fontFamily: theme.fontFamily,
                    fontSize: fontSize,
                    color: disabled ? colorScheme.textColorDisabled : colorScheme.textColorPlaceholder,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
              List<Widget> prefixList = List.generate(prefixIconList.length, (index) {
                var padding = (widget.prefixPadding ?? EdgeInsets.only(left: TVar.spacer, right: 2)) as EdgeInsets;
                var isFirst = index == 0;
                var isLast = index == prefixIconList.length - 1;
                return SizedBox(
                  height: _inputHeight(size),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: isFirst ? padding.left : 0, right: isLast ? padding.right : 0),
                        child: IconTheme(
                          data: IconThemeData(
                            size: 16,
                            color: widget.status.lazyValueOf(
                              defaultStatus: () => decorationContext.states.contains(MaterialState.focused)
                                  ? colorScheme.brandColor
                                  : colorScheme.borderLevel2Color,
                              success: () => colorScheme.successColor,
                              warning: () => colorScheme.warningColor,
                              error: () => colorScheme.errorColor,
                            ),
                          ),
                          child: prefixIconList[index]!,
                        ),
                      )
                    ],
                  ),
                );
              });
              if (widget.breakLine) {
                return _buildWrapDecoration(border, decorationContext, prefixList, size, placeholder, suffixIcon);
              }

              if (prefixList.isNotEmpty) {
                prefixIcon = Padding(
                  padding: widget.prefixPadding ?? EdgeInsets.only(left: TVar.spacer, right: 2),
                  child: TSpace(
                    breakLine: true,
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: prefixList,
                  ),
                );
              }
              return _buildRowDecoration(border, decorationContext, prefixIcon, decorationContext.states, colorScheme,
                  size, placeholder, suffixIcon);
            },
            obscuringCharacter: widget.obscuringCharacter,
            enabled: !disabled,
            controller: effectiveFocusNode.hasFocus || widget.format == null ? effectiveController : _formatController,
            autofocus: widget.autofocus,
            readOnly: widget.readonly,
            focusNode: effectiveFocusNode,
            cursorWidth: 1,
            inputFormatters: widget.inputFormatters,
            keyboardType: widget.keyboardType,
            restorationId: widget.restorationId,
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
            placeholder: widget.placeholder ?? GlobalTDesignLocalizations.of(context).inputPlaceholder,
            forceLine: !widget.autoWidth,
          ),
        ),
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

  Widget _buildWrapDecoration(MaterialStateProperty<BoxDecoration> border, TextDecorationContext decorationContext,
      List<Widget> prefixList, TComponentSize size, Widget? placeholder, Widget? suffixIcon) {
    var textDirection = Directionality.of(context);

    return Container(
      decoration: border.resolve(decorationContext.states),
      child: TDecorator(
        breakLine: true,
        autoWidth: widget.autoWidth,
        direction: textDirection,
        textAlign: widget.align,
        textBaseline: TextBaseline.alphabetic,
        suffix: suffixIcon,
        padding: EdgeInsets.symmetric(horizontal: TVar.spacer),
        placeholder: placeholder,
        input: ConstrainedBox(
          constraints: BoxConstraints(minWidth: _inputHeight(size)),
          child: decorationContext.child!,
        ),
        prefix: prefixList,
      ),
      // child: Row(
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Flexible(
      //       child: Padding(
      //         padding: EdgeInsets.only(left: TVar.spacerS),
      //         child: Wrap(
      //           spacing: 2,
      //           crossAxisAlignment: WrapCrossAlignment.center,
      //           children: [
      //             if (prefixList.isNotEmpty) ...prefixList,
      //             Padding(
      //               padding: EdgeInsets.symmetric(
      //                 horizontal: TVar.spacer,
      //               ),
      //               child: Stack(children: [
      //                 Container(
      //                   constraints: widget.inputConstraints,
      //                   child: decorationContext.child!,
      //                 ),
      //                 if (placeholder != null) placeholder,
      //               ]),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     if (suffixIcon != null) suffixIcon
      //   ],
      // ),
    );
  }

  Widget _buildRowDecoration(
      MaterialStateProperty<BoxDecoration> border,
      TextDecorationContext decorationContext,
      Widget? prefixIcon,
      Set<MaterialState> states,
      TColorScheme colorScheme,
      TComponentSize size,
      Widget? placeholder,
      Widget? suffixIcon) {
    return Container(
      height: _inputHeight(size),
      decoration: border.resolve(decorationContext.states),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prefixIcon != null) prefixIcon,
          Flexible(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: TVar.spacer),
              child: Stack(children: [
                Container(
                  constraints: widget.inputConstraints,
                  child: decorationContext.child!,
                ),
                if (placeholder != null) placeholder,
              ]),
            ),
          ),
          if (suffixIcon != null) suffixIcon
        ],
      ),
    );
  }

  double _inputHeight(TComponentSize size) => size.sizeOf(
        small: _kInputHeightS,
        medium: _kInputHeightDefault,
        large: _kInputHeightL,
      );

  /// 构建清空按钮
  Widget _buildClearIcon(TColorScheme colorScheme) {
    return MouseRegion(
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
    );
  }

  void _handleHovered(bool hovered) {
    if (_isHover != hovered) {
      setState(() {
        _isHover = hovered;
      });
      showClearIcon.value = hovered && (widget.showClearIconOnEmpty || effectiveController.text.isNotEmpty);
    }
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
