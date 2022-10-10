import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 表单
/// 用以收集、校验和提交数据，一般由输入框、单选框、复选框、选择器等控件组成。
class TForm extends StatefulWidget {
  const TForm({
    Key? key,
    this.children = const [],
    this.colon = false,
    this.disabled,
    this.errorMessage,
    this.formControlledComponents,
    this.labelAlign = TFormLabelAlign.right,
    this.labelWidth = 100,
    this.layout = TFormLayout.vertical,
    this.requiredMark = true,
    this.resetType = TFormResetType.empty,
    this.rules,
    this.scrollToFirstError,
    this.showErrorMessage = true,
    this.statusIcon,
    this.showStatusIcon = false,
    this.onReset,
    this.onSubmit,
    this.onValidate,
  }) : super(key: key);

  /// 表单子项
  final List<Widget> children;

  /// 是否在表单标签字段右侧显示冒号
  final bool colon;

  /// 是否禁用整个表单
  final bool? disabled;

  /// 表单错误信息配置，示例：{ idcard: '请输入正确的身份证号码', max: '字符长度不能超过 ${max}' }
  final TFormErrorMessage? errorMessage;

  /// 允许表单统一控制禁用状态的自定义组件名称列表。
  /// 默认会有组件库的全部输入类组件：[TInput]、[TInputNumber]、[TCascader]、[TSelect]、[TOption]、[TSwitch]、[TCheckbox]、[TCheckboxGroup]、[TRadio]、[TRadioGroup]、[TTreeSelect]、[TDatePicker]、[TTimePicker]、[TUpload]、[TTransfer]、[TSlider]。
  /// 对于自定义组件，组件内部需要包含可以控制表单禁用状态的变量 formDisabled。
  /// 示例：['CustomUpload', 'CustomInput']
  final List<String>? formControlledComponents;

  /// 表单字段标签对齐方式：左对齐、右对齐、顶部对齐。可选项：left/right/top
  final TFormLabelAlign labelAlign;

  /// 可以整体设置label标签宽度，默认为100
  final double labelWidth;

  /// 表单布局，有两种方式：纵向布局 和 行内布局。可选项：vertical/inline
  final TFormLayout layout;

  /// 是否显示必填符号（*），默认显示
  final bool requiredMark;

  /// 重置表单的方式，值为 empty 表示重置表单为空，值为 initial 表示重置表单数据为初始值。可选项：empty/initial
  final TFormResetType resetType;

  /// 表单字段校验规则
  final Map<String, List<TFormRule>>? rules;

  /// 表单校验不通过时，是否自动滚动到第一个校验不通过的字段，平滑滚动或是瞬间直达。值为空则表示不滚动。可选项：''/smooth/auto
  final TFormScrollToFirstError? scrollToFirstError;

  /// 校验不通过时，是否显示错误提示信息，统一控制全部表单项。如果希望控制单个表单项，请给 FormItem 设置该属性
  final bool showErrorMessage;

  /// 自定义校验状态图。
  final Widget? statusIcon;

  /// 显示校验状态图标，值为 true 显示默认图标，默认图标有 成功、失败、警告 等，不同的状态图标不同。
  /// [showStatusIcon] 值为 false，不显示图标
  final bool showStatusIcon;

  /// 表单重置时触发
  final VoidCallback? onReset;

  /// 表单提交时触发。其中 validate 表示校验结果，firstError 表示校验不通过的第一个规则提醒。校验不通过validateResult 值为校验结果列表。
  // 【注意】⚠️ 默认情况，输入框按下 Enter 键会自动触发提交事件，如果希望禁用这个默认行为，可以给输入框添加 enter 事件，并在事件中设置 e.preventDefault()
  final void Function(Map<String, dynamic> data, TFormValidateResult result)?
      onSubmit;

  /// 校验结束后触发，result 值为 true 表示校验通过；如果校验不通过，result 值为校验结果列表
  final Function(TFormValidateResult result)? onValidate;

  static TFormState? of(BuildContext context) {
    final _TFormScope? scope = context.dependOnInheritedWidgetOfExactType<_TFormScope>();
    return scope?._formState;
  }

  @override
  State<TForm> createState() => TFormState();
}

class TFormState extends State<TForm> {
  final Map<String, TFormItemState> _fields = {};

  void register(String name, TFormItemState field) {
    _fields[name] = field;
  }

