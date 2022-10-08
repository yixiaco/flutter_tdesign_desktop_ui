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
    required this.child,
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

  /// 子组件
  final Widget child;

  @override
  State<TFormItem> createState() => TFormItemState();
}

class TFormItemState extends State<TFormItem> {
  TFormState? _formState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _formState = TForm.of(context);
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var labelAlign = widget.labelAlign ?? _formState?.widget.labelAlign ?? TFormLabelAlign.right;
    Widget? label = _buildLabel(theme, colorScheme, labelAlign);

    Widget child;
    if (labelAlign == TFormLabelAlign.top) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) label,
          widget.child,
        ],
      );
    } else {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) label,
          Flexible(child: widget.child),
        ],
      );
    }
    return _TFormItemScope(
      formState: this,
      child: child,
    );
  }

  /// 构建label
  Widget? _buildLabel(TThemeData theme, TColorScheme colorScheme, TFormLabelAlign labelAlign) {
    var labelWidth = widget.labelWidth ?? _formState?.widget.labelWidth ?? 0;
    var colon = _formState?.widget.colon ?? false;
    Widget? child;
    if (widget.label != null) {
      Widget? before;
      Widget? after;

      // 必填
      bool requiredMark = widget.requiredMark ?? _formState?.widget.requiredMark ?? false;
      if (requiredMark && existRequired()) {
        before = Padding(
          padding: EdgeInsets.only(right: TVar.spacer / 2),
          child: Text('*', style: TextStyle(color: colorScheme.errorColor)),
        );
      }
      // 冒号
      if (colon) {
        after = const Text(':');
      }

      MainAxisAlignment mainAxisAlignment;
      switch (labelAlign) {
        case TFormLabelAlign.left:
          mainAxisAlignment = MainAxisAlignment.start;
          break;
        case TFormLabelAlign.right:
          mainAxisAlignment = MainAxisAlignment.end;
          break;
        case TFormLabelAlign.top:
          mainAxisAlignment = MainAxisAlignment.start;
          break;
      }
      child = DefaultTextStyle(
        style: theme.fontData.fontBodyMedium.merge(
          TextStyle(color: colorScheme.textColorPrimary),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: mainAxisAlignment,
          children: [
            if (before != null) before,
            widget.label!,
            if (after != null) after,
          ],
        ),
      );
    }
    return Container(
      width: labelWidth,
      height: 32,
      padding: EdgeInsets.only(right: TVar.spacer3),
      child: child,
    );
  }

  /// 是否存在必填项
  bool existRequired() {
    var rules = _rules();
    return rules.any((rule) => rule.required == true);
  }

  /// 校验规则
  List<TFormRule> _rules() {
    var rules = widget.rules ?? [];
    if (widget.name != null) {
      var formRules = _formState?.widget.rules?[widget.name];
      if (formRules != null) {
        rules.addAll(formRules);
      }
    }
    return rules;
  }
}

class _TFormItemScope extends InheritedWidget {
  const _TFormItemScope({
    required super.child,
    required TFormItemState formState,
  }) : _formItemState = formState;

  final TFormItemState _formItemState;

  /// The [TForm] associated with this widget.
  TFormItem get formItem => _formItemState.widget;

  @override
  bool updateShouldNotify(_TFormItemScope old) => formItem.name != old.formItem.name;
}
