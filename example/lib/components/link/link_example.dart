import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 跳转链接示例
class TLinkExample extends StatelessWidget {
  const TLinkExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TSpace(
          children: [
            TLink(
              prefixIcon: const Icon(TIcons.link),
              onClick: () => print('object'),
              child: const Text('跳转链接'),
            ),
          ],
        ),
      ],
    );
  }
}
