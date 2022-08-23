import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 选项卡示例
class TTabsExample extends StatefulWidget {
  const TTabsExample({Key? key}) : super(key: key);

  @override
  State<TTabsExample> createState() => _TTabsExampleState();
}

class _TTabsExampleState extends State<TTabsExample> {
  String value = 'first1';
  TTabsTheme theme = TTabsTheme.normal;
  TTabsPlacement placement = TTabsPlacement.top;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TSpace(
        direction: Axis.vertical,
        children: [
          TSpace(
            children: [
              TRadioGroup<TTabsTheme>(
                variant: TRadioVariant.defaultFilled,
                options: [
                  TRadioOption(label: const Text('常规型'), value: TTabsTheme.normal),
                  TRadioOption(label: const Text('卡片型'), value: TTabsTheme.card),
                ],
                value: theme,
                onChange: (value) => setState(() {
                  theme = value!;
                }),
              ),
              TRadioGroup<TTabsPlacement>(
                variant: TRadioVariant.defaultFilled,
                options: [
                  TRadioOption(label: const Text('top'), value: TTabsPlacement.top),
                  TRadioOption(label: const Text('right'), value: TTabsPlacement.right),
                  TRadioOption(label: const Text('bottom'), value: TTabsPlacement.bottom),
                  TRadioOption(label: const Text('left'), value: TTabsPlacement.left),
                ],
                value: placement,
                onChange: (value) => setState(() {
                  placement = value!;
                }),
              ),
              TButton(
                onPressed: () {
                  setState(() {
                    value = '';
                  });
                },
                child: const Text('置空'),
              ),
            ],
          ),
          TTabs<String>(
            value: value,
            theme: theme,
            placement: placement,
            list: [
              TTabsPanel(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(TIcons.home),
                    Text('首页'),
                  ],
                ),
                value: 'first',
                panel: const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text('选项卡1内容'),
                ),
                removable: true,
              ),
              TTabsPanel(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(TIcons.calendar),
                    Text('日程'),
                  ],
                ),
                value: 'second',
                panel: const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text('选项卡2内容'),
                ),
                disabled: true,
                removable: true,
              ),
              TTabsPanel(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(TIcons.layers),
                    Text('事项'),
                  ],
                ),
                value: 'third',
                panel: const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text('选项卡3内容'),
                ),
                removable: true,
              ),
            ],
            onChange: (value) {
              setState(() {
                this.value = value;
              });
            },
          )
        ],
      ),
    );
  }
}
