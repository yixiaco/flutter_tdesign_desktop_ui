import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 数字输入框示例代码
class TInputNumberExample extends StatefulWidget {
  const TInputNumberExample({Key? key}) : super(key: key);

  @override
  State<TInputNumberExample> createState() => _TInputNumberExampleState();
}

class _TInputNumberExampleState extends State<TInputNumberExample> {
  int? value0;
  String? value1 = '10';
  String? value2 = '10';
  String? value3 = '10';
  bool authWidth = false;

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TRadioGroup<bool>(
          variant: TRadioVariant.defaultFilled,
          options: [
            TRadioOption(label: const Text('固定宽度'), value: false),
            TRadioOption(label: const Text('自适应宽度'), value: true),
          ],
          value: authWidth,
          onChange: (value) => setState(() {
            authWidth = value!;
          }),
        ),
        TInputNumber<int>(
          value: value0,
          max: 5,
          min: -5,
          autoWidth: authWidth,
          autocorrect: false,
          // readonly: true,
          onChange: (value) {
            print(value);
            setState(() {
              value0 = value;
            });
          },
          onValidate: (exceedMaximum, belowMinimum) {
            print('exceedMaximum: $exceedMaximum, belowMinimum: $belowMinimum');
          },
        ),
        TInputNumber<String>(
          value: value1,
          max: 5,
          min: -5,
          autoWidth: authWidth,
          step: 0.3,
          format: (value, fixedNumber) => '$value%',
          onChange: (value) {
            print(value);
            setState(() {
              value1 = value;
            });
          },
          tips: const Text('tips'),
        ),
        TInputNumber<String>(
          value: value2,
          max: 5,
          min: -5,
          autoWidth: authWidth,
          theme: TInputNumberTheme.column,
          onChange: (value) {
            print(value);
            setState(() {
              value2 = value;
            });
          },
        ),
        TInputNumber<String>(
          value: value3,
          max: 5,
          min: -5,
          autoWidth: authWidth,
          theme: TInputNumberTheme.normal,
          onChange: (value) {
            print(value);
            setState(() {
              value3 = value;
            });
          },
        ),
      ],
    );
  }
}
