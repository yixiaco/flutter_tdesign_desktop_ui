import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 数字输入框示例代码
class TInputNumberExample extends StatefulWidget {
  const TInputNumberExample({Key? key}) : super(key: key);

  @override
  State<TInputNumberExample> createState() => _TInputNumberExampleState();
}

class _TInputNumberExampleState extends State<TInputNumberExample> {
  String? value0 = '10';
  String? value1 = '10';
  String? value2 = '10';

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TInputNumber<String>(
          value: value0,
          max: 5,
          min: -5,
          autocorrect: false,
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
          onChange: (value) {
            print(value);
            setState(() {
              value1 = value;
            });
          },
          tips: Text('tips'),
        ),
        TInputNumber<String>(
          value: value2,
          max: 5,
          min: -5,
          theme: TInputNumberTheme.column,
          onChange: (value) {
            print(value);
            setState(() {
              value2 = value;
            });
          },
        ),
      ],
    );
  }
}
