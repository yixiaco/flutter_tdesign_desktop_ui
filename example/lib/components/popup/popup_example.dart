import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层示例
class PopupExample extends StatefulWidget {
  const PopupExample({Key? key}) : super(key: key);

  @override
  State<PopupExample> createState() => _PopupExampleState();
}

class _PopupExampleState extends State<PopupExample> {
  ValueNotifier<int> i = ValueNotifier(0);
  late var children2 = [
    TPopup(
      trigger: TPopupTrigger.hover,
      placement: TPopupPlacement.leftBottom,
      showArrow: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TButton(themeStyle: TButtonThemeStyle.primary, child: Text('悬浮式触发')),
          TButton(themeStyle: TButtonThemeStyle.primary, child: Text('悬浮式触发')),
        ],
      ),
      child: TButton(
        themeStyle: TButtonThemeStyle.primary,
        onPressed: () {
          print('悬浮式触发');
        },
        child: const Text('悬浮式触发'),
      ),
    ),
    TPopup(
      placement: TPopupPlacement.topLeft,
      trigger: TPopupTrigger.click,
      showArrow: true,
      onOpen: () => print('点击打开弹窗'),
      builderContent: (context) {
        return ValueListenableBuilder(
          valueListenable: i,
          builder: (BuildContext context, int value, Widget? child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TButton(themeStyle: TButtonThemeStyle.primary, child: Text('点击时触发$value')),
                TButton(themeStyle: TButtonThemeStyle.primary, child: Text('点击时触发$value')),
              ],
            );
          },
        );
      },
      child: TButton(
        themeStyle: TButtonThemeStyle.primary,
        onPressed: () {
          i.value++;
          print('点击时触发');
        },
        child: const Text('点击时触发'),
      ),
    ),
    TPopup(
      trigger: TPopupTrigger.focus,
      placement: TPopupPlacement.right,
      showArrow: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TButton(themeStyle: TButtonThemeStyle.primary, child: Text('获取焦点时触发')),
          TButton(themeStyle: TButtonThemeStyle.primary, child: Text('获取焦点时触发')),
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
      placement: TPopupPlacement.bottom,
      showArrow: true,
      content: Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(width: 100, child: TextField()),
            TButton(themeStyle: TButtonThemeStyle.primary, child: Text('右击时触发')),
            TButton(themeStyle: TButtonThemeStyle.primary, child: Text('右击时触发')),
          ],
        ),
      ),
      child: TButton(
        themeStyle: TButtonThemeStyle.primary,
        onPressed: () {
          print('右击时触发');
        },
        child: const Text('右击时触发'),
      ),
    ),
  ];

  void random() {
    setState(() {
      var random = Random();
      for (int i = 0; i < children2.length; i++) {
        var child = children2[i];
        var nextInt = random.nextInt(children2.length);
        children2[i] = children2[nextInt];
        children2[nextInt] = child;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TButton(
          onPressed: () {
            random();
          },
          child: const Text('触发随机'),
        ),
        ...children2,
      ],
    );
  }
}
