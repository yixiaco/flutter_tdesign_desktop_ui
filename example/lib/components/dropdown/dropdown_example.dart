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
    TDropdownOption.text(content: '操作二'),
    TDropdownOption.text(content: '操作二操作二操作二'),
  ];

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TDropdown<int>(
          options: options,
          child: const TButton(
            themeStyle: TButtonThemeStyle.primary,
            child: Text('更多'),
          ),
        ),
      ],
    );
  }
}
