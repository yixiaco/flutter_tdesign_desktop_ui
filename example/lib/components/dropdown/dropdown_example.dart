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
    TDropdownOption.text(content: '操作一'),
    TDropdownOption.text(content: '操作二', disabled: true),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二操作二'),
  ];

  List<TDropdownOption<int>> options2 = [
    TDropdownOption.text(content: '操作一'),
    TDropdownOption.text(content: '操作二', disabled: true),
  ];

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.horizontal,
      children: [
        TDropdown<int>(
          // maxColumnWidth: 300,
          options: options,
          child: const TButton(
            variant: TButtonVariant.outline,
            child: Text('下拉菜单'),
          ),
        ),
        TDropdown<int>(
          // maxColumnWidth: 300,
          options: options2,
          minColumnWidth: 90,
          child: const TButton(
            child: Text('下拉菜单'),
          ),
        ),
      ],
    );
  }
}
