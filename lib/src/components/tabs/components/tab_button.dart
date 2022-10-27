part of '../tabs.dart';

/// 标签按钮
class _TabButton<T> extends StatefulWidget {
  const _TabButton({
    super.key,
    this.disabled = false,
    required this.dragSort,
    required this.checked,
    required this.child,
    required this.theme,
    required this.placement,
    this.size,
    this.onChange,
    required this.removable,
    this.onRemove,
    this.onDragSort,
    required this.value,
    required this.index,
  });

  /// 是否禁用组件
  final bool disabled;

  /// 是否开启拖拽调整顺序
  final bool dragSort;

  /// 是否选中状态
  final bool checked;

  /// 子组件
  final Widget child;

  /// 选项卡风格
  final TTabsTheme theme;

  /// 选项卡位置
  final TTabsPlacement placement;

  /// 组件大小
  final TComponentSize? size;

  /// 选中状态变化时触发
  final void Function(bool checked)? onChange;

  /// 当前选项卡是否允许移除
  final bool removable;

  /// 删除选项卡时触发
  final void Function(T value, int index)? onRemove;

  /// 拖拽排序时触发
  final void Function(int currentIndex, T current, int targetIndex, T target)? onDragSort;

  /// 总数
  final T value;

  /// 索引值
  final int index;

  @override
  State<_TabButton<T>> createState() => _TabButtonState<T>();
}

/// 拖拽数据
class _TabButtonDraggableData<T> {
  const _TabButtonDraggableData({
    required this.currentIndex,
    required this.current,
  });

  final int currentIndex;
  final T current;
}

