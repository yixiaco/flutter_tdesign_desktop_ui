import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 作为[TForm]的子项
class TFormItem extends StatefulWidget {
  const TFormItem({
    Key? key,
    this.help,
    this.label,
    this.labelText,
    this.showLabel = true,
    this.labelAlign,
    this.labelWidth,
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

  /// 校验字段时，显示的标签名称
  /// 当[label]为空时，默认值为该文本
  final String? labelText;

  /// 是否显示label标签
  final bool showLabel;

  /// 表单字段标签对齐方式：左对齐、右对齐、顶部对齐。
  /// 默认使用 Form 的对齐方式，优先级高于 [TForm.labelAlign]。
  /// 可选项：left/right/top
  final TFormLabelAlign? labelAlign;

  /// 可以整体设置标签宽度，优先级高于 [TForm.labelWidth]
  final double? labelWidth;

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

  static TFormItemState? of(BuildContext context) {
    final _TFormItemScope? scope = context.dependOnInheritedWidgetOfExactType<_TFormItemScope>();
    return scope?._formItemState;
  }

  @override
  State<TFormItem> createState() => TFormItemState();
}

class TFormItemState extends State<TFormItem> {
  TFormState? _formState;
  TFormItemValidateState? _field;
  Color? _borderColor;
  List<BoxShadow>? _shadows;

  /// 错误消息
  TFormItemValidateMessage? _message;

  /// 边框颜色
  Color? get borderColor => _borderColor;

  /// 边框阴影
  List<BoxShadow>? get shadows => _shadows;

  /// 当前注册组件值
  dynamic get value => _field?.value;

  /// 当前注册组件名称
  String? get name => _field?.widget.name;

  @override
  void initState() {
    super.initState();
  }

  /// 注册表单字段项
  void register(String name, TFormItemValidateState field) {
    _field?.focusNode?.removeListener(focusChange);
    _field = field;
    _field?.focusNode?.addListener(focusChange);
    _formState?.register(name, this);
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        setState(() {});
      });
    } else {
      setState(() {});
    }
  }

  void focusChange() {}

  /// 注销表单字段项
  void unregister(String name) {
    _field?.focusNode?.removeListener(focusChange);
    _field = null;
    _formState?.unregister(name);
  }

  @override
  void didChangeDependencies() {
    _formState = TForm.of(context);
    super.didChangeDependencies();
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
    if(!widget.showLabel) {
      return null;
    }
    var labelWidth = widget.labelWidth ?? _formState?.widget.labelWidth ?? 0;
    var colon = _formState?.widget.colon ?? false;
    Widget? child;
    if ((widget.label != null || widget.labelText != null)) {
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
        after = Padding(
          padding: EdgeInsets.only(right: TVar.spacer, left: TVar.spacer / 4),
          child: const Text(':'),
        );
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
            widget.label ?? Text(widget.labelText!),
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
    if (name != null) {
      var formRules = _formState?.widget.rules?[name!];
      if (formRules != null) {
        rules.addAll(formRules);
      }
    }
    return rules;
  }

  /// 清空校验结果。可使用 fields 指定清除部分字段的校验结果，fields 值为空则表示清除所有字段校验结果。
  /// 清除邮箱校验结果示例：clearValidate(['email'])
  void clearValidate() {
    setState(() {
      _message = null;
      _borderColor = null;
      _shadows = null;
    });
  }

  /// 重置表单，表单里面没有重置按钮TButton(type: TButtonType.reset)时可以使用该方法，默认重置全部字段为空，该方法会触发 reset 事件。
  /// 如果表单属性 resetType=TFormResetType.empty 或 type=TFormResetType.empty 会重置为空；
  /// 如果表单属性 resetType=TFormResetType.initial 或者 type=TFormResetType.initial 会重置为表单初始值。
  /// [fields] 用于设置具体重置哪些字段，示例：reset({ type: TFormResetType.initial, fields: ['name', 'age'] })
  void reset(TFormResetType type) {
    setState(() {
      clearValidate();
      _field?.reset(type);
    });
  }

  /// 设置自定义校验结果，如远程校验信息直接呈现。
  void setValidateMessage(TFormItemValidateMessage message) {
    setState(() {
      _message = message;
      switch (_message!.type) {
        case TFormRuleType.error:
          _setStatus(error: true);
          break;
        case TFormRuleType.warning:
          _setStatus(warning: true);
          break;
      }
    });
  }

  /// 校验函数，包含错误文本提示等功能。
  /// 【关于参数】params.fields 表示校验字段，如果设置了 fields，本次校验将仅对这些字段进行校验。
  /// params.trigger 表示本次触发校验的范围，'params.trigger = blur' 表示只触发校验规则设定为 trigger='blur' 的字段，
  /// 'params.trigger = change' 表示只触发校验规则设定为 trigger='change' 的字段，默认触发全范围校验。
  /// params.showErrorMessage 表示校验结束后是否显
  /// 示错误文本提示，默认显示。
  /// 【关于返回值】返回值为 true 表示校验通过；如果校验不通过，返回值为校验结果列表
  TFormItemValidateResult validate({TFormRuleTrigger? trigger, bool? showErrorMessage}) {
    showErrorMessage ??= widget.showErrorMessage ?? _formState?.widget.showErrorMessage ?? true;
    var result = validateOnly(trigger);
    if (!result.validate) {
      setValidateMessage(TFormItemValidateMessage(
        type: result.type!,
        message: showErrorMessage ? result.errorMessage! : null,
      ));
    } else {
      setState(() {
        _setStatus(success: widget.successBorder);
      });
    }
    return result;
  }

  /// 纯净的校验函数，仅返回校验结果，不对组件进行任何操作
  TFormItemValidateResult validateOnly(TFormRuleTrigger? trigger) {
    var rules = _rules();
    var errorMessage = _formState?.widget.errorMessage;
    var validator = Validator(
        name: widget.labelText ?? '', rules: rules, value: value, errorMessage: errorMessage, context: context);
    return validator.validate(trigger);
  }

  /// 设置状态值
  void _setStatus({bool error = false, bool warning = false, bool success = false}) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    Color? shadowColor;
    if (success) {
      _borderColor = colorScheme.successColor;
      shadowColor = colorScheme.successColorFocus;
    } else if (warning) {
      _borderColor = colorScheme.warningColor;
      shadowColor = colorScheme.warningColorFocus;
    } else if (error) {
      _borderColor = colorScheme.errorColor;
      shadowColor = colorScheme.errorColorFocus;
    }
    if (shadowColor != null) {
      _shadows = [
        BoxShadow(
          offset: const Offset(0, 0),
          blurRadius: 0,
          spreadRadius: 2,
          color: shadowColor,
        )
      ];
    }
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
  bool updateShouldNotify(_TFormItemScope old) => _formItemState != old._formItemState;
}

