import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class JumperExample extends StatelessWidget {
  const JumperExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TSpace(
      children: [
        TJumper(
          tips: TJumperTips(prev: '前尘忆梦', current: '回到现在', next: '展望未来'),
          onChange: (trigger) {
            print(trigger);
          },
        ),
        TJumper(
          layout: Axis.vertical,
          variant: TJumperVariant.outline,
          onChange: (trigger) {
            print(trigger);
          },
        ),
        TJumper(
          showCurrent: false,
          onChange: (trigger) {
            print(trigger);
          },
        ),
        TJumper(
          disabled: true,
          onChange: (trigger) {
            print(trigger);
          },
        ),
      ],
    );
  }
}
