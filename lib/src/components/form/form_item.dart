import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 作为[TForm]的子项
/// 注意：子组件不能指定多个name组件注册到该子项中。
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
  TFormItemStatus? _currentStatus;
  int _version = 1;

  /// 错误消息
  TFormItemValidateMessage? _message;

  /// 边框颜色
  Color? get borderColor => _borderColor;

  /// 边框阴影
  List<BoxShadow>? get shadows => _shadows;

  /// 当前注册组件值
  dynamic get value => _field?.formItemValue;

  /// 当前注册组件名称
  String? get name => _field?.widget.name;

  /// 注册表单字段项
  void register(String name, TFormItemValidateState field) {
    _field?.focusNode?.removeListener(_focusChange);
    _field = field;
    _field?.focusNode?.addListener(_focusChange);
    _formState?.register(name, this);
    _needNotifyUpdate();
  }

  /// 焦点变更事件
  void _focusChange() {
    if (!_field!.focusNode!.hasFocus && _field!.focusNode?.canRequestFocus == true) {
      validate();
    }
  }

  /// 注销表单字段项
  void unregister(String name) {
    _field?.focusNode?.removeListener(_focusChange);
    _field = null;
    _formState?.unregister(name);
    _needNotifyUpdate();
  }

  void _needNotifyUpdate() {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        if (mounted) {
          setState(() {});
        }
      });
    } else {
      setState(() {});
    }
  }

  @override
  void didUpdateWidget(covariant TFormItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.rules != oldWidget.rules) {
      clearValidate();
    }
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
    var showStatusIcon = widget.showStatusIcon ?? _formState?.widget.showStatusIcon ?? false;

    Widget child = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minHeight: TVar.spacer4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: KeyedSubtree(child: widget.child)),
              if (showStatusIcon) _buildStatusIcon(theme, colorScheme),
            ],
          ),
        ),
        if (widget.help != null) _buildHelp(theme, colorScheme),
        if (_message?.message != null) _buildMessage(theme, colorScheme),
      ],
    );
    if (labelAlign == TFormLabelAlign.top) {
      child = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) label,
          child,
        ],
      );
    } else {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) label,
          Flexible(child: child),
        ],
      );
    }

    var length = _formState?.widget.children.length ?? 0;
    var i = _formState?.widget.children.indexOf(widget) ?? -1;
    var isLast = i != -1 && i == length - 1;
    var bottom = TVar.spacer3;
    if (widget.help != null || _message?.message != null) {
      bottom -= TVar.lineHeightS;
    }
    return _TFormItemScope(
      formState: this,
      version: _version,
      child: Padding(
        padding: EdgeInsets.only(bottom: isLast ? 0 : bottom),
        child: child,
      ),
    );
  }

  /// 构建帮助文本
  Widget _buildHelp(TThemeData theme, TColorScheme colorScheme) {
    return Container(
      height: TVar.lineHeightS,
      alignment: Alignment.centerLeft,
      child: DefaultTextStyle(
        style: theme.fontData.fontBodySmall.merge(TextStyle(
          color: colorScheme.textColorPlaceholder,
        )),
        child: widget.help!,
      ),
    );
  }

  /// 构建验证消息
  Widget _buildMessage(TThemeData theme, TColorScheme colorScheme) {
    return Container(
      height: TVar.lineHeightS,
      alignment: Alignment.centerLeft,
      child: DefaultTextStyle(
        style: theme.fontData.fontBodySmall.merge(TextStyle(
          color: borderColor,
        )),
        child: Text(_message!.message!),
      ),
    );
  }

  /// 构建icon
  Widget _buildStatusIcon(TThemeData theme, TColorScheme colorScheme) {
    Widget? defaultStatusIcon;
    if (_currentStatus != null) {
      switch (_currentStatus!) {
        case TFormItemStatus.success:
          defaultStatusIcon = Icon(
            TIcons.checkCircleFilled,
            size: TVar.lineHeightS,
            color: colorScheme.successColor,
          );
          break;
        case TFormItemStatus.error:
          defaultStatusIcon = Icon(
            TIcons.closeCircleFilled,
            size: TVar.lineHeightS,
            color: colorScheme.errorColor,
          );
          break;
        case TFormItemStatus.warning:
          defaultStatusIcon = Icon(
            TIcons.errorCircleFilled,
            size: TVar.lineHeightS,
            color: colorScheme.warningColor,
          );
          break;
      }
    }
    Widget? statusIcon = widget.statusIcon ?? _formState?.widget.statusIcon ?? defaultStatusIcon;
    if (statusIcon != null) {
      return Container(
        height: TVar.lineHeightS,
        margin: EdgeInsets.only(left: TVar.spacer),
        child: statusIcon,
      );
    }
    return Container();
  }

  /// 构建label
  Widget? _buildLabel(TThemeData theme, TColorScheme colorScheme, TFormLabelAlign labelAlign) {
    if (!widget.showLabel) {
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
      if (requiredMark && _existRequired()) {
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
      height: TVar.spacer4,
      padding: EdgeInsets.only(right: TVar.spacer3),
      child: child,
    );
  }

  /// 是否存在必填项
  bool _existRequired() {
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
      _currentStatus = null;
      _version++;
    });
  }

  /// 重置表单，表单里面没有重置按钮TButton(type: TButtonType.reset)时可以使用该方法，默认重置全部字段为空，该方法会触发 reset 事件。
  /// 如果表单属性 resetType=TFormResetType.empty 或 type=TFormResetType.empty 会重置为空；
  /// 如果表单属性 resetType=TFormResetType.initial 或者 type=TFormResetType.initial 会重置为表单初始值。
  /// [fields] 用于设置具体重置哪些字段，示例：reset({ type: TFormResetType.initial, fields: ['name', 'age'] })
  void reset(TFormResetType type) {
    setState(() {
      _field?.reset(type);
      clearValidate();
      _version++;
    });
  }

  /// 设置自定义校验结果，如远程校验信息直接呈现。
  void setValidateMessage(TFormItemValidateMessage message) {
    setState(() {
      _message = message;
      switch (_message!.type) {
        case TFormRuleType.error:
          _setStatus(TFormItemStatus.error);
          break;
        case TFormRuleType.warning:
          _setStatus(TFormItemStatus.warning);
          break;
      }
      _version++;
    });
  }

  /// 校验函数，包含错误文本提示等功能。
  /// 【关于参数】params.fields 表示校验字段，如果设置了 fields，本次校验将仅对这些字段进行校验。
  /// params.trigger 表示本次触发校验的范围，'params.trigger = blur' 表示只触发校验规则设定为 trigger='blur' 的字段，
  /// 'params.trigger = change' 表示只触发校验规则设定为 trigger='change' 的字段，默认触发全范围校验。
  /// params.showErrorMessage 表示校验结束后是否显
  /// 示错误文本提示，默认显示。
  /// 【关于返回值】返回值为 true 表示校验通过；如果校验不通过，返回值为校验结果列表
  TFormItemValidateResult validate({TFormRuleTrigger trigger = TFormRuleTrigger.all, bool? showErrorMessage}) {
    showErrorMessage ??= widget.showErrorMessage ?? _formState?.widget.showErrorMessage ?? true;
    var result = validateOnly(trigger);
    var rules = _rules();
    // 如果规则中不存在change或burl，则不更新
    // 例如，trigger=change，但是规则中不存在change，则会验证通过，并导致更新页面
    var any = rules.any((element) {
      return element.trigger == TFormRuleTrigger.all || trigger == TFormRuleTrigger.all || element.trigger == trigger;
    });
    if (any) {
      clearValidate();
      if (!result.validate) {
        setValidateMessage(TFormItemValidateMessage(
          type: result.type!,
          message: showErrorMessage ? result.errorMessage! : null,
        ));
      } else {
        setState(() {
          _setStatus(widget.successBorder ? TFormItemStatus.success : null);
        });
      }
    }
    return result;
  }

  /// 纯净的校验函数，仅返回校验结果，不对组件进行任何操作
  TFormItemValidateResult validateOnly([TFormRuleTrigger trigger = TFormRuleTrigger.all]) {
    var rules = _rules();
    var errorMessage = _formState?.widget.errorMessage;
    var validator = Validator(
        name: widget.labelText ?? '', rules: rules, value: value, errorMessage: errorMessage, context: context);
    return validator.validate(trigger);
  }

  /// 设置状态值
  void _setStatus(TFormItemStatus? status) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    _currentStatus = status;
    Color? shadowColor;
    if (status != null) {
      switch (status) {
        case TFormItemStatus.success:
          _borderColor = colorScheme.successColor;
          shadowColor = colorScheme.successColorFocus;
          break;
        case TFormItemStatus.error:
          _borderColor = colorScheme.errorColor;
          shadowColor = colorScheme.errorColorFocus;
          break;
        case TFormItemStatus.warning:
          _borderColor = colorScheme.warningColor;
          shadowColor = colorScheme.warningColorFocus;
          break;
      }
    }
    if (shadowColor != null) {
      _shadows = [
        BoxShadow(
          offset: const Offset(0, 0),
          blurRadius: 0,
          spreadRadius: 2,
          color: shadowColor,
          blurStyle: BlurStyle.outer,
        )
      ];
    }
    _version++;
  }
}

