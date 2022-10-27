import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TCollapseExample extends StatefulWidget {
  const TCollapseExample({super.key});

  @override
  State<TCollapseExample> createState() => _TCollapseExampleState();
}

class _TCollapseExampleState extends State<TCollapseExample> {
  List<dynamic> value = [0];
  bool disabled = false;

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        TButton(
          onPressed: () {
            setState(() {
              disabled = !disabled;
            });
          },
          child: const Text('启用/禁用'),
        ),
        TCollapse<int>(
          disabled: disabled,
          defaultExpandAll: true,
          panels: const [
            TCollapsePanel(
              header: Text('这是一个折叠面板'),
              content: Text('这部分是每个折叠面板折叠或展开的内容，可根据不同业务或用户的使用诉求，进行自定义填充。可以是纯文本、图文、子列表等内容形式。'),
              headerRightContent: TButton(
                themeStyle: TButtonThemeStyle.primary,
                size: TComponentSize.small,
                child: Text('操作'),
              ),
              disabled: true,
            ),
            TCollapsePanel(
              header: Text('自定义icon'),
              content: Text('这部分是每个折叠面板折叠或展开的内容，可根据不同业务或用户的使用诉求，进行自定义填充。可以是纯文本、图文、子列表等内容形式。2'),
              headerRightContent: TButton(
                themeStyle: TButtonThemeStyle.primary,
                size: TComponentSize.small,
                child: Text('操作'),
              ),
              expandIcon: Icon(TIcons.discountFilled),
            ),
            TCollapsePanel(
              header: Text('销毁面板'),
              content: TInput(),
              destroyOnCollapse: true,
              headerRightContent: TButton(
                themeStyle: TButtonThemeStyle.primary,
                size: TComponentSize.small,
                child: Text('操作'),
              ),
            ),
            TCollapsePanel(
              header: Text('缓存面板'),
              content: TInput(),
              headerRightContent: TButton(
                themeStyle: TButtonThemeStyle.primary,
                size: TComponentSize.small,
                child: Text('操作'),
              ),
            ),
          ],
          // expandIconPlacement: TCollapseExpandIconPlacement.right,
          value: value,
          onChange: (value) {
            setState(() {
              this.value = value;
            });
          },
        ),
      ],
    );
  }
}
