part of '../menu.dart';

/// menu item button
class _TMenuItem<T> extends StatefulWidget {
  const _TMenuItem({
    Key? key,
    required this.props,
  }) : super(key: key);

  /// 布局属性
  final _TMenuItemLayoutProps<T> props;

  @override
  State<_TMenuItem<T>> createState() => _TMenuItemState<T>();
}

class _TMenuItemState<T> extends State<_TMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var layoutProps = widget.props;
    var menuProps = layoutProps.menuProps as TMenuItemProps<T>;
    var count = layoutProps.menus.length;
    var index = layoutProps.index;
    var isFirst = index == 0;
    var isLast = index == count - 1;
    var controller = layoutProps.controller;
    var isActive = menuProps.value == controller.value;
    // 波纹颜色
    var fixedRippleColor = theme.isLight ? colorScheme.gray3 : colorScheme.gray11;
    var textColor = isActive ? Colors.white : null;

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

    if (layoutProps.collapsed) {
      alignment = Alignment.center;
    } else {
      margin = const EdgeInsets.only(right: 10, left: 16);
      alignment = Alignment.centerLeft;
      content = menuProps.content;
    }
    if (content != null && icon != null) {
      content = Padding(
        padding: EdgeInsets.only(left: TVar.spacer),
        child: content,
      );
    }

    return DefaultTextStyle.merge(
      style: TextStyle(
        color: textColor,
      ),
      child: IconTheme.merge(
        data: IconThemeData(
          color: textColor,
        ),
        child: Padding(
          padding: EdgeInsets.only(top: isFirst ? 0 : 4, bottom: isLast ? 0 : 4),
          child: TRipple(
            selected: isActive,
            selectedClick: !isActive,
            fixedRippleColor: fixedRippleColor,
            radius: BorderRadius.circular(TVar.borderRadiusDefault),
            backgroundColor: menuBackgroundColor,
            animatedDuration: TVar.animDurationSlow,
            curve: TVar.animTimeFnEasing,
            onTap: () {
              controller.value = menuProps.value;
            },
            builder: (context, states) {
              return SizedBox(
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
              );
            },
          ),
        ),
      ),
    );
  }
}
