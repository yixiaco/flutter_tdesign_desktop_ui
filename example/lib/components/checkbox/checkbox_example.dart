import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({Key? key}) : super(key: key);

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool check = false;
  String? radio = '';

  @override
  Widget build(BuildContext context) {
    return TSpace(
      children: [
        TCheckbox<String>(
          checked: check,
          value: '哈哈',
          label: const Text('基础多选框'),
          onChange: (checked, indeterminate, value) {
            setState(() {
              check = checked ?? false;
            });
            print('半选：$indeterminate，value：$value');
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
        Radio(
          value: 'groupValue',
          toggleable: true,
          groupValue: radio,
          onChanged: (value) {
            setState(() {
              radio = value as String?;
            });
          },
        ),
        Radio(
          value: 'groupValue1',
          toggleable: true,
          groupValue: radio,
          onChanged: (value) {
            setState(() {
              radio = value as String?;
            });
          },
        )
      ],
    );
  }
}