  void unregister(String name) {
    _fields.remove(name);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (widget.layout) {
      case TFormLayout.vertical:
        child = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget.children,
        );
        break;
      case TFormLayout.inline:
        child = Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          children: widget.children,
        );
        break;
    }

    return _TFormScope(
      formState: this,
      child: child,
    );
  }

  /// 获取表单数据
  Map<String, dynamic> get data {
    return _fields.map((key, value) => MapEntry(key, value.value));
  }

  /// 清空校验结果。可使用 fields 指定清除部分字段的校验结果，fields 值为空则表示清除所有字段校验结果。
  /// 清除邮箱校验结果示例：clearValidate(['email'])
  void clearValidate([List<String> fields = const []]) {
    _fields.entries
        .where((element) => fields.isEmpty || fields.contains(element.key))
        .forEach((element) => element.value.clearValidate());
  }

  /// 重置表单，表单里面没有重置按钮TButton(type: TButtonType.reset)时可以使用该方法，默认重置全部字段为空，该方法会触发 reset 事件。
  /// 如果表单属性 resetType=TFormResetType.empty 或 type=TFormResetType.empty 会重置为空；
  /// 如果表单属性 resetType=TFormResetType.initial 或者 type=TFormResetType.initial 会重置为表单初始值。
  /// [fields] 用于设置具体重置哪些字段，示例：reset({ type: TFormResetType.initial, fields: ['name', 'age'] })
  void reset({TFormResetType type = TFormResetType.empty, List<String> fields = const []}) {
    _fields.entries
        .where((element) => fields.isEmpty || fields.contains(element.key))
        .forEach((element) => element.value.reset(type));
    widget.onReset?.call();
  }

  /// 设置自定义校验结果，如远程校验信息直接呈现。
  void setValidateMessage(Map<String, TFormItemValidateMessage> message) {
    _fields.entries
        .where((element) => message.keys.contains(element.key))
        .forEach((element) => element.value.setValidateMessage(message[element.key]!));
  }

  /// 提交表单，表单里面没有提交按钮TButton(type: TButtonType.submit)时可以使用该方法。
  /// showErrorMessage 表示是否在提交校验不通过时显示校验不通过的原因，默认显示。
  /// 该方法会触发 submit 事件
  void submit([bool showErrorMessage = true]) {
    var result = validate();
    widget.onSubmit?.call(data, result);
  }

  /// 校验函数，包含错误文本提示等功能。
  /// 【关于参数】params.fields 表示校验字段，如果设置了 fields，本次校验将仅对这些字段进行校验。
  /// params.trigger 表示本次触发校验的范围，'params.trigger = blur' 表示只触发校验规则设定为 trigger='blur' 的字段，
  /// 'params.trigger = change' 表示只触发校验规则设定为 trigger='change' 的字段，默认触发全范围校验。
  /// params.showErrorMessage 表示校验结束后是否显示错误文本提示，默认显示。
  /// 【关于返回值】返回值为 true 表示校验通过；如果校验不通过，返回值为校验结果列表
  TFormValidateResult validate({List<String> fields = const [], TFormRuleTrigger? trigger, bool? showErrorMessage}) {
    var valid = _validate(fields: fields, trigger: trigger, showErrorMessage: showErrorMessage, only: false);
    widget.onValidate?.call(valid);
    return valid;
  }

  /// 纯净的校验函数，仅返回校验结果，不对组件进行任何操作
  TFormValidateResult validateOnly({List<String> fields = const [], TFormRuleTrigger? trigger}) {
    return _validate(fields: fields, trigger: trigger, only: true);
  }

  /// 校验函数
  TFormValidateResult _validate({
    List<String> fields = const [],
    TFormRuleTrigger? trigger,
    bool? showErrorMessage,
    required bool only,
  }) {
    bool validate = true;
    Map<String, String> message = {};
    Map<String, TFormItemValidateResult> validateResult = {};
    String? firstMessage;
    for (var entry in _fields.entries.where((element) => fields.isEmpty || fields.contains(element.key))) {
      var key = entry.key;
      var value = entry.value;
      TFormItemValidateResult result;
      if (only) {
        result = value.validateOnly(trigger);
      } else {
        result = value.validate(trigger: trigger, showErrorMessage: showErrorMessage);
      }
      if (!result.validate) {
        validate = result.validate;
        validateResult[key] = result;
        firstMessage ??= result.errorMessage;
        if (result.errorMessage != null) {
          message[key] = result.errorMessage!;
        }
      }
    }
    return TFormValidateResult(
        validate: validate, errorMessage: message, validateResult: validateResult, firstMessage: firstMessage);
  }
}

class _TFormScope extends InheritedWidget {
  const _TFormScope({
    required super.child,
    required TFormState formState,
  }) : _formState = formState;

  final TFormState _formState;

  /// The [TForm] associated with this widget.
  TForm get form => _formState.widget;

  @override
  bool updateShouldNotify(_TFormScope old) => this != old;
}
