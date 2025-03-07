import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 导航菜单示例
class TMenuExample extends StatefulWidget {
  const TMenuExample({super.key});

  @override
  State<TMenuExample> createState() => _TMenuExampleState();
}

class _TMenuExampleState extends State<TMenuExample> {
  late TMenuController _controller1;
  late TMenuController _controller2;
  bool collapsed = false;
  List<TMenuProps<String>> menus = [
    const TSubMenuProps<String>(
      value: '3',
      icon: Icon(TIcons.mail),
      title: Text('消息区'),
      children: [
        TSubMenuProps<String>(
          value: '3-1',
          title: Text('二级菜单'),
          children: [
            TMenuItemProps(
              value: '3-1-1',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-2',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-3',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-4',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-5',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-6',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-6',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-7',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-8',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-9',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-10',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-11',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-12',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-13',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-14',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-15',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-16',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-1-17',
              content: Text('最后三级菜单内容'),
            ),
          ],
        ),
        TSubMenuProps<String>(
          value: '3-2',
          title: Text('二级菜单'),
          children: [
            TMenuItemProps(
              value: '3-2-1',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-2-2',
              content: Text('三级菜单内容'),
            ),
            TMenuItemProps(
              value: '3-2-3',
              content: Text('三级菜单内容'),
            ),
          ],
        ),
        TMenuItemProps(
          value: '3-3',
          content: Text('三级菜单内容'),
        ),
        TMenuItemProps(
          value: '3-4',
          content: Text('三级菜单内容'),
        ),
      ],
    ),
    const TMenuItemProps(
      value: 'user-circle',
      icon: Icon(TIcons.user_circle),
      content: Text('个人中心'),
    ),
    const TSubMenuProps<String>(
      value: '4',
      title: Text('视频区'),
      icon: Icon(TIcons.play_circle),
      children: [
        TMenuItemProps(
          value: '4-1',
          content: Text('三级菜单内容'),
        ),
        TMenuItemProps(
          value: '4-2',
          content: Text('三级菜单内容'),
        ),
        TMenuItemProps(
          value: '4-3',
          content: Text('三级菜单内容'),
        ),
      ],
    ),
    const TMenuGroupProps(title: Text('分组'), children: [
      TMenuItemProps(
        value: 'edit1',
        disabled: true,
        icon: Icon(TIcons.edit_1),
        content: Text('资源编辑1'),
      ),
      TMenuItemProps(
        value: 'edit2',
        icon: Icon(TIcons.edit_1),
        content: Text('资源编辑2'),
      ),
    ]),
  ];

  bool showLogo = true;

  @override
  void initState() {
    super.initState();
    _controller1 = TMenuController();
    _controller2 = TMenuController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget? logo;
    if (showLogo) {
      logo = const Text('LOGO');
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSpace(
          children: [
            TButton(
              child: Text('${showLogo ? '隐藏' : '显示'}logo'),
              onPressed: () {
                setState(() {
                  showLogo = !showLogo;
                });
              },
            ),
          ],
        ),
        Flexible(
          child: TSpace(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TMenu(
                      collapsed: collapsed,
                      controller: _controller1,
                      menus: menus,
                      logo: logo,
                      operations: TMenuIconButton(
                        onClick: () {
                          setState(() {
                            collapsed = !collapsed;
                          });
                        },
                        child: Icon(collapsed ? TIcons.chevron_right : TIcons.chevron_left),
                      ),
                    ),
                  ),
                ],
              ),
              TMenu(
                expandType: TMenuExpandType.popup,
                collapsed: collapsed,
                controller: _controller2,
                expandMutex: true,
                menus: menus,
                logo: logo,
                operations: TMenuIconButton(
                  onClick: () {
                    setState(() {
                      collapsed = !collapsed;
                    });
                  },
                  child: Icon(collapsed ? TIcons.chevron_right : TIcons.chevron_left),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
