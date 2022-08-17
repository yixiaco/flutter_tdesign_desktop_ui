import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 下拉菜单
/// 用于承载过多的操作集合，通过下拉拓展的形式，收纳更多的操作。
class TDropdown<T> extends StatelessWidget {
  const TDropdown({
    Key? key,
    this.direction = TDropdownDirection.right,
    this.disabled = false,
    this.hideAfterItemClick = true,
    this.maxColumnWidth = 100,
    this.minColumnWidth = 10,
    this.maxHeight = 300,
    required this.options,
    this.placement = TPopupPlacement.bottomLeft,
    this.trigger = TPopupTrigger.hover,
    this.onClick,
    required this.child,
  }) : super(key: key);

  /// 多层级操作时，子层级展开方向
  final TDropdownDirection direction;

  /// 是否禁用组件
  final bool disabled;

  /// 点击选项后是否自动隐藏弹窗
  final bool hideAfterItemClick;

  /// 选项最大宽度，内容超出时，显示为省略号。
  final double maxColumnWidth;

  /// 选项最小宽度
  final double minColumnWidth;

  /// 弹窗最大高度。统一控制每一列的高度
  final double maxHeight;

  /// 下拉操作项
  final List<TDropdownOption<T>> options;

  /// 弹窗定位方式，可选值同 Popup 组件
  final TPopupPlacement placement;

  /// 触发下拉显示的方式
  final TPopupTrigger trigger;

  /// 下拉操作项点击时触发
  final TValueChange<TDropdownOption<T>>? onClick;

  /// 子组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    return TPopup(
      disabled: disabled,
      content: _TDropdownMenu<T>(
        minColumnWidth: minColumnWidth,
        maxColumnWidth: maxColumnWidth,
        maxHeight: maxHeight,
        options: options,
      ),
      style: TPopupStyle(
          backgroundColor: colorScheme.bgColorContainer,
          padding: EdgeInsets.zero,
          border: BubbleBoxBorder(
            width: 1 / MediaQuery.of(context).devicePixelRatio,
            color: colorScheme.borderLevel2Color,
          )),
      placement: placement,
      trigger: trigger,
      child: child,
    );
  }
}

/// 下拉菜单面板
class _TDropdownMenu<T> extends StatefulWidget {
  const _TDropdownMenu({
    Key? key,
    required this.maxColumnWidth,
    required this.minColumnWidth,
    required this.maxHeight,
    required this.options,
    this.onClick,
  }) : super(key: key);

  /// 选项最大宽度，内容超出时，显示为省略号。
  final double maxColumnWidth;

  /// 选项最小宽度
  final double minColumnWidth;

  /// 弹窗最大高度。统一控制每一列的高度
  final double maxHeight;

  /// 下拉操作项
  final List<TDropdownOption<T>> options;

  /// 下拉操作项点击时触发
  final TValueChange<TDropdownOption<T>>? onClick;

  @override
  State<_TDropdownMenu<T>> createState() => _TDropdownMenuState<T>();
}

