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
  int index = 0;
  late List<TTabsPanel<String>> panels;

  @override
  void initState() {
    super.initState();
    panels = List.generate(3, (index) {
      this.index++;
      return TTabsPanel(
        label: Text('选项卡$index'),
        value: '选项卡$index',
        panel: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text('选项卡$index内容'),
        ),
        removable: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TSpace(
        direction: Axis.vertical,
        children: [
          TSingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: TSpace(
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
          ),
          TTabs<String>(
            value: value,
            theme: theme,
            placement: placement,
            addable: true,
            dragSort: true,
            list: [
              TTabsPanel(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(TIcons.home),
                    ),
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
                    Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(TIcons.calendar),
                    ),
                    Text('日程'),
                  ],
                ),
                value: 'second1',
                panel: const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text('选项卡2内容'),
                ),
              ),
              TTabsPanel(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(TIcons.calendar),
                    ),
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
                    Padding(
                      padding: EdgeInsets.only(right: 4),
                      child: Icon(TIcons.layers),
                    ),
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
            onDragSort: (currentIndex, current, targetIndex, target) {
              print('currentIndex:$currentIndex, current:$current, targetIndex:$targetIndex, target:$target');
            },
            onChange: (value) {
              setState(() {
                this.value = value;
              });
            },
          ),
          Expanded(
            child: TTabs<String>(
              value: value,
              theme: theme,
              placement: placement,
              addable: true,
              dragSort: true,
              onRemove: (value, index) {
                setState(() {
                  panels.removeAt(index);
                });
              },
              onAdd: () {
                setState(() {
                  panels.add(TTabsPanel(
                    label: Text('选项卡$index'),
                    value: '选项卡$index',
                    panel: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text('选项卡$index内容'),
                    ),
                    removable: true,
                  ));
                  value = '选项卡$index';
                  index++;
                });
              },
              list: panels,
              onChange: (value) {
                setState(() {
                  this.value = value;
                });
              },
              onDragSort: (currentIndex, current, targetIndex, target) {
                setState(() {
                  var panel = panels[currentIndex];
                  panels[currentIndex] = panels[targetIndex];
                  panels[targetIndex] = panel;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
