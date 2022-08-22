import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 选项卡示例
class TTabsExample extends StatefulWidget {
  const TTabsExample({Key? key}) : super(key: key);

  @override
  State<TTabsExample> createState() => _TTabsExampleState();
}

class _TTabsExampleState extends State<TTabsExample> {
  String value = 'first';

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TTabs<String>(
          value: value,
          list: const [
            TTabsPanel(
              label: Text.rich(TextSpan(children: [
                WidgetSpan(child: Icon(TIcons.home)),
                TextSpan(text: '首页'),
              ])),
              value: 'first',
              panel: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text('选项卡1内容'),
              ),
            ),
            TTabsPanel(
              label: Text.rich(TextSpan(children: [
                WidgetSpan(child: Icon(TIcons.calendar)),
                TextSpan(text: '日程'),
              ])),
              value: 'second',
              panel: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text('选项卡2内容'),
              ),
            ),
            TTabsPanel(
              label: Text.rich(TextSpan(children: [
                WidgetSpan(child: Icon(TIcons.layers)),
                TextSpan(text: '事项'),
              ])),
              value: 'third',
              panel: Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text('选项卡3内容'),
              ),
            ),
          ],
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        )
      ],
    );
  }
}
