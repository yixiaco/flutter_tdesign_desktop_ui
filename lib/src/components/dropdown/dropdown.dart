import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 下拉菜单
/// 用于承载过多的操作集合，通过下拉拓展的形式，收纳更多的操作。
class TDropdown<T> extends StatefulWidget {
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
  State<TDropdown<T>> createState() => _TDropdownState<T>();
}

class _TDropdownState<T> extends State<TDropdown<T>> {
  late ValueNotifier<bool> visible;

  @override
  void initState() {
    super.initState();
    visible = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();
    visible.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    return TPopup(
      visible: visible,
      disabled: widget.disabled,
      content: _TDropdownMenu<T>(
        direction: widget.direction,
        minColumnWidth: widget.minColumnWidth,
        maxColumnWidth: widget.maxColumnWidth,
        maxHeight: widget.maxHeight,
        options: widget.options,
        onClick: (value) {
          widget.onClick?.call(value);
          if (widget.hideAfterItemClick) {
            visible.value = false;
          }
        },
      ),
      style: TPopupStyle(
        backgroundColor: colorScheme.bgColorContainer,
        padding: EdgeInsets.zero,
        border: BubbleBoxBorder(
          width: 1 / MediaQuery.of(context).devicePixelRatio,
          color: colorScheme.borderLevel2Color,
        ),
      ),
      placement: widget.placement,
      trigger: widget.trigger,
      child: widget.child,
    );
  }
}

/// 下拉菜单面板
class _TDropdownMenu<T> extends StatefulWidget {
  const _TDropdownMenu({
    Key? key,
    required this.direction,
    required this.maxColumnWidth,
    required this.minColumnWidth,
    required this.maxHeight,
    required this.options,
    this.onClick,
  }) : super(key: key);

  /// 多层级操作时，子层级展开方向
  final TDropdownDirection direction;

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
  /// 多级选项
  List<TDropdownOption<T>> levelOptions = [];

  /// 高亮选项
  List<TDropdownOption<T>> highlightOptions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    levelOptions.clear();
    highlightOptions.clear();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    levelOptions.clear();
    highlightOptions.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> menus = [];
    // root
    menus.add(buildMenu(widget.options, null, 0));
    menus.addAll(List.generate(
      levelOptions.length,
      (index) => buildMenu(
        levelOptions[index].children!,
        levelOptions[index],
        index + 1,
      ),
    ));

    const divider = TDivider(
      layout: Axis.vertical,
      space: 0,
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
    );
    var list = menus.expand((element) => [element, divider]).toList();
    list.removeLast();

    return FixedCrossFlex(
      textDirection: widget.direction == TDropdownDirection.left ? TextDirection.rtl : TextDirection.ltr,
      mainAxisSize: MainAxisSize.min,
      direction: Axis.horizontal,
      children: list,
    );
  }

  ConstrainedBox buildMenu(List<TDropdownOption<T>> options, TDropdownOption<T>? parent, int level) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: widget.minColumnWidth,
        maxWidth: widget.maxColumnWidth,
        maxHeight: widget.maxHeight,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: TSingleChildScrollView(
          child: FixedCrossFlex(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: Axis.vertical,
            children: List.generate(options.length, (index) {
              var option = options[index];
              return _TDropdownItem<T>(
                option: option,
                parent: parent,
                highlight: highlightOptions.contains(option),
                onHover: (hover) {
                  bool update = false;
                  if (hover) {
                    if (highlightOptions.length > level) {
                      highlightOptions.removeRange(level, highlightOptions.length);
                      update = true;
                    }
                    if (parent != null) {
                      highlightOptions.add(parent);
                      update = true;
                    }
                    if (levelOptions.length > level) {
                      levelOptions.removeRange(level, levelOptions.length);
                      update = true;
                    }
                    if (option.children?.isNotEmpty ?? false) {
                      levelOptions.add(option);
                      update = true;
                    }
                  }
                  if (update) {
                    setState(() {});
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
    this.highlight = false,
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

  /// 是否高亮
  final bool highlight;

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
      return widget.highlight ? colorScheme.brandColor : colorScheme.textColorPrimary;
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

    Widget? suffix;
    if (widget.option.children?.isNotEmpty ?? false) {
      suffix = Icon(
        TIcons.chevronRight,
        size: theme.fontData.fontSizeL,
        color: effectiveTextColor.resolve(materialStates),
      );
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
          color: widget.highlight ? colorScheme.brandColorLight : Colors.transparent,
          borderRadius: BorderRadius.circular(TVar.borderRadiusDefault),
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
            highlightColor: Colors.transparent,
            borderRadius: BorderRadius.circular(TVar.borderRadiusDefault),
            child: AnimatedPadding(
              padding: EdgeInsets.symmetric(vertical: 9, horizontal: TVar.spacer),
              duration: TVar.animDurationBase,
              curve: TVar.animTimeFnEaseIn,
              child: TDecorationBox(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                suffix: suffix,
                child: widget.option.content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
