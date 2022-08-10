import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 单选框示例
class RadioExample extends StatefulWidget {
  const RadioExample({Key? key}) : super(key: key);

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  bool? checked = true;
  String? value;

  @override
  Widget build(BuildContext context) {
    var options = TRadioOption.strings(labels: ['选项一', '选项二', '选项三', '选项四', '选项五']);
    return TSpace(
      breakLine: true,
      children: [
        TSpace(
          mainAxisSize: MainAxisSize.max,
          children: [
            TRadioGroup<String>(
              options: options,
              value: value,
              allowUncheck: true,
              onChange: (value) {
                print(value);
                setState(() {
                  this.value = value;
                });
              },
            ),
          ],
        ),
        TSpace(
          mainAxisSize: MainAxisSize.max,
          children: [
            TRadioGroup<String>(
              variant: TRadioVariant.outline,
              options: options,
              value: value,
              allowUncheck: true,
              onChange: (value) {
                print(value);
                setState(() {
                  this.value = value;
                });
              },
            ),
          ],
        ),
        TSpace(
          mainAxisSize: MainAxisSize.max,
          children: [
            TRadioGroup<String>(
              variant: TRadioVariant.defaultFilled,
              options: options,
              value: value,
              allowUncheck: true,
              onChange: (value) {
                print(value);
                setState(() {
                  this.value = value;
                });
              },
            ),
          ],
        ),
        TSpace(
          mainAxisSize: MainAxisSize.max,
          children: [
            TRadioGroup<String>(
              variant: TRadioVariant.primaryFilled,
              options: options,
              value: value,
              allowUncheck: true,
              onChange: (value) {
                print(value);
                setState(() {
                  this.value = value;
                });
              },
            ),
          ],
        ),
        TRadio(
          checked: checked,
          allowUncheck: true,
          disabled: true,
          label: const Text('选项一'),
          value: 'sss',
          onClick: () {
            print('点击');
          },
          onChange: (checked, value) {
            setState(() {
              this.checked = checked;
            });
            print('checked:$checked,value:$value');
          },
        ),
        TRadio(
          checked: checked,
          allowUncheck: true,
          label: const Text('选项一'),
          value: 'sss',
          onClick: () {
            print('点击');
          },
          onChange: (checked, value) {
            setState(() {
              this.checked = checked;
            });
            print('checked:$checked,value:$value');
          },
        ),
      ],
    );
  }
}
