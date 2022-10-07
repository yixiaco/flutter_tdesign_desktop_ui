import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 作为[TForm]的子项
class TFormItem extends StatefulWidget {
  const TFormItem({
    Key? key,
    this.help,
    this.label,
    this.labelAlign,
    this.labelWidth,
    this.name,
    this.requiredMark,
    this.rules,
    this.showErrorMessage,
    this.statusIcon,
    this.showStatusIcon,
    this.successBorder = false,
  }) : super(key: key);

  /// 表单项说明内容
  final Widget? help;

  /// 字段标签名称
  final Widget? label;

  /// 表单字段标签对齐方式：左对齐、右对齐、顶部对齐。
  /// 默认使用 Form 的对齐方式，优先级高于 [TForm.labelAlign]。
  /// 可选项：left/right/top
  final TFormLabelAlign? labelAlign;

  /// 可以整体设置标签宽度，优先级高于 [TForm.labelWidth]
  final double? labelWidth;

  /// 表单字段名称
  final String? name;

  /// 是否显示必填符号（*），优先级高于 Form.requiredMark
  final bool? requiredMark;

  /// 表单字段校验规则
  final List<TFormRule>? rules;

  /// 校验不通过时，是否显示错误提示信息，优先级高于 Form.showErrorMessage
  final bool? showErrorMessage;

  /// 自定义校验状态图。
  final Widget? statusIcon;

  /// 显示校验状态图标，值为 true 显示默认图标，默认图标有 成功、失败、警告 等，不同的状态图标不同。
  /// [showStatusIcon] 值为 false，不显示图标
  final bool? showStatusIcon;

  /// 是否显示校验成功的边框，默认不显示
  final bool successBorder;

  @override
  State<TFormItem> createState() => _TFormItemState();
}

class _TFormItemState extends State<TFormItem> {
  TFormState? _formState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _formState = TForm.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