class _TFormItemScope extends InheritedWidget {
  const _TFormItemScope({
    required super.child,
    required TFormItemState formState,
    required this.version,
  }) : _formItemState = formState;

  final TFormItemState _formItemState;

  final int version;

  /// The [TForm] associated with this widget.
  TFormItem get formItem => _formItemState.widget;

  @override
  bool updateShouldNotify(_TFormItemScope old) => version != old.version;
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
  dynamic get formItemValue;

  /// 如果存在焦点
  FocusNode? get focusNode => widget.focusNode;

  /// 注册表单项
  TFormItemState? _formItemState;

  // 表单
  TFormState? _formState;

  TFormItemState? get formItemState => widget.name == null ? null : _formItemState;

  /// 当前组件名称
  String get componentName => widget.runtimeType.toString().replaceFirst(RegExp(r'<.*>'), '');

  /// 表单组件禁用状态
  bool get formDisabled {
    if (widget.name == null) {
      return false;
    }
    var form = _formState?.widget;
    var disabled = form?.disabled ?? false;
    if (disabled) {
      var components = form?.formControlledComponents;
      if (components != null) {
        // 禁用指定组件
        if (components.contains(componentName)) {
          return true;
        }
      } else {
        // 禁用全部组价
        return true;
      }
    }
    return false;
  }

