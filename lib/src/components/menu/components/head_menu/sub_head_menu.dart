part of '../../head_menu.dart';

/// 次级菜单
class _TSubHeadMenu<T> extends StatelessWidget {
  const _TSubHeadMenu({
    super.key,
    required this.props,
  });

  /// 布局属性
  final _THeadMenuItemLayoutProps<T> props;

  bool get isPopup => props.expandType == TMenuExpandType.popup;

  @override
  Widget build(BuildContext context) {
    var menuProps = props.currentProps as TSubMenuProps<T>;
    var controller = props.controller;
    var disabled = menuProps.disabled;
    var value = menuProps.value;

    if (props.expandType == TMenuExpandType.normal) {
      // tabs样式
      if (props.level == 1) {
        return _buildSubButton(context);
      }
    } else {
      var defaultTextStyle = DefaultTextStyle.of(context);
      var iconTheme = IconTheme.of(context);
      // 浮层样式
      return TPopup(
        disabled: disabled,
        content: TSingleChildScrollView(
          child: IconTheme(
            data: iconTheme,
            child: DefaultTextStyle(
              style: defaultTextStyle.style,
              child: _buildItem(menuProps),
            ),
          ),
        ),
        destroyOnClose: false,
        style: TPopupStyle(
          margin: props.level == 1 ? const EdgeInsets.only(top: 20) : const EdgeInsets.only(left: 20),
          radius: BorderRadius.circular(TVar.borderRadiusMedium),
        ),
        showDuration: const Duration(milliseconds: 50),
        hideDuration: const Duration(milliseconds: 50),
        onOpen: () => _handleClick(false, controller, value),
        onClose: () => _handleClick(true, controller, value),
        placement: props.level == 1 ? TPopupPlacement.bottomLeft : TPopupPlacement.rightTop,
        child: _buildSubButton(context),
      );
    }
    return Container();
  }

  /// 子项菜单项
  Widget _buildItem(TSubMenuProps<T> menuProps) {
    return FixedCrossFlex(
      direction: Axis.vertical,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(menuProps.children.length, (index) {
        var props = menuProps.children[index];
        return _THeadMenuLayout<T>(
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

  Widget _buildSubButton(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var menuProps = props.currentProps as TSubMenuProps<T>;
    var index = props.index;
    var isFirst = index == 0;
    var controller = props.controller;
    var disabled = menuProps.disabled;
    var value = menuProps.value;
    var isActive = controller.containsValue(menuProps.children);
    var expanded = !disabled && controller.expanded.contains(value);
    // 波纹颜色
    var fixedRippleColor = theme.isLight ? colorScheme.gray3 : colorScheme.gray11;

    // 文本颜色
    var textColor = MaterialStateProperty.resolveWith((states) {
      if(states.contains(MaterialState.selected) && isPopup && props.level > 1) {
        return theme.isLight ? colorScheme.brandColor : colorScheme.textColorAnti;
      }
      if (states.contains(MaterialState.selected) || expanded) {
        return theme.isLight ? colorScheme.fontGray1 : colorScheme.textColorAnti;
      }
      if (states.contains(MaterialState.disabled)) {
        return theme.isLight ? colorScheme.fontGray4 : colorScheme.fontWhite4;
      }
      return null;
    });
    //背景颜色
    MaterialStateProperty<Color?> menuBackgroundColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        if (isPopup && props.level > 1) {
          return theme.isLight ? const Color(0xffecf2fe) : colorScheme.gray10;
        }
        return theme.isLight ? colorScheme.gray2 : colorScheme.gray9;
      }
      if (states.contains(MaterialState.hovered) && (!isPopup || props.level > 1)) {
        return theme.isLight ? colorScheme.gray2 : colorScheme.gray9;
      }
      return null;
    });
    Alignment? alignment;
    EdgeInsets? margin;
    EdgeInsets? padding;
    Widget? content;
    Widget? icon = menuProps.icon;
    TFakeArrowPlacement placement;

    if (isPopup && props.level > 1) {
      margin = EdgeInsets.only(top: isFirst ? 0 : 4);
      padding = const EdgeInsets.symmetric(horizontal: 16);
      placement = expanded ? TFakeArrowPlacement.left : TFakeArrowPlacement.right;
    } else {
      alignment = Alignment.center;
      margin = EdgeInsets.only(left: isFirst ? 0 : 4);
      placement = expanded ? TFakeArrowPlacement.top : TFakeArrowPlacement.bottom;
    }
    content = menuProps.title;
    if (content != null && icon != null) {
      content = Padding(
        padding: EdgeInsets.only(left: TVar.spacer),
        child: content,
      );
    }

    return Container(
      padding: margin,
      child: TRipple(
        disabled: disabled,
        selected: isActive,
        fixedRippleColor: fixedRippleColor,
        radius: BorderRadius.circular(TVar.borderRadiusDefault),
        backgroundColor: menuBackgroundColor,
        animatedDuration: TVar.animDurationSlow,
        curve: TVar.animTimeFnEasing,
        onTap: isPopup ? null : () => _handleClick(expanded, controller, value),
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
                  padding: padding,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (icon != null) icon,
                          if (content != null) content,
                        ],
                      ),
                      if (isPopup)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: TFakeArrow(
                            placement: placement,
                            dimension: 16,
                            color: textColor.resolve(states),
                          ),
                        )
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
  void _handleClick(bool isExpanded, TMenuController<T> controller, T value) {
    if (isExpanded) {
      // 收起
      controller.removeExpanded({value});
    } else {
      var set = props.menus.where((element) => element != props.currentProps && element is TSubMenuProps).map((e) {
        return (e as TSubMenuProps<T>).value;
      }).toSet();
      controller.removeExpanded(set);
      // 展开
      controller.addExpanded({value});
    }
    props.onExpand?.call(controller.expanded);
  }
}