class _TabButtonState<T> extends State<_TabButton<T>> with TickerProviderStateMixin, TToggleableStateMixin {
  @override
  Widget build(BuildContext context) {
    Widget child;

    if (widget.dragSort) {
      child = Draggable<_TabButtonDraggableData<T>>(
        data: _TabButtonDraggableData<T>(currentIndex: widget.index, current: widget.value),
        feedback:
            _buildButton(context, {...states, MaterialState.hovered, MaterialState.dragged}, showRemoveIcon: false),
        childWhenDragging: _buildButton(context, {...states, MaterialState.dragged, MaterialState.disabled}),
        child: DragTarget<_TabButtonDraggableData<T>>(
          builder: (context, candidateData, rejectedData) {
            if (candidateData.isNotEmpty) {
              return _buildButton(context, states, showDashed: true);
            }
            return _buildButton(context, states);
          },
          onWillAccept: (data) {
            return data != null;
          },
          onAccept: (data) {
            widget.onDragSort?.call(data.currentIndex, data.current, widget.index, widget.value);
          },
        ),
      );
    } else {
      child = _buildButton(context, states);
    }

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: value,
      child: child,
    );
  }

  Widget _buildButton(
    BuildContext context,
    Set<MaterialState> states, {
    bool showRemoveIcon = true,
    bool showDashed = false,
  }) {
    var theme = TTheme.of(context);
    var buttonStyle = TTabsStyle.of(context).buttonStyle;
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? theme.size;
    var isCard = widget.theme == TTabsTheme.card;

    // 鼠标
    final effectiveMouseCursor = buttonStyle?.cursor ?? TMaterialStateMouseCursor.clickable;

    // 字体颜色
    MaterialStateProperty<Color> textColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.dragged)) {
        if (states.contains(MaterialState.selected)) {
          return colorScheme.brandColorDisabled;
        }
      }
      if (states.contains(MaterialState.disabled)) {
        return colorScheme.textColorDisabled;
      }
      if (states.contains(MaterialState.selected)) {
        return colorScheme.brandColor;
      }
      return colorScheme.textColorSecondary;
    });

    // 背景色
    MaterialStateProperty<Color> effectiveBgColor;
    // 覆盖色
    Color fixedRippleColor;
    // icon颜色
    MaterialStateProperty<Color?> effectiveIconColor;
    // 外边距
    EdgeInsetsGeometry margin = EdgeInsets.zero;
    // 内边距
    EdgeInsetsGeometry padding = EdgeInsets.zero;
    // 圆角
    BorderRadius? radius;

    switch (widget.theme) {
      case TTabsTheme.normal:
        margin = const EdgeInsets.only(left: 8, right: 8);
        padding = size.lazySizeOf(
          small: () => const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          medium: () => const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          large: () => const EdgeInsets.symmetric(vertical: 9, horizontal: 12),
        );
        radius = BorderRadius.circular(TVar.borderRadiusDefault);
        effectiveBgColor = MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.transparent;
          }
          if (states.contains(MaterialState.hovered) || states.contains(MaterialState.dragged)) {
            return colorScheme.bgColorContainerHover;
          }
          return Colors.transparent;
        });
        fixedRippleColor = colorScheme.bgColorContainerActive;
        effectiveIconColor = MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.textColorDisabled;
          }
          if (states.contains(MaterialState.selected)) {
            return colorScheme.brandColor;
          }
          return colorScheme.textColorSecondary;
        });
        break;
      case TTabsTheme.card:
        padding = size.lazySizeOf(
          small: () => const EdgeInsets.only(left: 16, right: 16),
          medium: () => const EdgeInsets.only(left: 16, right: 16),
          large: () => const EdgeInsets.only(left: 24, right: 24),
        );
        effectiveBgColor = MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return colorScheme.bgColorContainer;
          }
          if (states.contains(MaterialState.hovered)) {
            return colorScheme.bgColorSecondaryContainerHover;
          }
          return colorScheme.bgColorSecondaryContainer;
        });
        fixedRippleColor = colorScheme.bgColorSecondaryContainerActive;
        effectiveIconColor = MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return colorScheme.textColorDisabled;
          }
          if (states.contains(MaterialState.hovered)) {
            return colorScheme.textColorPrimary;
          }
          return colorScheme.textColorSecondary;
        });
        break;
    }

    if (buttonStyle?.backgroundColor != null) {
      effectiveBgColor = MaterialStateProperty.resolveWith((states) {
        return MaterialStateProperty.resolveAs(buttonStyle!.backgroundColor!, states);
      });
    }
    if (buttonStyle?.textColor != null) {
      textColor = MaterialStateProperty.resolveWith((states) {
        return MaterialStateProperty.resolveAs(buttonStyle!.textColor!, states);
      });
    }
    if (buttonStyle?.closeIconColor != null) {
      effectiveIconColor = MaterialStateProperty.resolveWith((states) {
        return MaterialStateProperty.resolveAs(buttonStyle!.closeIconColor!, states);
      });
    }
    fixedRippleColor = buttonStyle?.rippleColor ?? fixedRippleColor;

    var isNotTap = widget.disabled || widget.checked;

    var iconTheme = IconTheme.of(context);
    var iconThemeData = iconTheme.merge(IconThemeData(
      color: textColor.resolve(states),
    ));
    var removable = widget.removable && showRemoveIcon;
    Decoration? dashedDecoration;
    if (showDashed) {
      dashedDecoration = ShapeDecoration(
        shape: BubbleShapeBorder(
          border: BubbleBoxBorder(
            style: BubbleBoxBorderStyle.dashed,
            color: colorScheme.brandColor,
            width: 1 / MediaQuery.of(context).devicePixelRatio,
          ),
          radius: radius,
        ),
      );
    }
    Widget child = TRipple(
      fixedRippleColor: fixedRippleColor,
      disabled: isNotTap,
      cursor: MaterialStateProperty.all(effectiveMouseCursor.resolve(states)),
      onTap: isNotTap ? null : handleTap,
      onTapUp: handleTapEnd,
      onTapCancel: handleTapEnd,
      selected: widget.checked,
      onHover: handleHoverChanged,
      onFocusChange: handleFocusHighlightChanged,
      backgroundColor: MaterialStateProperty.all(effectiveBgColor.resolve(states)),
      radius: radius,
      builder: (context, states) {
        return IconTheme(
          data: iconThemeData,
          child: Container(
            decoration: dashedDecoration,
            padding: padding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.child,
                if (removable && isCard) _buildCloseIcon(effectiveIconColor, iconThemeData),
              ],
            ),
          ),
        );
      },
    );
    if (removable && !isCard) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [child, _buildCloseIcon(effectiveIconColor, iconThemeData)],
      );
    }

    double height = size.sizeOf(small: 48, medium: 48, large: 64);

    // 边框
    Decoration? decoration;
    if (isCard) {
      child = SizedBox(
        height: height,
        child: child,
      );
      var borderSide = BorderSide(color: colorScheme.componentStroke);
      var bgBorderSide = BorderSide(color: effectiveBgColor.resolve(states));
      switch (widget.placement) {
        case TTabsPlacement.top:
          decoration = BoxDecoration(
            border: Border(
              right: borderSide,
              bottom: widget.checked ? bgBorderSide : borderSide,
            ),
          );
          break;
        case TTabsPlacement.bottom:
          decoration = BoxDecoration(
            border: Border(
              right: borderSide,
              top: widget.checked ? bgBorderSide : borderSide,
            ),
          );
          break;
        case TTabsPlacement.left:
          decoration = BoxDecoration(
            border: Border(
              bottom: borderSide,
              right: widget.checked ? bgBorderSide : borderSide,
            ),
          );
          break;
        case TTabsPlacement.right:
          decoration = BoxDecoration(
            border: Border(
              bottom: borderSide,
              left: widget.checked ? bgBorderSide : borderSide,
            ),
          );
          break;
      }
    } else {
      // 如果是normal模式，则不能填充大小
      child = UnconstrainedBox(
        alignment: Alignment.centerLeft,
        child: child,
      );
    }

    child = Material(
      color: Colors.transparent,
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: textColor.resolve(states),
        ),
        child: Container(
          decoration: decoration,
          height: isCard ? null : height,
          padding: margin,
          child: child,
        ),
      ),
    );
    return child;
  }

  Padding _buildCloseIcon(MaterialStateProperty<Color?> effectiveIconColor, IconThemeData iconThemeData) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TMaterialStateButton(
        selected: widget.checked,
        disabled: widget.disabled,
        onTap: () => widget.onRemove?.call(widget.value, widget.index),
        builder: (BuildContext context, Set<MaterialState> states) {
          return TAnimatedIcon(
            duration: TVar.animDurationBase,
            curve: TVar.animTimeFnEasing,
            color: effectiveIconColor.resolve(states),
            data: iconThemeData,
            child: const Icon(TIcons.close),
          );
        },
      ),
    );
  }

  @override
  ValueChanged<bool?>? get onChanged {
    return (value) => widget.onChange?.call(value ?? false);
  }

  @override
  bool get tristate => false;

  @override
  bool? get value => widget.checked;

  @override
  bool get isInteractive => !widget.disabled;
}
