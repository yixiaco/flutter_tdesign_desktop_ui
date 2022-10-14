import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 数字输入框示例代码
class TInputNumberExample extends StatefulWidget {
  const TInputNumberExample({Key? key}) : super(key: key);

  @override
  State<TInputNumberExample> createState() => _TInputNumberExampleState();
}

class _TInputNumberExampleState extends State<TInputNumberExample> {
  String? value = '10';

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TInputNumber<String>(
          value: value,
          max: 5,
          min: -5,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
        TInputNumber<String>(
          value: value,
          max: 5,
          min: -5,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
          tips: Text('tips'),
        ),
        TInputNumber<String>(
          value: value,
          max: 5,
          min: -5,
          theme: TInputNumberTheme.column,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
      ],
    );
  }
}