abstract class TFormItemValidate extends StatefulWidget {
  const TFormItemValidate({
    Key? key,
    this.name,
    this.focusNode,
  }) : super(key: key);

  /// 表单字段名称
  final String? name;

  /// 焦点
  final FocusNode? focusNode;

  @override
  TFormItemValidateState createState();
}

/// 注册表单项验证结果通知
abstract class TFormItemValidateState<T extends TFormItemValidate> extends State<T> {
  /// 当前值
  dynamic get value;

  /// 如果存在焦点
  FocusNode? get focusNode => widget.focusNode;

  /// 注册表单项
  TFormItemState? formItemState;

  /// 重置表单，表单里面没有重置按钮TButton(type: TButtonType.reset)时可以使用该方法，默认重置全部字段为空，该方法会触发 reset 事件。
  /// 如果表单属性 resetType=TFormResetType.empty 或 type=TFormResetType.empty 会重置为空；
  /// 如果表单属性 resetType=TFormResetType.initial 或者 type=TFormResetType.initial 会重置为表单初始值。
  /// [fields] 用于设置具体重置哪些字段，示例：reset({ type: TFormResetType.initial })
  @protected
  void reset(TFormResetType type) {}

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.name != oldWidget.name || widget.focusNode != oldWidget.focusNode) {
      if (oldWidget.name != null) {
        formItemState?.unregister(oldWidget.name!);
      }
      if (widget.name != null) {
        formItemState?.register(widget.name!, this);
      }
    }
  }

  @override
  void didChangeDependencies() {
    formItemState = TFormItem.of(context);
    if (widget.name != null) {
      formItemState?.register(widget.name!, this);
    }
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    if (widget.name != null) {
      TFormItem.of(context)?.unregister(widget.name!);
    }
    super.deactivate();
  }
}