class _TDropdownMenuState<T> extends State<_TDropdownMenu<T>> {
  List<TDropdownOption<T>> levelOptions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    levelOptions.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    levelOptions.clear();
  }

  @override
  Widget build(BuildContext context) {
    // var theme = TTheme.of(context);
    // var colorScheme = theme.colorScheme;

    List<Widget> menus = [];
    // root
    menus.add(buildMenu(widget.options, 0));
    menus.addAll(List.generate(levelOptions.length, (index) => buildMenu(levelOptions[index].children!, index + 1)));

    var list = menus
        .expand((element) => [
              element,
              const TDivider(
                layout: Axis.vertical,
                space: 0,
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
              )
            ])
        .toList();
    list.removeLast();

    return FixedCrossFlex(
      mainAxisSize: MainAxisSize.min,
      direction: Axis.horizontal,
      children: list,
    );
  }

  ConstrainedBox buildMenu(List<TDropdownOption<T>> options, int level) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widget.minColumnWidth,
        maxWidth: widget.maxColumnWidth,
        maxHeight: widget.maxHeight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ScrollConfiguration(
          behavior: const TScrollBehavior(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(right: 2),
            child: FixedCrossFlex(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              direction: Axis.vertical,
              children: List.generate(options.length, (index) {
                var option = options[index];
                return _TDropdownItem<T>(
                  option: option,
                  onHover: (hover) {
                    if (hover) {
                      if (levelOptions.length > level) {
                        setState(() {
                          levelOptions.removeRange(level, levelOptions.length);
                        });
                      }
                      if (option.children?.isNotEmpty ?? false) {
                        setState(() {
                          levelOptions.add(option);
                        });
                      }
                    }
                  },
                  onPressed: () {
                    widget.onClick?.call(option);
                    option.onClick?.call(option);
                  },
                  minColumnWidth: widget.minColumnWidth,
                  maxColumnWidth: widget.maxColumnWidth,
                );
              }).expand((element) {
                var list = <Widget>[element];
                if (element.option.divider) {
                  // 让组件被自动拉伸
                  list.add(const TDivider(
                    space: 0,
                    margin: EdgeInsets.symmetric(vertical: 4),
                  ));
                }
                return list;
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

/// 下拉菜单面板子项
class _TDropdownItem<T> extends StatefulWidget {
  const _TDropdownItem({
    Key? key,
    required this.option,
    this.onPressed,
    this.onHover,
    required this.maxColumnWidth,
    required this.minColumnWidth,
    this.parent,
  }) : super(key: key);

  /// 父选项数据
  final TDropdownOption<T>? parent;

  /// 选项数据
  final TDropdownOption<T> option;

  /// 点击
  final void Function()? onPressed;

  /// 悬浮
  final void Function(bool hover)? onHover;

  /// 选项最大宽度，内容超出时，显示为省略号。
  final double maxColumnWidth;

  /// 选项最小宽度
  final double minColumnWidth;

  @override
  State<_TDropdownItem<T>> createState() => _TDropdownItemState<T>();
}

class _TDropdownItemState<T> extends State<_TDropdownItem<T>> with MaterialStateMixin {
  @override
  void initState() {
    super.initState();
    setMaterialState(MaterialState.disabled, widget.option.disabled);
  }

  @override
  void didUpdateWidget(covariant _TDropdownItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(MaterialState.disabled, widget.option.disabled);
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var effectiveCursor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    var effectiveTextColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colorScheme.textColorDisabled;
      }
      return colorScheme.textColorPrimary;
    });

    // 覆盖色
    final MaterialStateProperty<Color?> overlayColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) {
        return colorScheme.bgColorContainerHover;
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        return colorScheme.bgColorContainerActive;
      }
      return null;
    });

    var children = <Widget>[widget.option.content];
    if (widget.option.children?.isNotEmpty ?? false) {
      children.add(Icon(
        TIcons.chevronRight,
        size: theme.fontData.fontSizeL,
        color: effectiveTextColor.resolve(materialStates),
      ));
    }
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widget.minColumnWidth,
        maxWidth: widget.maxColumnWidth,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: TVar.spacer * .5, horizontal: TVar.spacer),
        child: Material(
          textStyle: TextStyle(
            fontFamily: theme.fontFamily,
            color: effectiveTextColor.resolve(materialStates),
            overflow: TextOverflow.ellipsis,
          ),
          color: Colors.transparent,
          animationDuration: TVar.animDurationBase,
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.option.disabled ? null : () => widget.onPressed?.call(),
            onHighlightChanged: updateMaterialState(MaterialState.pressed),
            onHover: updateMaterialState(
              MaterialState.hovered,
              onChanged: widget.onHover,
            ),
            mouseCursor: effectiveCursor.resolve(materialStates),
            enableFeedback: true,
            canRequestFocus: !widget.option.disabled,
            splashFactory: InkBevelAngle.splashFactory,
            overlayColor: overlayColor,
            borderRadius: BorderRadius.circular(TVar.borderRadiusDefault),
            highlightColor: Colors.transparent,
            child: AnimatedPadding(
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: TVar.spacer),
              duration: TVar.animDurationBase,
              curve: TVar.animTimeFnEaseIn,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
