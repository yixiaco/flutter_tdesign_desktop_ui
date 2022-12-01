import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TJumperExample extends StatelessWidget {
  const TJumperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TSpace(
      children: [
        TJumper(
          tips: TJumperTips(prev: '前尘忆梦', current: '回到现在', next: '展望未来'),
        ),
        const TJumper(
          layout: Axis.vertical,
          variant: TJumperVariant.outline,
        ),
        const TJumper(
          showCurrent: false,
        ),
        const TJumper(
          disabled: true,
        ),
      ],
    );
  }
}
