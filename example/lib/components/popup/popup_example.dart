import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层示例
class TPopupExample extends StatefulWidget {
  const TPopupExample({super.key});

  @override
  State<TPopupExample> createState() => _TPopupExampleState();
}

class _TPopupExampleState extends State<TPopupExample> {
  late ValueNotifier<int> i;
  late ValueNotifier<Color> backgroundColor;

  @override
  void initState() {
    i = ValueNotifier(0);
    backgroundColor = ValueNotifier(Colors.blue);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    i.dispose();
    backgroundColor.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const TPopup(
          trigger: TPopupTrigger.hover,
          placement: TPopupPlacement.leftBottom,
          showArrow: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TButton(themeStyle: TButtonThemeStyle.primary, child: Text('悬浮式触发')),
              TButton(themeStyle: TButtonThemeStyle.primary, child: Text('悬浮式触发')),
            ],
          ),
          child: TButton(
            themeStyle: TButtonThemeStyle.primary,
            child: Text('悬浮式触发'),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: backgroundColor,
          builder: (BuildContext context, Color value, Widget? child) {
            return TPopup(
              placement: TPopupPlacement.topLeft,
              trigger: TPopupTrigger.click,
              showArrow: true,
              onOpen: () {
                backgroundColor.value = Colors.primaries[Random().nextInt(Colors.primaries.length)];
              },
              style: TPopupStyle(
                backgroundColor: backgroundColor.value,
              ),
              content: ValueListenableBuilder(
                valueListenable: i,
                builder: (BuildContext context, int value, Widget? child) {
                  return Text('这是一个弹出框$value');
                },
              ),
              child: TButton(
                themeStyle: TButtonThemeStyle.primary,
                onPressed: () {
                  i.value++;
                },
                child: const Text('点击时触发'),
              ),
            );
          },
        ),
        const TPopup(
          trigger: TPopupTrigger.focus,
          placement: TPopupPlacement.right,
          showArrow: true,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TInput(autoWidth: true),
              TButton(themeStyle: TButtonThemeStyle.primary, child: Text('获取焦点时触发')),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 150, child: TInput(placeholder: '获取焦点时触发1')),
              SizedBox(width: 150, child: TInput(placeholder: '获取焦点时触发2')),
            ],
          ),
        ),
        const TPopup(
          trigger: TPopupTrigger.contextMenu,
          placement: TPopupPlacement.bottom,
          destroyOnClose: false,
          showArrow: true,
          content: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TInput(autoWidth: true),
                TButton(themeStyle: TButtonThemeStyle.primary, child: Text('右击时触发')),
                TButton(themeStyle: TButtonThemeStyle.primary, child: Text('右击时触发')),
              ],
            ),
          ),
          child: TButton(
            themeStyle: TButtonThemeStyle.primary,
            child: Text('右击时触发'),
          ),
        ),
      ],
    );
  }
}
