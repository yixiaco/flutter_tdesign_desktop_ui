import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

const _kFakeArrowSvg = '''<svg
            width="16"
            height="16"
            viewBox="0 0 16 16"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
            >
            <path d="M3.75 5.7998L7.99274 10.0425L12.2361 5.79921" stroke="black" stroke-opacity="0.9" stroke-width="1.3" />
            </svg>''';

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
    this.child,
    this.color,
    this.dimension,
  });

  /// 方向
  final TFakeArrowPlacement placement;

  /// 替换icon图标
  final Widget? child;

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
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    return CustomPaint(
      size: Size.square(widget.dimension ?? 16),
      painter: _painter
      ..t = _animated
      ..placement = widget.placement
      ..color = widget.color ?? colorScheme.textColorPrimary,
    );
    // return AnimatedBuilder(
    //   builder: (BuildContext context, Widget? child) {
    //     Matrix4 matrix4;
    //     switch (widget.placement) {
    //       case TFakeArrowPlacement.left:
    //         matrix4 = Matrix4.rotationY(pi * _animated.value)..rotateZ(-pi / 2);
    //         break;
    //       case TFakeArrowPlacement.right:
    //         matrix4 = Matrix4.rotationY(pi * _animated.value)..rotateZ(pi / 2);
    //         break;
    //       case TFakeArrowPlacement.top:
    //         matrix4 = Matrix4.rotationX(pi * _animated.value)..rotateZ(pi);
    //         break;
    //       case TFakeArrowPlacement.bottom:
    //         matrix4 = Matrix4.rotationX(pi * _animated.value);
    //         break;
    //     }
    //     return Transform(
    //       transform: matrix4,
    //       alignment: Alignment.center,
    //       filterQuality: FilterQuality.medium,
    //       child: widget.child ??
    //           SvgPicture.string(
    //             _kFakeArrowSvg,
    //             color: widget.color ?? colorScheme.textColorPrimary,
    //             width: widget.dimension,
    //             height: widget.dimension,
    //           ),
    //     );
    //   },
    //   animation: _animated,
    // );
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
  void paint(Canvas canvas, Size size) {}
}
