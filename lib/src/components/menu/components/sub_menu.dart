part of '../menu.dart';

double? _paddingLeft<T>(_TMenuItemLayoutProps<T> props) {
  double? paddingLeft;
  var parent = props.parent;
  while (parent != null && parent.currentProps is TSubMenuProps<T>) {
    if (paddingLeft == null) {
      paddingLeft = 44;
    } else {
      paddingLeft += 16;
    }
    parent = parent.parent;
  }
  return paddingLeft;
}

/// 次级菜单
class _TSubMenu<T> extends StatelessWidget {
  const _TSubMenu({
    Key? key,
    required this.props,
  }) : super(key: key);

  /// 布局属性
  final _TMenuItemLayoutProps<T> props;

  /// 在子菜单项中查询是否包含选中的菜单
  bool containsValue(List<TMenuProps<T>> props, T? value) {
    if (value == null) {
      return false;
    }
    for (var prop in props) {
      if (prop is TSubMenuProps<T>) {
        if (containsValue((prop).children, value)) {
          return true;
        }
      } else if (prop is TMenuGroupProps<T>) {
        if (containsValue((prop).children, value)) {
          return true;
        }
      } else if (prop is TMenuItemProps<T>) {
        if (prop.value == value) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var layoutProps = props;
    var menuProps = layoutProps.currentProps as TSubMenuProps<T>;
    var controller = layoutProps.controller;
    var value = menuProps.value;
    var isExpanded = controller.expanded.contains(value);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSubItem(context, isExpanded),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(menuProps.children.length, (index) {
              var props = menuProps.children[index];
              return _TMenuLayout<T>(
                props: this.props.copyWith(
                      parent: this.props,
                      level: this.props.level + 1,
                      index: index,
                      currentProps: props,
                      menus: menuProps.children,
                    ),
              );
            }),
          ),
          crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: TVar.animDurationBase,
          firstCurve: TVar.animTimeFnEasing,
          secondCurve: TVar.animTimeFnEasing,
          sizeCurve: TVar.animTimeFnEasing,
        )
      ],
    );
  }

  double? get paddingLeft {
    return _paddingLeft(props);
  }

  Widget _buildSubItem(BuildContext context, bool isExpanded) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var layoutProps = props;
    var menuProps = layoutProps.currentProps as TSubMenuProps<T>;
    var count = layoutProps.menus.length;
    var index = layoutProps.index;
    var isFirst = index == 0;
    var isLast = index == count - 1;
    var controller = layoutProps.controller;
    var value = menuProps.value;
    var collapsed = layoutProps.collapsed;
    var isActive = !isExpanded && containsValue(menuProps.children, controller.value);
    var textColor = isActive ? Colors.white : null;
    textColor ??= isExpanded ? colorScheme.fontGray1 : null;
    var disabled = menuProps.disabled;

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
    Widget? title;
    Widget? icon = menuProps.icon;

    if (collapsed) {
      alignment = Alignment.center;
    } else {
      margin = EdgeInsets.only(right: 10, left: paddingLeft ?? 16);
      alignment = Alignment.centerLeft;
      title = menuProps.title;
    }
    if (title != null && icon != null) {
      title = Padding(
        padding: EdgeInsets.only(left: TVar.spacer, right: 16),
        child: title,
      );
    }
    var textStyle = DefaultTextStyle.of(context);

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
          child: TMaterialStateBuilder(
            disabled: disabled,
            selected: isActive,
            onTap: () => _handleClick(isExpanded, controller, value),
            builder: (context, states) {
              return AnimatedContainer(
                height: 36,
                duration: TVar.animDurationSlow,
                curve: TVar.animTimeFnEasing,
                child: Container(
                  alignment: alignment,
                  padding: margin,
                  decoration: BoxDecoration(
                    color: menuBackgroundColor.resolve(states),
                    borderRadius: BorderRadius.circular(TVar.borderRadiusDefault),
                  ),
                  child: Stack(
                    // 使用Stack避免执行动画使溢出
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (icon != null) icon,
                          if (title != null) Expanded(child: title),
                        ],
                      ),
                      if (!collapsed)
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: TFakeArrow(
                            placement: isExpanded ? TFakeArrowPlacement.top : TFakeArrowPlacement.bottom,
                            color: textColor ?? textStyle.style.color,
                          ),
                        ),
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

  /// 处理点击事件
  void _handleClick(bool isExpanded, TMenuController<T> controller, T value) {
    if (isExpanded) {
      // 收起
      controller.removeExpanded({value});
    } else {
      // 展开
      if (props.expandMutex) {
        // 同级互斥
        var set = props.menus.where((element) => element != props.currentProps && element is TSubMenuProps).map((e) {
          return (e as TSubMenuProps<T>).value;
        }).toSet();
        controller.removeExpanded(set);
      }
      controller.addExpanded({value});
    }
    props.onExpand?.call(controller.expanded);
  }
}
