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
      showStatusIcon: true,
      // labelAlign: TFormLabelAlign.top,
      rules: const {
        'name': [
          TFormRule(required: true, trigger: TFormRuleTrigger.blur),
          TFormRule(max: 6, trigger: TFormRuleTrigger.change),
          TFormRule(min: 3, trigger: TFormRuleTrigger.blur),
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
          labelText: '姓名',
          help: const Text('这是用户名字段帮助说明'),
          successBorder: true,
          child: TInput(
            placeholder: '请输入内容',
            name: 'name',
            // onEnter: (text) {
            //   print('提交：$text');
            // },
          ),
        ),
        TFormItem(
          labelText: '手机号',
          child: TInput(
            placeholder: '请输入内容',
            name: 'tel',
            onEnter: (text) {
              print('提交：$text');
            },
          ),
        ),
        TFormItem(
          labelText: '接收短信',
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
          labelText: '性别',
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
          labelText: '课程',
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
