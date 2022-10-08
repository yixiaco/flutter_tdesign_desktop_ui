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
  int gender = 1;
  List<int> course = [];

  @override
  Widget build(BuildContext context) {
    return TForm(
      colon: true,
      // labelAlign: TFormLabelAlign.top,
      rules: const {
        'name': [
          TFormRule(required: true, message: '姓名必填'),
        ]
      },
      onReset: () {
        print('重置');
      },
      onSubmit: (data, validate, validateResult, firstError) {
        print('提交: $data');
      },
      children: [
        TFormItem(
          label: const Text('姓名'),
          name: 'name',
          child: TInput(
            placeholder: '请输入内容',
            name: 'name',
            onEnter: (text) {
              print('提交：$text');
            },
          ),
        ),
        TFormItem(
          label: const Text('手机号'),
          name: 'tel',
          child: TInput(
            placeholder: '请输入内容',
            name: 'tel',
            onEnter: (text) {
              print('提交：$text');
            },
          ),
        ),
        TFormItem(
          label: const Text('接收短信'),
          name: 'status',
          child: TSwitch<bool>(
            // name: 'status',
            // checkLabel: const Text('开'),
            // uncheckLabel: const Text('关'),
            value: status,
            onChange: (value) => setState(() {
              status = value;
            }),
          ),
        ),
        TFormItem(
          label: const Text('性别'),
          name: 'gender',
          child: TRadioGroup<int>(
            options: [
              TRadioOption(label: const Text('男'), value: 1),
              TRadioOption(label: const Text('女'), value: 2),
            ],
            value: gender,
            onChange: (value) => setState(() {
              gender = value!;
            }),
          ),
        ),
        TFormItem(
          label: const Text('课程'),
          name: 'course',
          child: TCheckboxGroup<int>(
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
