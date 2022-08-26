import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TCollapseExample extends StatefulWidget {
  const TCollapseExample({Key? key}) : super(key: key);

  @override
  State<TCollapseExample> createState() => _TCollapseExampleState();
}

class _TCollapseExampleState extends State<TCollapseExample> {
  @override
  Widget build(BuildContext context) {
    return const TSpace(
      direction: Axis.vertical,
      children: [
        TCollapse(
          panels: [
            TCollapsePanel(
              header: Text('这是一个折叠面板'),
              content: Text('这部分是每个折叠面板折叠或展开的内容，可根据不同业务或用户的使用诉求，进行自定义填充。可以是纯文本、图文、子列表等内容形式。'),
            )
          ],
        ),
      ],
    );
  }
}
