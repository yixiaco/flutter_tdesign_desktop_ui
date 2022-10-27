import 'dart:math' as math;

import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 箭头方向
enum TFakeArrowPlacement {
  /// 左
  left,

  /// 右
  right,

  /// 上
  top,

  /// 下
  bottom;
}

/// 统一使用的翻转箭头组件
class TFakeArrow extends StatefulWidget {
  const TFakeArrow({
    super.key,
    this.placement = TFakeArrowPlacement.right,
    this.color,
    this.dimension,
  });

  /// 方向
  final TFakeArrowPlacement placement;

  /// 颜色
  final Color? color;

  /// 宽高
  final double? dimension;

  @override
  State<TFakeArrow> createState() => _TFakeArrowState();
}

class _TFakeArrowState extends State<TFakeArrow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation _animated;
  late _TFakeArrowPainter _painter;

  @override
  void initState() {
    super.initState();
    _painter = _TFakeArrowPainter();
    _controller = AnimationController(
      vsync: this,
      duration: TVar.animDurationSlow,
      value: 1,
    );
    _animated = CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    );
  }

  @override
  void didUpdateWidget(covariant TFakeArrow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.placement != oldWidget.placement) {
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _painter.dispose();
    _controller.dispose();
    _animated.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var iconTheme = IconTheme.of(context);
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    return RepaintBoundary(
      child: CustomPaint(
        size: Size.square(widget.dimension ?? iconTheme.size ?? 16),
        painter: _painter
          ..t = _animated
          ..placement = widget.placement
          ..color = widget.color ?? iconTheme.color ?? colorScheme.textColorPrimary,
      ),
    );
  }
}

class _TFakeArrowPainter extends AnimationChangeNotifierPainter {
  TFakeArrowPlacement get placement => _placement!;
  TFakeArrowPlacement? _placement;

  set placement(TFakeArrowPlacement value) {
    if (value == _placement) {
      return;
    }
    _placement = value;
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

  @override
  void paint(Canvas canvas, Size size) {
    var width = math.max(size.width - 8, 0);

    var h = width / 2;
    var dw = width / 2;
    var dh = h / 2;
    var center = size.center(Offset.zero);
    Paint paint = Paint()
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    Path path = Path();
    switch (placement) {
      case TFakeArrowPlacement.left:
        path.addPolygon([
          center + Offset(_lerp(-dh, dh), -dw),
          center + Offset(_lerp(dh, -dh), 0),
          center + Offset(_lerp(-dh, dh), dw),
        ], false);
        break;
      case TFakeArrowPlacement.right:
        path.addPolygon([
          center + Offset(_lerp(dh, -dh), -dw),
          center + Offset(_lerp(-dh, dh), 0),
          center + Offset(_lerp(dh, -dh), dw),
        ], false);
        break;
      case TFakeArrowPlacement.top:
        path.addPolygon([
          center + Offset(-dw, _lerp(-dh, dh)),
          center + Offset(0, _lerp(dh, -dh)),
          center + Offset(dw, _lerp(-dh, dh)),
        ], false);
        break;
      case TFakeArrowPlacement.bottom:
        path.addPolygon([
          center + Offset(-dw, _lerp(dh, -dh)),
          center + Offset(0, _lerp(-dh, dh)),
          center + Offset(dw, _lerp(dh, -dh)),
        ], false);
        break;
    }
    canvas.drawPath(path, paint);
  }

  double _lerp(double begin, double end) {
    return begin + (end - begin) * t.value;
  }
}
