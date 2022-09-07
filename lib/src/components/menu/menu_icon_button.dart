import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

const _kDefaultMenuIconButtonSize = Size.square(32);
const _kHeadMenuIconButtonSize = Size.square(40);
const _kIconButtonPadding = EdgeInsets.all(8);

/// 导航菜单操作区按钮，通常用于[TMenu]、[THeadMenu]组件中
class TMenuIconButton extends StatelessWidget {
  const TMenuIconButton({
    Key? key,
    this.onClick,
    this.theme,
    this.size,
    this.backgroundColor,
    required this.child,
  }) : super(key: key);

  /// 点击事件
  final GestureTapCallback? onClick;

  /// 菜单风格
  final TMenuTheme? theme;

  /// 组件大小
  final Size? size;

  /// 背景色
  final Color? backgroundColor;

  /// icon
  final Icon child;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var defaultMenuTheme = TDefaultMenuTheme.of(context);
    var headMenu = defaultMenuTheme?.headMenu ?? false;
    var tMenuThemeParentData = headMenu ? defaultMenuTheme as THeadMenuThemeData : defaultMenuTheme as TMenuThemeData;
    var menuTheme = this.theme ?? tMenuThemeParentData.theme ?? (theme.isLight ? TMenuTheme.light : TMenuTheme.dark);
    var size = this.size ?? (headMenu ? _kHeadMenuIconButtonSize : _kDefaultMenuIconButtonSize);

    var backgroundColor = MaterialStateProperty.resolveWith((states) {
      if (this.backgroundColor != null) {
        return MaterialStateProperty.resolveAs(this.backgroundColor, states);
      }
      if (states.contains(MaterialState.hovered)) {
        if (menuTheme.isLight) {
          return colorScheme.gray2;
        } else {
          return colorScheme.gray9;
        }
      }
    });
    return IconTheme(
      data: IconThemeData(
        color: menuTheme.isLight ? colorScheme.fontGray1 : Colors.white,
        size: size.height / 2,
      ),
      child: Semantics(
        container: true,
        button: true,
        child: TMaterialStateBuilder(
          onTap: onClick,
          builder: (context, states) {
            return Container(
              height: size.height,
              width: size.width,
              padding: _kIconButtonPadding,
              decoration: BoxDecoration(
                color: backgroundColor.resolve(states),
                borderRadius: BorderRadius.circular(TVar.borderRadiusDefault),
              ),
              child: child,
            );
          },
        ),
      ),
    );
  }
}
