import 'package:example/components/alert/alert_example.dart';
import 'package:example/components/breadcrumb/breadcrumb_example.dart';
import 'package:example/components/button/button_example.dart';
import 'package:example/components/checkbox/checkbox_example.dart';
import 'package:example/components/collapse/collapse_example.dart';
import 'package:example/components/dialog/dialog_example.dart';
import 'package:example/components/dropdown/dropdown_example.dart';
import 'package:example/components/icon/icon_example.dart';
import 'package:example/components/input/input_example.dart';
import 'package:example/components/jumper/jumper_example.dart';
import 'package:example/components/loading/loading_example.dart';
import 'package:example/components/menu/head_menu_example.dart';
import 'package:example/components/menu/menu_example.dart';
import 'package:example/components/popup/popup_example.dart';
import 'package:example/components/progress/progress_example.dart';
import 'package:example/components/radio/radio_example.dart';
import 'package:example/components/space/space_example.dart';
import 'package:example/components/switch/switch_example.dart';
import 'package:example/components/tabs/tabs_example.dart';
import 'package:example/components/tag/tag_example.dart';
import 'package:example/state/semantics_state.dart';
import 'package:example/state/size_state.dart';
import 'package:example/state/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

import 'components/link/link_example.dart';

void main() {
  // 初始化之前如果访问二进制文件，需要先初始化
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends HookConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = ref.watch(themeProvider);
    var size = ref.watch(sizeProvider);

    return TTheme(
      data: theme.copyWith(size: size),
      child: MaterialApp(
        title: 'TDesign Desktop UI Demo',
        locale: const Locale('zh', 'CN'),
        supportedLocales: GlobalTDesignLocalizations.delegate.supportedLocales,
        localizationsDelegates: const [
          GlobalTDesignLocalizations.delegate,
        ],
        home: const MyHomePage(title: 'TDesign Desktop UI Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulHookConsumerWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  late TMenuController menuController;
  bool collapsed = false;
  bool showLogo = true;
  Widget? content;

  late List<TMenuProps<String>> menus = [
    TMenuGroupProps(
      title: const Text('基础'),
      children: [
        TMenuItemProps(
          value: 'button',
          content: const Text('Button 按钮'),
          onClick: () {
            setState(() {
              content = const TButtonExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'icon',
          content: const Text('Icon 图标'),
          onClick: () {
            setState(() {
              content = const TIconExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'link',
          content: const Text('Link 链接'),
          onClick: () {
            setState(() {
              content = const TLinkExample();
            });
          },
        ),
      ],
    ),
    TMenuGroupProps(
      title: const Text('布局'),
      children: [
        TMenuItemProps(
          value: 'space',
          content: const Text('Space 间隔'),
          onClick: () {
            setState(() {
              content = const TSpaceExample();
            });
          },
        ),
      ],
    ),
    TMenuGroupProps(
      title: const Text('导航'),
      children: [
        TMenuItemProps(
          value: 'breadcrumb',
          content: const Text('Breadcrumb 面包屑'),
          onClick: () {
            setState(() {
              content = const TBreadcrumbExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'dropdown',
          content: const Text('Dropdown 下拉菜单'),
          onClick: () {
            setState(() {
              content = const TDropdownExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'jumper',
          content: const Text('Jumper 跳转'),
          onClick: () {
            setState(() {
              content = const TJumperExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'menu',
          content: const Text('Menu 导航菜单'),
          onClick: () {
            setState(() {
              content = const TMenuExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'headMenu',
          content: const Text('HeadMenu 顶部导航菜单'),
          onClick: () {
            setState(() {
              content = const THeadMenuExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'tabs',
          content: const Text('Tabs 选项卡'),
          onClick: () {
            setState(() {
              content = const TTabsExample();
            });
          },
        ),
      ],
    ),
    TMenuGroupProps(
      title: const Text('输入'),
      children: [
        TMenuItemProps(
          value: 'checkbox',
          content: const Text('Checkbox 多选框'),
          onClick: () {
            setState(() {
              content = const TCheckboxExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'input',
          content: const Text('Input 输入框'),
          onClick: () {
            setState(() {
              content = const TInputExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'radio',
          content: const Text('Radio 单选框'),
          onClick: () {
            setState(() {
              content = const TRadioExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'switch',
          content: const Text('Switch 开关'),
          onClick: () {
            setState(() {
              content = const TSwitchExample();
            });
          },
        ),
      ],
    ),
    TMenuGroupProps(
      title: const Text('数据展示'),
      children: [
        TMenuItemProps(
          value: 'collapse',
          content: const Text('Collapse 折叠面板'),
          onClick: () {
            setState(() {
              content = const TCollapseExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'loading',
          content: const Text('Loading 加载'),
          onClick: () {
            setState(() {
              content = const TLoadingExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'progress',
          content: const Text('Progress 进度条'),
          onClick: () {
            setState(() {
              content = const TProgressExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'tag',
          content: const Text('Tag 标签'),
          onClick: () {
            setState(() {
              content = const TTagExample();
            });
          },
        ),
      ],
    ),
    TMenuGroupProps(
      title: const Text('消息提醒'),
      children: [
        TMenuItemProps(
          value: 'alert',
          content: const Text('Alert 告警提醒'),
          onClick: () {
            setState(() {
              content = const TAlertExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'dialog',
          content: const Text('Dialog 对话框'),
          onClick: () {
            setState(() {
              content = const TDialogExample();
            });
          },
        ),
        TMenuItemProps(
          value: 'popup',
          content: const Text('Popup 弹出层'),
          onClick: () {
            setState(() {
              content = const TPopupExample();
            });
          },
        ),
      ],
    )
  ];

  @override
  void initState() {
    super.initState();
    menuController = TMenuController();
  }

  @override
  void dispose() {
    super.dispose();
    menuController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = ref.watch(themeProvider);
    var semantics = ref.watch(semanticsProvider);
    var size = ref.watch(sizeProvider);

    Widget child = Scaffold(
      backgroundColor: theme.brightness == Brightness.light ? const Color(0xFFEEEEEE) : Colors.black,
      body: TLayout(
        aside: _buildAside(theme),
        header: _buildHeader(theme, semantics, size),
        footer: const TFooter(child: Text('Flutter TDesign Desktop UI')),
        content: TContent(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: content,
          ),
        ),
      ),
    );
    if (semantics) {
      return SemanticsDebugger(
        child: child,
      );
    }
    return child;
  }

  Widget _buildHeader(TThemeData theme, bool semantics, TComponentSize size) {
    return THeader(
      child: TSingleChildScrollView(
        scrollDirection: Axis.horizontal,
        primary: false,
        child: TSpace(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('主题：'),
                TButton(
                  onPressed: () => ref.read(themeProvider.notifier).toggle(),
                  child: Text(theme.brightness == Brightness.light ? '亮' : '暗'),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('语义：'),
                TButton(
                  onPressed: () => ref.read(semanticsProvider.notifier).update((state) => !state),
                  child: Text(semantics ? '显示语义' : '隐藏语义'),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('布局大小：'),
                TRadioGroup<TComponentSize>(
                  variant: TRadioVariant.defaultFilled,
                  options: [
                    TRadioOption<TComponentSize>(label: const Text('小'), value: TComponentSize.small),
                    TRadioOption<TComponentSize>(label: const Text('中'), value: TComponentSize.medium),
                    TRadioOption<TComponentSize>(label: const Text('大'), value: TComponentSize.large),
                  ],
                  value: size,
                  onChange: (value) => ref.read(sizeProvider.notifier).state = value!,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAside(TThemeData theme) {
    Widget? logo;
    if (showLogo) {
      String image;
      if (theme.isLight) {
        image = 'assets/images/logo/menu_logo_hover.png';
      } else {
        image = 'assets/images/logo/menu_logo.png';
      }
      if (collapsed) {
        image = 'assets/images/logo/logo@2x.png';
      }
      logo = Container(
        alignment: collapsed ? Alignment.center : null,
        padding: EdgeInsets.only(left: collapsed ? 0 : 24),
        child: Image.asset(
          image,
          width: collapsed ? 35 : 136,
        ),
      );
    }
    return FractionallySizedBox(
      heightFactor: 1,
      child: TMenu(
        collapsed: collapsed,
        controller: menuController,
        menus: menus,
        logo: logo,
        operations: TMenuIconButton(
          onClick: () {
            setState(() {
              collapsed = !collapsed;
            });
          },
          child: Icon(collapsed ? TIcons.chevronRight : TIcons.chevronLeft),
        ),
      ),
    );
  }
}
