import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 表单示例
class TFormExample extends StatefulWidget {
  const TFormExample({Key? key}) : super(key: key);

  @override
  State<TFormExample> createState() => _TFormExampleState();
}

class _TFormExampleState extends State<TFormExample> {
  bool status = false;
  int? gender = 1;
  List<int> course = [];
  bool disabled = false;
  bool? radioCheck;
  bool? checkboxCheck;
  int? number = 10;

  @override
  Widget build(BuildContext context) {
    return TForm(
      colon: true,
      // showStatusIcon: true,
      labelWidth: 120,
      resetType: TFormResetType.initial,
      // labelAlign: TFormLabelAlign.top,
      disabled: disabled,
      // formControlledComponents: const ['TInput'],
      rules: const {
        'name': [
          TFormRule(required: true, trigger: TFormRuleTrigger.blur),
          TFormRule(max: 6, trigger: TFormRuleTrigger.change),
          TFormRule(min: 3, trigger: TFormRuleTrigger.blur),
        ],
        'www': [
          TFormRule(required: true, trigger: TFormRuleTrigger.blur),
        ],
        'status': [
          TFormRule(required: true, trigger: TFormRuleTrigger.change),
        ],
        'gender': [
          TFormRule(required: true, trigger: TFormRuleTrigger.change),
        ],
        'radio': [
          TFormRule(required: true, trigger: TFormRuleTrigger.change),
        ],
        'checkbox': [
          TFormRule(required: true, trigger: TFormRuleTrigger.change),
        ],
        'course': [
          TFormRule(required: true, trigger: TFormRuleTrigger.change),
        ],
        'number': [
          TFormRule(required: true, trigger: TFormRuleTrigger.change),
          TFormRule(max: 2, trigger: TFormRuleTrigger.change),
        ]
      },
      onReset: () {
        print('重置');
      },
      onValidate: (result) {
        print('执行校验：${result.validate} => ${result.errorMessage}');
      },
      onSubmit: (data, result) {
        var validate = result.validate;
        var errorMessage = result.errorMessage;
        print('提交: $data,校验结果：$validate => $errorMessage');
      },
      children: [
        TFormItem(
          child: TCheckbox(
            checked: disabled,
            label: const Text('是否禁用表单'),
            onChange: (checked, indeterminate, value) => setState(() {
              disabled = checked;
            }),
          ),
        ),
        const TFormItem(
          labelText: '姓名',
          help: Text('这是用户名字段帮助说明'),
          successBorder: true,
          child: TInput(
            placeholder: '请输入内容',
            name: 'name',
          ),
        ),
        TFormItem(
          labelText: '网址',
          child: TInputAdornment(
            prepend: const Text('https://'),
            append: const Text('.com'),
            child: TInput(
              name: 'www',
              onEnter: (text) {
                print('提交：$text');
              },
            ),
          ),
        ),
        TFormItem(
          labelText: '接收短信',
          child: TSwitch<bool>(
            name: 'status',
            // checkLabel: const Text('开'),
            // uncheckLabel: const Text('关'),
            // checkValue: 1,
            // uncheckValue: 0,
            defaultValue: true,
            value: status,
            onChange: (value) => setState(() {
              status = value;
            }),
          ),
        ),
        TFormItem(
          labelText: '单选',
          child: TRadio<int>(
            name: 'radio',
            label: const Text('选中'),
            allowUncheck: true,
            defaultChecked: true,
            checked: radioCheck,
            value: 2,
            onChange: (checked, value) => setState(() {
              radioCheck = checked;
            }),
          ),
        ),
        TFormItem(
          labelText: '性别',
          child: TRadioGroup<int>(
            name: 'gender',
            allowUncheck: true,
            defaultValue: 2,
            options: [
              TRadioOption(label: const Text('男'), value: 1),
              TRadioOption(label: const Text('女'), value: 2),
            ],
            value: gender,
            onChange: (value) => setState(() {
              gender = value;
            }),
          ),
        ),
        TFormItem(
          labelText: '多选',
          child: TCheckbox<String>(
            name: 'checkbox',
            label: const Text('多选'),
            checked: checkboxCheck,
            defaultChecked: true,
            value: 'checkboxBox',
            onChange: (checked, indeterminate, value) {
              setState(() {
                checkboxCheck = checked;
              });
            },
          ),
        ),
        TFormItem(
          labelText: '课程',
          child: TCheckboxGroup<int>(
            // max: 1,
            name: 'course',
            defaultValue: const [1, 2],
            options: [
              TCheckboxOption(label: const Text('语文'), value: 1),
              TCheckboxOption(label: const Text('数学'), value: 2),
              TCheckboxOption(label: const Text('英语'), value: 3),
            ],
            value: course,
            onChange: (checked, current, options) {
              setState(() {
                course = options;
              });
            },
          ),
        ),
        TFormItem(
          successBorder: true,
          labelText: '数字',
          child: TInputNumber<int>(
            name: 'number',
            value: number,
            max: 5,
            min: -5,
            onChange: (value) {
              setState(() {
                number = value;
              });
            },
          ),
        ),
        const TFormItem(
          child: TSpace(
            children: [
              TButton(
                themeStyle: TButtonThemeStyle.primary,
                type: TButtonType.submit,
                child: Text('提交'),
              ),
              TButton(
                themeStyle: TButtonThemeStyle.defaultStyle,
                type: TButtonType.reset,
                variant: TButtonVariant.base,
                child: Text('重置'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
