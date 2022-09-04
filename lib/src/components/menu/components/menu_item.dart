part of '../menu.dart';

/// menu item button
class _TMenuItem<T> extends StatelessWidget {
  const _TMenuItem({
    Key? key,
    required this.props,
  }) : super(key: key);

  /// 布局属性
  final _TMenuItemLayoutProps<T> props;

  bool get isPopup => props.collapsed || props.expandType == TMenuExpandType.popup;

  double? get paddingLeft {
    if (isPopup) {
      return null;
    }
    return _paddingLeft(props);
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var menuProps = props.currentProps as TMenuItemProps<T>;
    var count = props.menus.length;
    var index = props.index;
    var isFirst = index == 0;
    var isLast = index == count - 1;
    var controller = props.controller;
    var disabled = menuProps.disabled;
    var isActive = menuProps.value == controller.value;
    // 波纹颜色
    var fixedRippleColor = theme.isLight ? colorScheme.gray3 : colorScheme.gray11;

    var textColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      }
      if (states.contains(MaterialState.disabled)) {
        return theme.isLight ? colorScheme.fontGray4 : colorScheme.fontWhite4;
      }
      return null;
    });

    var menuBackgroundColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return colorScheme.brandColor;
      }
      if (states.contains(MaterialState.hovered)) {
        return theme.isLight ? colorScheme.gray2 : colorScheme.gray9;
      }
    });
    EdgeInsets? margin;
    Alignment alignment;
    Widget? content;
    Widget? icon = menuProps.icon;

    if (props.collapsed && props.parent?.currentProps is! TSubMenuProps) {
      alignment = Alignment.center;
    } else {
      margin = EdgeInsets.only(right: 10, left: paddingLeft ?? 16);
      alignment = Alignment.centerLeft;
      content = menuProps.content;
    }
    if (content != null && icon != null) {
      content = Padding(
        padding: EdgeInsets.only(left: TVar.spacer),
        child: content,
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 0 : 4, bottom: isLast ? 0 : 4),
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
              child: SizedBox(
                height: 36,
                child: Container(
                  alignment: alignment,
                  padding: margin,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) icon,
                      if (content != null) Expanded(child: content),
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
