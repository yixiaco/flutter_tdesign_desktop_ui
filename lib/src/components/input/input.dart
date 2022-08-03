import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

typedef InputCallBack = TConsumer<String>;

/// 输入框
class TInput extends StatefulWidget {
  const TInput({
    Key? key,
    this.initialValue,
    this.controller,
    this.autofocus = false,
    this.readonly = false,
    this.focusNode,
    this.clearable = false,
    this.disabled = false,
    this.label,
    this.maxLength,
    this.name,
    this.placeholder,
    this.prefixIcon,
    this.showClearIconOnEmpty = false,
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
  }) : super(key: key);

  /// 控制正在编辑的文本。
  /// 如果为null，此小部件将创建自己的[TextEditingController]并用[initialValue]初始化其[TextEditingController.text]。
  final TextEditingController? controller;

  /// 创建包含TextField的FormField。 指定控制器时，initialValue必须为null（默认值）。
  /// 如果控制器为空，则将自动构造TextEditingController，并将其文本初始化为initialValue或空字符串。
  /// 有关各种参数的文档，请参阅[TextField]类和[TextField]。
  final String? initialValue;

  /// 自动对焦
  final bool autofocus;

  /// 是否只读
  final bool readonly;

  /// 焦点
  final FocusNode? focusNode;

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

  /// 名称
  final String? name;

  /// 占位符
  final String? placeholder;

  /// 组件前置图标
  final Widget? prefixIcon;

  /// 输入框内容为空时，悬浮状态是否显示清空按钮，默认不显示
  final bool showClearIconOnEmpty;

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
  final InputCallBack? onBlur;

  /// 输入框值发生变化时触发
  final InputCallBack? onChange;

  /// 清空按钮点击时触发
  final TCallback? onClear;

  /// 回车键按下时触发
  final InputCallBack? onEnter;

  /// 获得焦点时触发
  final InputCallBack? onFocus;

  /// 键盘按下时触发
  final InputCallBack? onKeyDown;

  /// 文本对齐方式
  final TextAlign align;

  @override
  State<TInput> createState() => _TInputState();
}

class _TInputState extends State<TInput> {
  var formFieldState = GlobalKey<FormFieldState<TextFormField>>();

  FocusNode? _focusNode;

  FocusNode get effectiveFocusNode => widget.focusNode ?? (_focusNode ??= FocusNode());

  bool isFocused = false;

  /// 是否临时查看密码
  bool look = false;

  @override
  void initState() {
    effectiveFocusNode.addListener(_focusChange);
    super.initState();
  }

  @override
  void dispose() {
    effectiveFocusNode.dispose();
    super.dispose();
  }

  /// 焦点变更事件
  void _focusChange() {
    setState(() {
      isFocused = effectiveFocusNode.hasFocus;
    });
  }

