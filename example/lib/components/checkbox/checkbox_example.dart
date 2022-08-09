import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({Key? key}) : super(key: key);

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool check = false;
  bool indeterminate = true;
  List<String> value = [];

  @override
  Widget build(BuildContext context) {
    return TSpace(
      breakLine: true,
      children: [
        TSpace(
          mainAxisSize: MainAxisSize.max,
          children: [
            TCheckboxGroup<String>(
              options: [
                ...TCheckboxOption.strings(labels: ['选项一', '选项二', '选项三']),
                TCheckboxOption.string(label: '选项四', disabled: true)
              ],
              value: value,
              onChange: (checked, current, options) {
                print('checked: $checked, current: $current, options: $options');
                setState(() {
                  value = options;
                });
              },
            )
          ],
        ),
        TCheckbox<String>(
          checked: check,
          value: '哈哈',
          label: const Text('基础多选框'),
          indeterminate: indeterminate,
          disabled: true,
          onChange: (checked, indeterminate, value) {
            setState(() {
              check = checked;
              this.indeterminate = indeterminate;
            });
            print('选中: $checked,半选：$indeterminate,value：$value');
          },
        ),
        TCheckbox<String>(
          checked: check,
          value: '哈哈',
          label: const Text('基础多选框'),
          indeterminate: indeterminate,
          onChange: (checked, indeterminate, value) {
            setState(() {
              check = checked;
              this.indeterminate = indeterminate;
            });
            print('选中: $checked,半选：$indeterminate,value：$value');
          },
        ),
        Checkbox(
          value: check,
          onChanged: (value) {
            setState(() {
              check = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          side: const BorderSide(width: 0.8, color: Colors.blue),
          splashRadius: 0,
          tristate: true,
        ),
      ],
    );
  }
}
