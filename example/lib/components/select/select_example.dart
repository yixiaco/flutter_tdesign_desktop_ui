import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TSelectExample extends StatefulWidget {
  const TSelectExample({super.key});

  @override
  State<TSelectExample> createState() => _TSelectExampleState();
}

class _TSelectExampleState extends State<TSelectExample> {
  late List<TOption> options;
  dynamic value = const TSelectOption(label: '大数据', value: '2');
  dynamic value2 = [const TSelectOption(label: '大数据', value: '2')];

  @override
  void initState() {
    super.initState();
    options = [
      const TSelectOptionGroup(group: '分组一', children: [
        TSelectOption(label: '架构云', value: '1'),
        TSelectOption(label: '大数据', value: '2'),
        TSelectOption(label: '区块链', value: '3'),
        TSelectOption(label: '物联网', value: '4', disabled: true),
        TSelectOption(label: '人工智能', value: '5'),
        TSelectOption(label: '计算场景（高性能计算）', value: '6', child: Text('-计算场景（高性能计算）-')),
      ]),
      const TSelectOptionGroup(group: '分组二', children: [
        TSelectOption(label: '云计算', value: '7'),
        TSelectOption(label: '低代码平台', value: '8'),
        TSelectOption(label: '云服务器', value: '9'),
        TSelectOption(label: '域名备案', value: '10'),
        TSelectOption(label: '对象存储', value: '11'),
        TSelectOption(label: '超导体', value: '12'),
        TSelectOption(label: '激光炮', value: '13'),
      ]),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        const TSelect(),
        const TSelect(placeholder: '空数据', disabled: true),
        // const TSelect(placeholder: '加载中', loading: true),
        StatefulBuilder(
          builder: (context, setState) {
            return TSelect(
              value: value,
              options: options,
              autoWidth: true,
              clearable: true,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(TIcons.browse),
              ),
              valueType: TSelectValueType.object,
              placeholder: '请选择云解决方案',
              onChange: (value, changeContext) {
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
              clearable: true,
              minCollapsedNum: 2,
              max: 3,
              tagVariant: TTagVariant.light,
              tagTheme: TTagTheme.primary,
              prefixIcon: const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(TIcons.browse),
              ),
              valueType: TSelectValueType.object,
              placeholder: '请选择云解决方案',
              // filterable: true,
              creatable: true,
              onChange: (value, changeContext) {
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
