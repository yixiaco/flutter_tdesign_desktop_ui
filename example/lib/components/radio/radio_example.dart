import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class RadioExample extends StatefulWidget {
  const RadioExample({Key? key}) : super(key: key);

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  String? radio = 'groupValue2';
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    return TSpace(
      breakLine: true,
      children: [
        TSpace(
          mainAxisSize: MainAxisSize.max,
          children: [
            TRadio(
              checked: checked,
              label: const Text('选项一'),
              onChange: (checked, value) {
                setState(() {
                  this.checked = checked ?? false;
                });
                print('checked:$checked,value:$value');
              },
            ),
          ],
        ),
        Radio<String>(
          value: 'groupValue',
          toggleable: true,
          groupValue: radio,
          onChanged: (value) {
            setState(() {
              radio = value;
            });
          },
        ),
        Radio<String>(
          value: 'groupValue1',
          toggleable: true,
          groupValue: radio,
          onChanged: (value) {
            setState(() {
              radio = value;
            });
          },
        ),
        Radio<String>(
          value: 'groupValue2',
          toggleable: true,
          groupValue: radio,
          onChanged: null,
        ),
      ],
    );
  }
}
