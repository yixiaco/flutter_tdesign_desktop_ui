import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层示例
class PopupExample extends StatelessWidget {
  const PopupExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TPopup(
          trigger: TPopupTrigger.hover,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TButton(child: Text('悬浮式触发')),
              TButton(child: Text('悬浮式触发')),
            ],
          ),
          child: TButton(
            onPressed: () {
              print('悬浮式触发');
            },
            child: const Text('悬浮式触发'),
          ),
        ),
        TPopup(
          trigger: TPopupTrigger.click,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TButton(child: Text('点击时触发')),
              TButton(child: Text('点击时触发')),
            ],
          ),
          child: TButton(
            onPressed: () {
              print('点击时触发');
            },
            child: const Text('点击时触发'),
          ),
        ),
        TPopup(
          trigger: TPopupTrigger.focus,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TButton(child: Text('获取焦点时触发')),
              TButton(child: Text('获取焦点时触发')),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(width: 150, child: TextField(decoration: InputDecoration(hintText: '获取焦点时触发1'))),
              SizedBox(width: 150, child: TextField(decoration: InputDecoration(hintText: '获取焦点时触发2'))),
            ],
          ),
        ),
        TPopup(
          trigger: TPopupTrigger.contextMenu,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TButton(child: Text('右击时触发')),
              TButton(child: Text('右击时触发')),
            ],
          ),
          child: TButton(
            onPressed: () {
              print('右击时触发');
            },
            child: const Text('右击时触发'),
          ),
        ),
      ],
    );
  }
}
