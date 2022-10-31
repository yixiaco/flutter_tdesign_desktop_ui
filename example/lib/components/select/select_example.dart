import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TSelectExample extends StatefulWidget {
  const TSelectExample({super.key});

  @override
  State<TSelectExample> createState() => _TSelectExampleState();
}

class _TSelectExampleState extends State<TSelectExample> {
  late List<TOption> options;
  dynamic value = '2';
  dynamic value2 = ['2'];

  @override
  void initState() {
    super.initState();
    options = [
      const TSelectOption(label: '架构云', value: '1'),
      const TSelectOption(label: '大数据', value: '2'),
      const TSelectOption(label: '区块链', value: '3'),
      const TSelectOption(label: '物联网', value: '4', disabled: true),
      const TSelectOption(label: '人工智能', value: '5'),
      const TSelectOption(label: '计算场景（高性能计算）', value: '6', child: Text('计算场景（高性能计算）')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        const TSelect(autoWidth: true),
        StatefulBuilder(
          builder: (context, setState) {
            return TSelect(
              value: value,
              options: options,
              autoWidth: true,
              placeholder: '请选择云解决方案',
              onChange: (value, selectedOptions, trigger) {
                setState(() {
                  this.value = value;
                });
              },
            );
          },
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return TSelect(
              value: value2,
              multiple: true,
              options: options,
              autoWidth: true,
              placeholder: '请选择云解决方案',
              onChange: (value, selectedOptions, trigger) {
                setState(() {
                  value2 = value;
                });
              },
            );
          },
        ),
      ],
    );
  }
}
