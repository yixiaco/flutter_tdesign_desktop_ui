import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 选项卡
/// 用于承载同一层级下不同页面或类别的组件，方便用户在同一个页面框架下进行快速切换。
class TTabs<T> extends StatefulWidget {
  const TTabs({
    Key? key,
    this.addable = false,
    this.disabled = false,
    this.dragSort = false,
    required this.value,
    required this.list,
    this.placement = TTabsPlacement.top,
    this.size,
    this.theme = TTabsTheme.normal,
    this.onAdd,
    this.onChange,
    this.onDragSort,
    this.onRemove,
  }) : super(key: key);

  /// 选项卡是否可增加
  final bool addable;

  /// 是否禁用选项卡
  final bool disabled;

  /// 是否开启拖拽调整顺序
  final bool dragSort;

  /// 激活的选项卡值
  final T? value;

  ///	选项卡列表
  final List<TTabsPanel<T>> list;

  /// 选项卡位置
  final TTabsPlacement placement;

  /// 组件尺寸
  final TComponentSize? size;

  /// 选项卡风格
  final TTabsTheme theme;

  /// 点击添加选项卡时触发
  final void Function()? onAdd;

  /// 激活的选项卡发生变化时触发
  final void Function(T value)? onChange;

  /// 拖拽排序时触发
  final void Function(int currentIndex, T current, int targetIndex, T target)? onDragSort;

  /// 删除选项卡时触发
  final void Function(T value, int index)? onRemove;

  /// 当前下标
  int get _index => list.indexWhere((element) => element.value == value);

  @override
  State<TTabs<T>> createState() => _TTabsState<T>();
}

class _TTabsState<T> extends State<TTabs<T>> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late List<GlobalKey> _tabKeys;
  final _LabelPainter _painter = _LabelPainter();
  late AnimationController _controller;
  late CurvedAnimation _position;
  late bool _showScroll;

  @override
  void initState() {
    super.initState();
    _showScroll = false;
    if (widget._index != -1) {
      _pageController = PageController(initialPage: widget._index);
    }
    _tabKeys = widget.list.map((option) => GlobalKey()).toList();
    _controller = AnimationController(
      vsync: this,
      duration: TVar.animDurationBase,
      value: widget._index != -1 ? 1 : 0,
    );
    _position = CurvedAnimation(
      parent: _controller,
      curve: TVar.animTimeFnEasing,
      reverseCurve: TVar.animTimeFnEasing.flipped,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _painter.dispose();
    _pageController.dispose();
    _controller.dispose();
    _position.dispose();
  }

  @override
  void didUpdateWidget(covariant TTabs<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.list.length > _tabKeys.length) {
      final int delta = widget.list.length - _tabKeys.length;
      _tabKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.list.length < _tabKeys.length) {
      _tabKeys.removeRange(widget.list.length, _tabKeys.length);
    }
    if (widget.list.length != _tabKeys.length || widget.value != oldWidget.value) {
      _painter._oldRect = _painter._currentRect;
      if (widget._index != -1) {
        _controller.forward(from: 0);
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);

    return _buildLabel(theme);
  }

  /// 构建标签
  Widget _buildLabel(TThemeData theme) {
    var colorScheme = theme.colorScheme;
    Axis direction;
    switch (widget.placement) {
      case TTabsPlacement.top:
      case TTabsPlacement.bottom:
        direction = Axis.horizontal;
        break;
      case TTabsPlacement.left:
      case TTabsPlacement.right:
        direction = Axis.vertical;
        break;
    }
    Widget child = TSingleChildScrollView(
      scrollDirection: direction,
      showScroll: false,
      onShowScroll: (showScroll) {
        /// 显示滚动
        setState(() {
          _showScroll = true;
        });
      },
      child: Flex(
        direction: direction,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.list.length, (index) {
          var panel = widget.list[index];
          return KeyedSubtree(
            key: _tabKeys[index],
            child: _TabButton<T>(
              checked: widget.value == panel.value,
              placement: widget.placement,
              theme: widget.theme,
              size: widget.size,
              disabled: widget.disabled || panel.disabled,
              onChange: (checked) => widget.onChange?.call(panel.value),
              index: index,
              count: widget.list.length,
              onRemove: (value, index) {
                panel.onRemove?.call(value);
                widget.onRemove?.call(value, index);
              },
              removable: panel.removable,
              child: panel.label,
            ),
          );
        }),
      ),
    );

    switch (widget.theme) {
      case TTabsTheme.normal:
        return CustomPaint(
          foregroundPainter: _painter
            ..placement = widget.placement
            ..trackColor = colorScheme.bgColorSecondaryContainer
            ..t = _position
            ..tabKeys = _tabKeys
            ..color = colorScheme.brandColor
            ..index = widget._index
            ..strokeWidth = 1,
          child: child,
        );
      case TTabsTheme.card:
        return child;
    }
  }
}

/// tab painter
class _LabelPainter extends AnimationChangeNotifierPainter {
  Rect? _oldRect;
  Rect? _currentRect;

  int get index => _index!;
  int? _index;

