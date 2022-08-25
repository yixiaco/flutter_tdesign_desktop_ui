part of 'tabs.dart';

/// 标签按钮
class _TabButton<T> extends StatefulWidget {
  const _TabButton({
    Key? key,
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
  }) : super(key: key);

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
        feedback: _buildButton(context, {...states, MaterialState.hovered, MaterialState.dragged}, false),
        childWhenDragging: _buildButton(context, {...states, MaterialState.dragged, MaterialState.disabled}, true),
        child: DragTarget<_TabButtonDraggableData<T>>(
          builder: (context, candidateData, rejectedData) {
            return _buildButton(context, states, true);
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
      child = _buildButton(context, states, true);
    }

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: value,
      child: child,
    );
  }

  Widget _buildButton(BuildContext context, Set<MaterialState> states, bool showRemoveIcon) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? theme.size;
    var isCard = widget.theme == TTabsTheme.card;

    // 鼠标
    final effectiveMouseCursor = MaterialStateProperty.resolveWith<MouseCursor>((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    // 字体颜色
    final textColor = MaterialStateProperty.resolveWith((states) {
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
    MaterialStateProperty<Color?> effectiveBgColor;
    // 覆盖色
    MaterialStateProperty<Color?> effectiveOverlayColor;
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
          if (states.contains(MaterialState.dragged)) {
            return Colors.transparent;
          }
          return colorScheme.bgColorContainer;
        });
        effectiveOverlayColor = MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return colorScheme.bgColorContainerHover;
          }
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            return colorScheme.bgColorContainerActive;
          }
          return null;
        });
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
          return colorScheme.bgColorSecondaryContainer;
        });
        effectiveOverlayColor = MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered)) {
            return colorScheme.bgColorSecondaryContainerHover;
          }
          if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
            return colorScheme.bgColorSecondaryContainerActive;
          }
          return null;
        });
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

    var isNotTap = widget.disabled || widget.checked;
    var iconThemeData = IconThemeData(
      size: theme.fontData.fontSizeL,
      color: textColor.resolve(states),
    );
    var removable = widget.removable && showRemoveIcon;
    Widget child = InkWell(
      onFocusChange: handleFocusHighlightChanged,
      onHighlightChanged: handleHoverChanged,
      mouseCursor: effectiveMouseCursor.resolve(states),
      onTapDown: isNotTap ? null : handleTapDown,
      onTap: isNotTap ? null : handleTap,
      onTapUp: handleTapEnd,
      onTapCancel: handleTapEnd,
      canRequestFocus: !isNotTap,
      splashFactory: InkBevelAngle.splashFactory,
      overlayColor: effectiveOverlayColor,
      borderRadius: radius,
      child: IconTheme(
        data: iconThemeData,
        child: Container(
          padding: padding,
          color: effectiveOverlayColor.resolve(states),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.child,
              if (removable && isCard) _buildCloseIcon(effectiveIconColor, iconThemeData),
            ],
          ),
        ),
      ),
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
      switch (widget.placement) {
        case TTabsPlacement.top:
          decoration = BoxDecoration(
            border: Border(
              right: borderSide,
              bottom: widget.checked ? BorderSide.none : borderSide,
            ),
          );
          break;
        case TTabsPlacement.bottom:
          decoration = BoxDecoration(
            border: Border(
              right: borderSide,
              top: widget.checked ? BorderSide.none : borderSide,
            ),
          );
          break;
        case TTabsPlacement.left:
          decoration = BoxDecoration(
            border: Border(
              bottom: borderSide,
              right: widget.checked ? BorderSide.none : borderSide,
            ),
          );
          break;
        case TTabsPlacement.right:
          decoration = BoxDecoration(
            border: Border(
              bottom: borderSide,
              left: widget.checked ? BorderSide.none : borderSide,
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
      textStyle: TextStyle(
        fontSize: size.sizeOf(
          small: theme.fontData.fontSizeBodyMedium,
          medium: theme.fontData.fontSizeBodyMedium,
          large: theme.fontData.fontSizeBodyLarge,
        ),
        color: textColor.resolve(states),
      ),
      color: effectiveBgColor.resolve(states),
      child: Container(
        decoration: decoration,
        height: isCard ? null : height,
        padding: margin,
        child: child,
      ),
    );
    return child;
  }

  Padding _buildCloseIcon(MaterialStateProperty<Color?> effectiveIconColor, IconThemeData iconThemeData) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TMaterialStateBuilder(
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