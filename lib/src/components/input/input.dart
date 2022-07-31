import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

typedef InputCallBack = void Function(String value);

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
    this.maxCharacter,
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

  /// 用户最多可以输入的字符个数，一个中文汉字表示两个字符长度。[maxCharacter] 和 [maxlength] 二选一使用
  final int? maxCharacter;

  /// 用户最多可以输入的文本长度，一个中文等于一个计数长度。值小于等于 0 的时候，则表示不限制输入长度。
  /// [maxCharacter] 和 [maxLength] 二选一使用
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
  final Function()? onClear;

  /// 回车键按下时触发
  final InputCallBack? onEnter;

  /// 获得焦点时触发
  final InputCallBack? onFocus;

  /// 键盘按下时触发
  final InputCallBack? onKeyDown;

  @override
  State<TInput> createState() => _TInputState();
}

class _TInputState extends State<TInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 默认装饰器
  InputDecoration defaultDecoration() {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    return InputDecoration(
      hintText: widget.placeholder,
      border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: colorScheme.borderLevel2Color)),
      focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: colorScheme.brandColor)),
      errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: colorScheme.errorColor)),
      focusColor: colorScheme.warningColor,
      hoverColor: colorScheme.warningColor,
      // isCollapsed: true,
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      isDense: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    return TextFormField(
      controller: widget.controller,
      initialValue: widget.initialValue,
      autofocus: widget.autofocus,
      readOnly: widget.readonly,
      focusNode: widget.focusNode,
      decoration: defaultDecoration(),
      cursorColor: colorScheme.textColorPrimary,
      cursorWidth: 1,
    );
  }
}
