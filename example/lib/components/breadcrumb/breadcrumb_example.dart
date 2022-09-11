import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TBreadcrumbExample extends StatelessWidget {
  const TBreadcrumbExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TBreadcrumb(
          maxItemWidth: 150,
          options: [
            TBreadcrumbItemProps(
              href: 'http://www.baidu.com',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(TIcons.books),
                  Text('页面1'),
                ],
              ),
            ),
            const TBreadcrumbItemProps(child: Text('页面2面包屑文案超长时悬浮显示文案全部信息'), disabled: true),
            const TBreadcrumbItemProps(child: Text('面包屑中文案过长时可缩略显示，鼠标hover时显示全部'), maxWidth: 200),
          ],
        ),
      ],
    );
  }
}
