import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 下拉菜单示例
class TDropdownExample extends StatefulWidget {
  const TDropdownExample({Key? key}) : super(key: key);

  @override
  State<TDropdownExample> createState() => _TDropdownExampleState();
}

class _TDropdownExampleState extends State<TDropdownExample> {
  List<TDropdownOption<int>> options = [
    TDropdownOption.text(content: '操作一', children: [
      TDropdownOption.text(content: '选项一', children: [
        TDropdownOption.text(content: '选项1'),
        TDropdownOption.text(content: '选项2'),
      ]),
      TDropdownOption.text(content: '选项二'),
    ]),
    TDropdownOption.text(content: '操作二', disabled: true),
    TDropdownOption.text(content: '操作三', children: [
      TDropdownOption.text(content: '选项三'),
      TDropdownOption.text(content: '选项四'),
    ]),
    TDropdownOption.text(content: '操作四'),
    TDropdownOption.text(content: '操作五'),
    TDropdownOption.text(content: '操作六'),
    TDropdownOption.text(content: '操作七'),
    TDropdownOption.text(content: '操作八'),
    TDropdownOption.text(content: '操作九'),
    TDropdownOption.text(content: '操作十'),
    TDropdownOption.text(content: '操作十一'),
    TDropdownOption.text(content: '操作十二'),
    TDropdownOption.text(content: '操作十三'),
    TDropdownOption.text(content: '操作十四'),
    TDropdownOption.text(content: '操作十五'),
    TDropdownOption.text(content: '操作十六'),
    TDropdownOption.text(content: '操作十七'),
    TDropdownOption.text(content: '操作十八'),
    TDropdownOption.text(content: '操作十九很长很长'),
  ];

  List<TDropdownOption<int>> options2 = [
    TDropdownOption.text(content: '操作一', divider: true),
    TDropdownOption.text(content: '操作二', disabled: true),
    TDropdownOption.text(content: '操作三'),
  ];

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.horizontal,
      children: [
        TDropdown<int>(
          // maxColumnWidth: 300,
          options: options,
          trigger: TPopupTrigger.click,
          child: const TButton(
            variant: TButtonVariant.outline,
            child: Text('下拉菜单'),
          ),
        ),
        TDropdown<int>(
          // maxColumnWidth: 300,
          options: options2,
          // minColumnWidth: 90,
          child: const TButton(
            child: Text('下拉菜单'),
          ),
        ),
      ],
    );
  }
}