  set index(int value) {
    if (value == _index) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  Color get color => _color!;
  Color? _color;

  set color(Color value) {
    if (value == _color) {
      return;
    }
    _color = value;
    notifyListeners();
  }

  Color get trackColor => _trackColor!;
  Color? _trackColor;

  set trackColor(Color value) {
    if (value == _trackColor) {
      return;
    }
    _trackColor = value;
    notifyListeners();
  }

  double get strokeWidth => _strokeWidth!;
  double? _strokeWidth;

  set strokeWidth(double value) {
    if (value == _strokeWidth) {
      return;
    }
    _strokeWidth = value;
    notifyListeners();
  }

  TTabsPlacement get placement => _placement!;
  TTabsPlacement? _placement;

  set placement(TTabsPlacement value) {
    if (value == _placement) {
      return;
    }
    _placement = value;
    notifyListeners();
  }

  List<GlobalKey> get tabKeys => _tabKeys!;
  List<GlobalKey>? _tabKeys;

  set tabKeys(List<GlobalKey> value) {
    if (value == _tabKeys) {
      return;
    }
    _tabKeys = value;
    notifyListeners();
  }

  Offset get offset {
    if (index > 0) {
      var box = tabKeys[index].currentContext!.findRenderObject() as RenderBox;
      var offset1 = box.localToGlobal(const Offset(0, 0));
      var beforeBox = tabKeys[0].currentContext!.findRenderObject() as RenderBox;
      var offset2 = beforeBox.localToGlobal(const Offset(0, 0));
      return offset1 - offset2;
    }
    return Offset.zero;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = trackColor;
    canvas.drawRect(_trackPlacementRect(size), paint);

    paint.color = color;
    if (index == -1) {
      if (_currentRect != null) {
        var rect = Rect.lerp(_originOffset() & Size.zero, _currentRect, t.value);
        canvas.drawRRect(RRect.fromRectAndRadius(rect!, Radius.circular(TVar.borderRadiusDefault)), paint);
        if (t.value == 0) {
          _currentRect = null;
        }
      }
      return;
    }
    var tabKey = tabKeys[index];
    var optionWidth = tabKey.currentContext!.size!.width;
    var optionHeight = tabKey.currentContext!.size!.height;
    var rect = Rect.fromLTWH(offset.dx, offset.dy, optionWidth, optionHeight);
    _currentRect = _currentPlacementRect(rect);

    var oldRect = _oldRect ?? _originOffset() & Size.zero;
    var rectLerp = Rect.lerp(oldRect, _currentRect, t.value);
    canvas.drawRect(rectLerp!, paint);
  }

  Offset _originOffset() {
    switch (placement) {
      case TTabsPlacement.top:
        return _currentRect!.bottomLeft;
      case TTabsPlacement.bottom:
        return _currentRect!.topLeft;
      case TTabsPlacement.left:
        return _currentRect!.topRight;
      case TTabsPlacement.right:
        return _currentRect!.topLeft;
    }
  }

  Rect _trackPlacementRect(Size size) {
    switch (placement) {
      case TTabsPlacement.top:
        return Rect.fromLTWH(0, size.height - strokeWidth, size.width, strokeWidth);
      case TTabsPlacement.bottom:
        return Rect.fromLTWH(0, 0, size.width, strokeWidth);
      case TTabsPlacement.left:
        return Rect.fromLTWH(size.width - strokeWidth, 0, strokeWidth, size.height);
      case TTabsPlacement.right:
        return Rect.fromLTWH(0, 0, strokeWidth, size.height);
    }
  }

  Rect _currentPlacementRect(Rect rect) {
    switch (placement) {
      case TTabsPlacement.top:
        return Rect.fromLTWH(rect.left, rect.bottom - strokeWidth, rect.width, strokeWidth);
      case TTabsPlacement.bottom:
        return Rect.fromLTWH(rect.left, rect.top + strokeWidth, rect.width, strokeWidth);
      case TTabsPlacement.left:
        return Rect.fromLTWH(rect.right - strokeWidth, rect.top, strokeWidth, rect.height);
      case TTabsPlacement.right:
        return Rect.fromLTWH(rect.left, rect.top, strokeWidth, rect.height);
    }
  }

  @override
  bool shouldRepaint(covariant _LabelPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class _TabButton<T> extends StatefulWidget {
  const _TabButton({
    Key? key,
    required this.checked,
    this.disabled = false,
    this.onChange,
    required this.child,
    required this.theme,
    required this.placement,
    this.size,
    required this.count,
    required this.index,
    this.onRemove,
    required this.removable,
  }) : super(key: key);

  /// 是否禁用组件
  final bool disabled;

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

  /// 总数
  final int count;

  /// 索引值
  final int index;

  @override
  State<_TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<_TabButton> with TickerProviderStateMixin, TToggleableStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          if (states.contains(MaterialState.selected) || states.contains(MaterialState.hovered)) {
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.child,
              if (widget.removable && isCard) _buildCloseIcon(effectiveIconColor, iconThemeData),
            ],
          ),
        ),
      ),
    );
    if (!isCard) {
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
    }

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: value,
      child: Material(
        textStyle: TextStyle(
          fontSize: theme.fontData.fontSizeBodyLarge,
          color: textColor.resolve(states),
        ),
        color: effectiveBgColor.resolve(states),
        child: Container(
          decoration: decoration,
          height: isCard ? null : height,
          padding: margin,
          child: UnconstrainedBox(
            child: child,
          ),
        ),
      ),
    );
  }

  Padding _buildCloseIcon(MaterialStateProperty<Color?> effectiveIconColor, IconThemeData iconThemeData) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TMaterialStateBuilder(
        selected: widget.checked,
        disabled: widget.disabled,
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
