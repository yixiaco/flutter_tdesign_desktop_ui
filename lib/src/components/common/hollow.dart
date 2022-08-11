import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class THollowChild {
  const THollowChild({
    required this.child,
    this.color,
    this.checked = false,
    this.disabled = false,
    this.cursor,
  });

  /// 子组件
  final Widget child;

  /// 颜色,可以指定[Color]或者[MaterialStateColor]
  final Color? color;

  /// 是否选中
  final bool checked;

  /// 是否禁用
  final bool disabled;

  /// 鼠标手,可以指定[SystemMouseCursors]或[MaterialStateMouseCursor]
  final MouseCursor? cursor;
}

/// 镂空格子组件
class THollow extends StatefulWidget {
  const THollow({
    Key? key,
    this.color,
    required this.children,
    this.onChange,
    this.breakLine = false,
  }) : super(key: key);

  /// 颜色,可以指定[Color]或者[MaterialStateColor]
  final Color? color;

  /// 子组件
  final List<THollowChild> children;

  /// 是否换行
  final bool breakLine;

  /// 点击事件变更
  final void Function(int index, bool checked, THollowChild child)? onChange;

  @override
  State<THollow> createState() => _THollowState();
}

class _THollowState extends State<THollow> {
  late List<GlobalKey> _keys;

  /// 聚焦的组件下标
  int? isFocused;

  /// 悬停的组件下标
  int? isHovered;

  @override
  void initState() {
    super.initState();
    _keys = widget.children.map((option) => GlobalKey()).toList();
  }

  @override
  void didUpdateWidget(covariant THollow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length > _keys.length) {
      final int delta = widget.children.length - _keys.length;
      _keys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.children.length < _keys.length) {
      _keys.removeRange(widget.children.length, _keys.length);
    }
  }

  /// 处理悬停事件
  void _handleHover(int index, bool value) {
    int? hover = value ? index : null;
    if (isHovered != hover) {
      setState(() {
        isHovered = hover;
      });
    }
  }

  /// 处理聚焦事件
  void _handleFocus(int index, bool value) {
    int? focus = value ? index : null;
    if (isFocused != focus) {
      setState(() {
        isFocused = focus;
      });
    }
  }

  Set<MaterialState> state(int index, THollowChild child) {
    return <MaterialState>{
      if (isHovered == index) MaterialState.hovered,
      if (isFocused == index) MaterialState.focused,
      if (child.disabled) MaterialState.disabled,
      if (child.checked) MaterialState.selected,
    };
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    // Cursor
    final effectiveCursor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    List<Color> colors = [];
    List<bool> priority = [];
    var strokeWidth = 1 / devicePixelRatio;

    // List
    var list = List.generate(widget.children.length, (index) {
      var child = widget.children[index];
      var states = state(index, child);

      // 边框
      final border = MaterialStateProperty.resolveWith((states) {
        Color color = colorScheme.borderLevel2Color;
        if (states.contains(MaterialState.selected)) {
          color = colorScheme.brandColor;
        }
        if (states.contains(MaterialState.selected) && states.contains(MaterialState.disabled)) {
          color = colorScheme.brandColorDisabled;
        }
        if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused)) {
          color = colorScheme.brandColorHover;
        }
        return color;
      });
      if (states.contains(MaterialState.selected) || states.contains(MaterialState.hovered) || states.contains(MaterialState.focused)) {
        priority.add(false);
      } else {
        priority.add(true);
      }
      colors.add(border.resolve(states));

      // 圆角
      EdgeInsetsGeometry? padding;
      padding ??= EdgeInsets.only(left: strokeWidth, top: strokeWidth, bottom: strokeWidth);

      return FocusableActionDetector(
        enabled: !child.disabled,
        autofocus: false,
        mouseCursor: MaterialStateProperty.resolveAs(child.cursor ?? effectiveCursor.resolve(states), states),
        onShowFocusHighlight: (value) => _handleFocus(index, value),
        onShowHoverHighlight: (value) => _handleHover(index, value),
        child: GestureDetector(
          onTap: () => widget.onChange?.call(index, !child.checked, child),
          behavior: HitTestBehavior.translucent,
          child: KeyedSubtree(
            key: _keys[index],
            child: Padding(
              padding: padding,
              child: child.child,
            ),
          ),
        ),
      );
    });
    return CustomPaint(
      foregroundPainter: _HollowPainter(
        keys: _keys,
        radius: TVar.borderRadius,
        strokeWidth: strokeWidth,
        colors: colors,
        priority: priority,
      ),
      child: TSpace(
        spacing: 0,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: list,
      ),
    );
  }
}

class _HollowPainter extends CustomPainter {
  const _HollowPainter({
    required this.keys,
    required this.radius,
    required this.colors,
    required this.strokeWidth,
    required this.priority,
  });

  final List<GlobalKey> keys;

  /// 圆角
  final double radius;

  /// 线条宽度
  final double strokeWidth;

  /// 边框
  final List<Color> colors;

  /// 优先
  final List<bool> priority;

  static const origin = Offset(0, 0);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = strokeWidth;

    var renderBox = keys[0].currentContext!.findRenderObject() as RenderBox;
    Offset leftTop = renderBox.localToGlobal(origin);
    for (int i = 0; i < keys.length; i++) {
      if (priority[i]) {
        drawBorder(i, leftTop, paint, canvas);
      }
    }
    for (int i = 0; i < keys.length; i++) {
      if (!priority[i]) {
        drawBorder(i, leftTop, paint, canvas);
      }
    }
  }

  void drawBorder(int i, Offset leftTop, Paint paint, Canvas canvas) {
    var renderBox = keys[i].currentContext!.findRenderObject() as RenderBox;

    var localOffset = origin - renderBox.globalToLocal(leftTop);

    Radius topLeft = Radius.zero;
    Radius topRight = Radius.zero;
    Radius bottomRight = Radius.zero;
    Radius bottomLeft = Radius.zero;
    var isLast = i == keys.length - 1;
    Size childSize = keys[i].currentContext!.size!;
    if (i == 0) {
      topLeft = Radius.circular(TVar.borderRadius);
      bottomLeft = Radius.circular(TVar.borderRadius);
    } else if (isLast) {
      topRight = Radius.circular(TVar.borderRadius);
      bottomRight = Radius.circular(TVar.borderRadius);
    }

    paint.color = colors[i];

    var outer = RRect.fromRectAndCorners(
      localOffset & childSize,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
    );
    RRect inner;
    if (isLast) {
      inner = outer.deflate(strokeWidth);
    } else {
      inner = RRect.fromLTRBAndCorners(
        outer.left + strokeWidth,
        outer.top + strokeWidth,
        outer.right,
        outer.bottom - strokeWidth,
        topLeft: topLeft - Radius.circular(strokeWidth),
        topRight: topRight - Radius.circular(strokeWidth),
        bottomLeft: bottomLeft - Radius.circular(strokeWidth),
        bottomRight: bottomRight - Radius.circular(strokeWidth),
      );
    }
    canvas.drawDRRect(outer, inner, paint);
  }

  @override
  bool shouldRepaint(_HollowPainter oldDelegate) {
    return this != oldDelegate;
  }
}
