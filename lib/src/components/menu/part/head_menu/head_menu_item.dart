part of '../../head_menu.dart';

const Color menuItemHoverColorDark = Color.fromRGBO(255, 255, 255, .55);

/// 子菜单
class _THeadMenuItem<T> extends StatelessWidget {
  const _THeadMenuItem({
    Key? key,
    required this.props,
  }) : super(key: key);

  /// 布局属性
  final _THeadMenuItemLayoutProps<T> props;

  bool get isPopup => props.expandType == TMenuExpandType.popup;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var menuProps = props.currentProps as TMenuItemProps<T>;
    var count = props.menus.length;
    var index = props.index;
    var isFirst = index == 0;
    var controller = props.controller;
    var disabled = menuProps.disabled;
    var isActive = menuProps.value == controller.value;
    // 波纹颜色
    var fixedRippleColor = theme.isLight ? colorScheme.gray3 : colorScheme.gray11;

    var textColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return theme.isLight ? colorScheme.fontGray1 : colorScheme.textColorAnti;
      }
      if (states.contains(MaterialState.disabled)) {
        return theme.isLight ? colorScheme.fontGray4 : colorScheme.fontWhite4;
      }
      return null;
    });

    var menuBackgroundColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return theme.isLight ? colorScheme.gray2 : colorScheme.gray9;
      }
      if (states.contains(MaterialState.hovered)) {
        return theme.isLight ? colorScheme.gray2 : colorScheme.gray9;
      }
    });
    Alignment alignment;
    Widget? content;
    Widget? icon = menuProps.icon;

    alignment = Alignment.center;
    content = menuProps.content;
    if (content != null && icon != null) {
      content = Padding(
        padding: EdgeInsets.only(left: TVar.spacer),
        child: content,
      );
    }

    return Padding(
      padding: EdgeInsets.only(left: isFirst ? 0 : 4),
      child: TRipple(
        disabled: disabled,
        selected: isActive,
        selectedClick: !isActive,
        fixedRippleColor: fixedRippleColor,
        radius: BorderRadius.circular(TVar.borderRadiusDefault),
        backgroundColor: menuBackgroundColor,
        animatedDuration: TVar.animDurationSlow,
        curve: TVar.animTimeFnEasing,
        onTap: () {
          _handleClick(controller, menuProps);
        },
        builder: (context, states) {
          return DefaultTextStyle.merge(
            style: TextStyle(
              color: textColor.resolve(states),
            ),
            child: IconTheme.merge(
              data: IconThemeData(
                color: textColor.resolve(states),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 40, maxHeight: 40, minWidth: 104),
                child: Container(
                  alignment: alignment,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) icon,
                      if (content != null) content,
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 处理点击事件
  void _handleClick(TMenuController<T> controller, TMenuItemProps<T> menuProps) {
    controller.value = menuProps.value;
    props.onChange?.call(menuProps.value);
    menuProps.onClick?.call();
  }
}
