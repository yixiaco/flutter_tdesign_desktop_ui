import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TSelectExample extends StatefulWidget {
  const TSelectExample({super.key});

  @override
  State<TSelectExample> createState() => _TSelectExampleState();
}

class _TSelectExampleState extends State<TSelectExample> {
  late List<TOption> options;
  late List<TOption> options3;
  dynamic prependValue = 'https://';
  dynamic appendValue = '.com';
  dynamic value = const TSelectOption(label: '大数据', value: '2');
  dynamic value2 = [const TSelectOption(label: '大数据', value: '2')];
  dynamic value3 = [];
  bool filter = true;
  bool loading3 = false;

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
    options3 = [];
  }

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TButton(
          themeStyle: TButtonThemeStyle.primary,
          child: Text(filter ? '可搜索' : '不可搜索'),
          onPressed: () {
            setState(() {
              filter = !filter;
            });
          },
        ),
        TInputAdornment(
          prepend: TSelect(
            value: prependValue,
            autoWidth: true,
            borderless: true,
            options: const [
              TSelectOption(label: 'https://', value: 'https://'),
              TSelectOption(label: 'http://', value: 'http://'),
            ],
            onChange: (value, changeContext) {
              setState(() {
                prependValue = value;
              });
            },
          ),
          append: TSelect(
            value: appendValue,
            autoWidth: true,
            borderless: true,
            options: const [
              TSelectOption(label: '.com', value: '.com'),
              TSelectOption(label: '.cn', value: '.cn'),
              TSelectOption(label: '.net', value: '.net'),
              TSelectOption(label: '.org', value: '.org')
            ],
            onChange: (value, changeContext) {
              setState(() {
                appendValue = value;
              });
            },
          ),
          child: const TInput(),
        ),
        const TSelect(),
        const TSelect(readonly: true, borderless: true),
        const TSelect(borderless: true, disabled: true),
        // const TSelect(placeholder: '加载中', loading: true),
        StatefulBuilder(
          builder: (context, setState) {
            return TSelect(
              value: value,
              options: options,
              autoWidth: true,
              clearable: true,
              filterable: filter,
              prefixIcon: const Icon(TIcons.browse),
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
              prefixIcon: const Icon(TIcons.browse),
              valueType: TSelectValueType.object,
              placeholder: '请选择云解决方案',
              // filterable: filter,
              creatable: true,
              reserveKeyword: true,
              filter: (filterWords, option) {
                return option.label.contains(filterWords);
                // return Future.delayed(const Duration(milliseconds: 50), () {
                //   return option.label.contains(filterWords);
                // });
              },
              onChange: (value, changeContext) {
                setState(() {
                  value2 = value;
                });
              },
            );
          },
        ),
        StatefulBuilder(
          builder: (context, setState) {
            return TSelect(
              value: value3,
              multiple: true,
              options: options3,
              autoWidth: true,
              clearable: true,
              tagVariant: TTagVariant.light,
              tagTheme: TTagTheme.primary,
              prefixIcon: const Icon(TIcons.browse),
              placeholder: '请选择云解决方案',
              filterable: filter,
              loading: loading3,
              onSearch: (search) {
                print('搜索：$search');
                if (search.isNotEmpty) {
                  setState(() {
                    loading3 = true;
                  });
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      loading3 = false;
                      options3 = [
                        TSelectOption(label: '${search}_test1', value: '${search}_test1'),
                        TSelectOption(label: '${search}_test2', value: '${search}_test2'),
                        TSelectOption(label: '${search}_test3', value: '${search}_test3'),
                      ];
                    });
                  });
                }
              },
              onChange: (value, changeContext) {
                setState(() {
                  value3 = value;
                });
              },
            );
          },
        ),
      ],
    );
  }
}
