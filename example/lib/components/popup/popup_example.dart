import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层示例
class PopupExample extends StatelessWidget {
  const PopupExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "xxxxxxxx",
      child: TButton(
        onPressed: () {
          print('xx');
        },
        child: const Text('打开窗口'),
      ),
    );
  }
}