  /// 重置表单，表单里面没有重置按钮TButton(type: TButtonType.reset)时可以使用该方法，默认重置全部字段为空，该方法会触发 reset 事件。
  /// 如果表单属性 resetType=TFormResetType.empty 或 type=TFormResetType.empty 会重置为空；
  /// 如果表单属性 resetType=TFormResetType.initial 或者 type=TFormResetType.initial 会重置为表单初始值。
  /// [fields] 用于设置具体重置哪些字段，示例：reset({ type: TFormResetType.initial })
  @protected
  void reset(TFormResetType type);

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.name != oldWidget.name || widget.focusNode != oldWidget.focusNode) {
      _formItemState ??= TFormItem.of(context);
      _formState ??= TForm.of(context);
      if (oldWidget.name != null) {
        _formItemState?.unregister(oldWidget.name!);
      }
      if (widget.name != null) {
        _formItemState?.register(widget.name!, this);
      }
    }
  }

  @override
  void didChangeDependencies() {
    if (widget.name != null) {
      _formItemState = TFormItem.of(context);
      _formState = TForm.of(context);
      if (_formItemState?._field != this) {
        _formItemState?.register(widget.name!, this);
      }
    }
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    if (widget.name != null) {
      _formItemState?.unregister(widget.name!);
    }
    super.deactivate();
  }
}