  @override
  void didUpdateWidget(TInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      (oldWidget.focusNode ?? _focusNode)?.removeListener(_focusChange);
      (widget.focusNode ?? _focusNode)?.addListener(_focusChange);
    }
  }

  static double inputHeightS = ThemeDataConstant.spacer * 0.8;
  static double inputHeightDefault = ThemeDataConstant.spacer * 1.2;
  static double inputHeightL = ThemeDataConstant.spacer * 2.5;

  /// 默认装饰器
  InputDecoration defaultDecoration(TComponentSize size) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var onePx = 1 / MediaQuery.of(context).devicePixelRatio;

    // 边框样式
    var border = MaterialStateOutlineInputBorder.resolveWith((states) {
      Color color = widget.status.lazyValueOf(
        defaultStatus: () {
          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            return colorScheme.brandColor;
          }
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.borderLevel2Color;
          }
          return colorScheme.borderLevel2Color;
        },
        success: () {
          return colorScheme.successColor;
        },
        warning: () {
          return colorScheme.warningColor;
        },
        error: () {
          return colorScheme.errorColor;
        },
      );
      return inputBorder(onePx, color);
    });

    // 填充背景色
    var fillColor = widget.disabled ? colorScheme.bgColorComponentDisabled : colorScheme.bgColorSpecialComponent;
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
    Widget? prefixIcon;
    Widget? suffixIcon;
    if (widget.type == TInputType.password) {
      prefixIcon = Icon(TIcons.lockOn, size: 15, color: iconColor);
      suffixIcon = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => setState(() {
            look = !look;
          }),
          child: Icon(look ? TIcons.browse : TIcons.browseOff, size: 15, color: colorScheme.borderLevel2Color),
        ),
      );
    }

    // label
    if (widget.label != null) {
      var fontSize = getFontSize(size);

      var label = Text(
        '价格：',
        style: TextStyle(
          fontFamily: theme.fontFamily,
          fontSize: fontSize,
          color: widget.disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
        ),
      );
      if (prefixIcon == null) {
        prefixIcon = label;
      } else {
        prefixIcon = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            prefixIcon,
            const SizedBox(width: 2),
            label,
          ],
        );
      }
    }
    return InputDecoration(
      hintStyle: TextStyle(
        fontFamily: theme.fontFamily,
        color: widget.disabled ? colorScheme.textColorDisabled : colorScheme.textColorPlaceholder,
      ),
      hintText: widget.placeholder,
      border: border,
      contentPadding: EdgeInsets.symmetric(
        vertical: size.sizeOf(small: inputHeightS, medium: inputHeightDefault, large: inputHeightL),
        horizontal: 8,
      ),
      isDense: true,
      enabled: !widget.disabled,
      fillColor: fillColor,
      hoverColor: fillColor,
      filled: true,
      helperText: widget.tips,
      helperStyle: TextStyle(
        fontFamily: theme.fontFamily,
        fontSize: ThemeDataConstant.fontSizeS,
        color: tipsColor,
        height: 0.5, // 通过压缩字体的高度，实现tips的高度缩小
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 8, right: 2),
        child: prefixIcon,
      ),
      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: widget.suffixIcon ?? suffixIcon,
      ),
      suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      suffix: widget.suffix,
    );
  }

  /// 获取字体大小
  double getFontSize(TComponentSize size) {
    return size.sizeOf(
      small: ThemeDataConstant.fontSizeS,
      medium: ThemeDataConstant.fontSizeBase,
      large: ThemeDataConstant.fontSizeL,
    );
  }

  OutlineInputBorder inputBorder(double width, Color color) {
    return OutlineInputBorder(
      borderSide: BorderSide(width: width, color: color),
      borderRadius: BorderRadius.circular(ThemeDataConstant.borderRadius),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var inputTheme = TInputTheme.of(context);
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? inputTheme.size ?? theme.size;

    var fontSize = getFontSize(size);
    MouseCursor? cursor;
    if (widget.disabled) {
      cursor = SystemMouseCursors.noDrop;
    } else if (widget.readonly) {
      cursor = SystemMouseCursors.click;
    }
    return TextFormField(
      key: formFieldState,
      controller: widget.controller,
      initialValue: widget.initialValue,
      autofocus: widget.autofocus,
      readOnly: widget.readonly,
      focusNode: effectiveFocusNode,
      decoration: inputTheme.decoration ?? defaultDecoration(size),
      cursorColor: colorScheme.textColorPrimary,
      cursorWidth: 1,
      style: TextStyle(
        fontFamily: theme.fontFamily,
        fontSize: fontSize,
        textBaseline: TextBaseline.alphabetic,
        color: widget.disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
      ),
      textAlign: widget.align,
      mouseCursor: cursor,
      keyboardAppearance: theme.brightness,
      maxLength: widget.maxLength ?? inputTheme.maxLength,
      obscureText: widget.type == TInputType.password && !look,
      textAlignVertical: TextAlignVertical.center,
    );
  }
}
