import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 顶部菜单导航示例
class THeadMenuExample extends StatefulWidget {
  const THeadMenuExample({Key? key}) : super(key: key);

  @override
  State<THeadMenuExample> createState() => _THeadMenuExampleState();
}

class _THeadMenuExampleState extends State<THeadMenuExample> {
  late TMenuController _controller1;
  late TMenuController _controller2;
  late TMenuController _controller3;
  List<TMenuProps<String>> menus = [
    const TMenuItemProps(
      value: 'item1',
      content: Text('菜单1'),
    ),
    const TMenuItemProps(
      value: 'item2',
      content: Text('菜单2'),
    ),
    const TMenuItemProps(
      value: 'item3',
      disabled: true,
      content: Text('菜单3'),
    ),
  ];
  List<TMenuProps<String>> menus2 = [
    const TSubMenuProps(
      value: '1',
      title: Text('菜单1'),
      children: [
        TMenuItemProps(
          value: '1-1',
          content: Text('子菜单1-1'),
        ),
        TMenuItemProps(
          value: '1-2',
          content: Text('子菜单1-2'),
        ),
        TMenuItemProps(
          value: '1-3',
          disabled: true,
          content: Text('子菜单1-3'),
        ),
      ],
    ),
    const TSubMenuProps(
      value: '2',
      title: Text('菜单2'),
      children: [
        TMenuItemProps(
          value: '2-1',
          content: Text('子菜单2-1'),
        ),
        TMenuItemProps(
          value: '2-2',
          content: Text('子菜单2-2'),
        ),
        TMenuItemProps(
          value: '2-3',
          disabled: true,
          content: Text('子菜单2-3'),
        ),
      ],
    ),
  ];
  List<TMenuProps<String>> menus3 = [
    const TSubMenuProps(
      value: '1',
      title: Text('菜单1'),
      children: [
        TMenuItemProps(
          value: '1-1',
          content: Text('子菜单1-1'),
        ),
        TMenuItemProps(
          value: '1-2',
          content: Text('子菜单1-2'),
        ),
        TMenuItemProps(
          value: '1-3',
          disabled: true,
          content: Text('子菜单1-3'),
        ),
        TSubMenuProps(
          value: '1-4',
          title: Text('菜单2'),
          children: [
            TMenuItemProps(
              value: '1-4-1',
              content: Text('子菜单1-4-1'),
            ),
            TMenuItemProps(
              value: '1-4-2',
              content: Text('子菜单1-4-2'),
            ),
            TMenuItemProps(
              value: '1-4-3',
              disabled: true,
              content: Text('子菜单1-4-3'),
            ),
          ],
        ),
      ],
    ),
    const TSubMenuProps(
      value: '2',
      title: Text('菜单2'),
      children: [
        TMenuItemProps(
          value: '2-1',
          content: Text('子菜单2-1'),
        ),
        TMenuItemProps(
          value: '2-2',
          content: Text('子菜单2-2'),
        ),
        TMenuItemProps(
          value: '2-3',
          disabled: true,
          content: Text('子菜单2-3'),
        ),
      ],
    ),
  ];

  bool showLogo = true;

  @override
  void initState() {
    super.initState();
    _controller1 = TMenuController();
    _controller2 = TMenuController();
    _controller3 = TMenuController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    Widget? logo;
    if (showLogo) {
      logo = Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Image.asset(
          theme.isLight ? 'assets/images/logo/menu_logo_hover.png' : 'assets/images/logo/menu_logo.png',
          width: 136,
        ),
      );
    }
    return TSpace(
      direction: Axis.vertical,
      children: [
        Row(
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
        THeadMenu(
          controller: _controller1,
          menus: menus,
          logo: logo,
          operations: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TMenuIconButton(child: Icon(TIcons.search)),
              TMenuIconButton(child: Icon(TIcons.mail)),
              TMenuIconButton(child: Icon(TIcons.user)),
              TMenuIconButton(child: Icon(TIcons.ellipsis)),
            ],
          ),
        ),
        THeadMenu(
          controller: _controller2,
          menus: menus2,
          logo: logo,
          operations: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              TMenuIconButton(child: Icon(TIcons.search)),
              TMenuIconButton(child: Icon(TIcons.mail)),
              TMenuIconButton(child: Icon(TIcons.user)),
              TMenuIconButton(child: Icon(TIcons.ellipsis)),
            ],
          ),
        ),
        THeadMenu(
          controller: _controller3,
          menus: menus3,
          logo: logo,
          expandType: TMenuExpandType.popup,
          operations: Container(
            color: const Color.fromRGBO(255, 255, 255, .3),
            width: 200,
            height: 40,
            alignment: Alignment.center,
            child: const Text('自定义内容区域'),
          ),
        )
      ],
    );
  }
}
