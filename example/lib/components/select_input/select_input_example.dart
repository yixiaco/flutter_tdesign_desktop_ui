import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 筛选器输入框示例代码
class TSelectInputExample extends StatefulWidget {
  const TSelectInputExample({Key? key}) : super(key: key);

  @override
  State<TSelectInputExample> createState() => _TSelectInputExampleState();
}

class _TSelectInputExampleState extends State<TSelectInputExample> {
  late TSelectInputController _controller;
  late TSelectInputMultipleController _multipleController;
  var options = [
    const SelectInputValue(label: 'tdesign-vue', value: 1 ),
    const SelectInputValue(label: 'tdesign-react', value: 2 ),
    const SelectInputValue(label: 'tdesign-miniprogram', value: 3 ),
    const SelectInputValue(label: 'tdesign-angular', value: 4 ),
    const SelectInputValue(label: 'tdesign-mobile-vue', value: 5 ),
    const SelectInputValue(label: 'tdesign-mobile-react', value: 6 ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TSelectInputSingleController();
    _multipleController = TSelectInputMultipleController(value: []);
  }

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TSelectInput(
          controller: _controller,
        ),
        TSelectInput(
          controller: _multipleController,
          autoWidth: true,
          multiple: true,
          panel: TSpace(
            spacing: 2,
            direction: Axis.vertical,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(options.length, (index) {
              return TButton(variant: TButtonVariant.text,child: Text(options[index].label));
            }),
          ),
        ),
      ],
    );
  }
}
