import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 表单
/// 用以收集、校验和提交数据，一般由输入框、单选框、复选框、选择器等控件组成。
class TForm extends StatefulWidget {
  const TForm({
    Key? key,
    this.colon = false,
    this.data = const {},
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

  /// 是否在表单标签字段右侧显示冒号
  final bool colon;

  /// 表单数据。
  final Object data;

  /// 是否禁用整个表单
  final bool? disabled;

  /// 表单错误信息配置，示例：{ idcard: '请输入正确的身份证号码', max: '字符长度不能超过 ${max}' }
  final Map<String, String>? errorMessage;

  /// 允许表单统一控制禁用状态的自定义组件名称列表。
  /// 默认会有组件库的全部输入类组件：TInput、TInputNumber、TCascader、TSelect、TOption、TSwitch、TCheckbox、TCheckboxGroup、TRadio、TRadioGroup、TTreeSelect、TDatePicker、TTimePicker、TUpload、TTransfer、TSlider。
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
  final Map<String, List<dynamic>>? rules;

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

  /// 表单提交时触发。其中 context.validateResult 表示校验结果，context.firstError 表示校验不通过的第一个规则提醒。context.validateResult 值为 true 表示校验通过；如果校验不通过，context.validateResult 值为校验结果列表。
  // 【注意】⚠️ 默认情况，输入框按下 Enter 键会自动触发提交事件，如果希望禁用这个默认行为，可以给输入框添加 enter 事件，并在事件中设置 e.preventDefault()
  final VoidCallback? onSubmit;

  /// 校验结束后触发，result 值为 true 表示校验通过；如果校验不通过，result 值为校验结果列表
  final VoidCallback? onValidate;

  @override
  State<TForm> createState() => TFormState();
}

class TFormState extends State<TForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
