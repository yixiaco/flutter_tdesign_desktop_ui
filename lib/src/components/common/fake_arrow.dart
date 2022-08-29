import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    Key? key,
    this.placement = TFakeArrowPlacement.right,
    this.child,
  }) : super(key: key);

  /// 方向
  final TFakeArrowPlacement placement;

  /// 替换icon图标
  final Widget? child;

  @override
  State<TFakeArrow> createState() => _TFakeArrowState();
}

class _TFakeArrowState extends State<TFakeArrow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late CurvedAnimation animated;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: TVar.animDurationSlow,
      value: 1,
    );
    animated = CurvedAnimation(
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
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    return AnimatedBuilder(
      builder: (BuildContext context, Widget? child) {
        Matrix4 matrix4;
        switch (widget.placement) {
          case TFakeArrowPlacement.left:
            matrix4 = Matrix4.rotationY(pi * animated.value)..rotateZ(-pi / 2);
            break;
          case TFakeArrowPlacement.right:
            matrix4 = Matrix4.rotationY(pi * animated.value)..rotateZ(pi / 2);
            break;
          case TFakeArrowPlacement.top:
            matrix4 = Matrix4.rotationX(pi * animated.value)..rotateZ(pi);
            break;
          case TFakeArrowPlacement.bottom:
            matrix4 = Matrix4.rotationX(pi * animated.value);
            break;
        }
        return Transform(
          transform: matrix4,
          alignment: Alignment.center,
          filterQuality: FilterQuality.medium,
          child: widget.child ?? SvgPicture.string(
            '''<svg
            width="16"
            height="16"
            viewBox="0 0 16 16"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
            >
            <path d="M3.75 5.7998L7.99274 10.0425L12.2361 5.79921" stroke="black" stroke-opacity="0.9" stroke-width="1.3" />
            </svg>''',
            color: colorScheme.textColorPrimary,
          ),
        );
      },
      animation: animated,
    );
  }
}