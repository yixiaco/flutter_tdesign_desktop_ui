import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

class TLoading extends StatefulWidget {
  const TLoading({
    Key? key,
    this.loading = true,
    this.size,
  }) : super(key: key);

  /// 是否处于加载状态
  final bool loading;

  final TComponentSize? size;

  @override
  State<TLoading> createState() => _TLoadingState();
}

class _TLoadingState extends State<TLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    if (widget.loading) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant TLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading) {
      _controller.repeat();
    } else {
      _controller.stop();
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
    var size = widget.size ?? theme.size;
    double wh = size.lazySizeOf(
      small: () => theme.fontData.fontSizeL - 2,
      medium: () => theme.fontData.fontSizeXXL - 8,
      large: () => 42,
    );

    double strokeWidth = size.lazySizeOf(
      small: () => 2,
      medium: () => 4,
      large: () => 6,
    );

    return SizedBox(
      width: wh,
      height: wh,
      child: CustomPaint(
        painter: _TLoadingPainter(
          repaint: _controller.view,
          gradientColor: [
            colorScheme.bgColorContainer,
            colorScheme.brandColor,
          ],
          t: _controller.view,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _TLoadingPainter extends CustomPainter {
  _TLoadingPainter({
    super.repaint,
    required this.t,
    required this.gradientColor,
    required this.strokeWidth,
  });

  final Animation<double> t;

  // 渐变颜色
  final List<Color> gradientColor;

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    Gradient gradient = SweepGradient(
      colors: gradientColor,
      transform: GradientRotation(pi * t.value * 2),
    );
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(Offset.zero & size);
    canvas.drawCircle(size.center(Offset.zero), min(size.width, size.height) / 2 - strokeWidth / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
