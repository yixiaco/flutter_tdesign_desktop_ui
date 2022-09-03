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
    var collapsed = layoutProps.collapsed;
    var disabled = menuProps.disabled;
    // 不收缩、不禁用、在展开的列表中才展开
    var isExpanded = !collapsed && !disabled && controller.expanded.contains(value);
    var isPopup = collapsed || layoutProps.expandType == TMenuExpandType.popup;

    var defaultTextStyle = DefaultTextStyle.of(context);
    var iconTheme = IconTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isPopup)
          TPopup(
            disabled: disabled,
            content: IconTheme(
              data: iconTheme,
              child: DefaultTextStyle(
                style: defaultTextStyle.style,
                child: _buildItem(menuProps),
              ),
            ),
            destroyOnClose: false,
            style: TPopupStyle(
              width: 216,
              margin: const EdgeInsets.only(left: 20),
              radius: BorderRadius.circular(TVar.borderRadiusMedium),
            ),
            showDuration: const Duration(milliseconds: 50),
            hideDuration: const Duration(milliseconds: 50),
            onOpen: () {
              print('打开');
              _handleClick(false, controller, value);
            },
            onClose: () => _handleClick(true, controller, value),
            placement: TPopupPlacement.rightTop,
            child: _buildSubItem(context, isExpanded),
          ),
        if (!isPopup) _buildSubItem(context, isExpanded),
        if (!isPopup) _buildNormalItem(context, isExpanded),
      ],
    );
  }

  /// 常规方式打开
  Widget _buildNormalItem(BuildContext context, bool isExpanded) {
    var layoutProps = props;
    var menuProps = layoutProps.currentProps as TSubMenuProps<T>;

    return AnimatedCrossFade(
      firstChild: Container(),
      secondChild: _buildItem(menuProps),
      crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: TVar.animDurationBase,
      firstCurve: TVar.animTimeFnEasing,
      secondCurve: TVar.animTimeFnEasing,
      sizeCurve: TVar.animTimeFnEasing,
    );
  }

  /// 子项菜单项
  Widget _buildItem(TSubMenuProps<T> menuProps) {
    return Column(
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
    );
  }

  double? get paddingLeft {
    return _paddingLeft(props);
  }

  /// 次级菜单项
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
    textColor ??= isExpanded ? (theme.isLight ? colorScheme.fontGray1 : Colors.white) : null;
    var disabled = menuProps.disabled;

    var menuBackgroundColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return colorScheme.brandColor;
      }
      if (states.contains(MaterialState.disabled) && states.contains(MaterialState.selected)) {
        return colorScheme.brandColorDisabled;
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
              return SizedBox(
                height: 36,
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
