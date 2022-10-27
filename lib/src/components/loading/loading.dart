import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 加载组件
/// 在网络较慢或数据较多时，表示数据正在加载的状态。
class TLoading extends StatefulWidget {
  const TLoading({
    super.key,
    this.loading = true,
    this.size,
    this.boxSize,
    this.thickness,
    this.color,
    this.maskColor,
    this.child,
    this.text,
    this.delay,
  });

  /// 是否处于加载状态
  final bool loading;

  /// 组件大小，可以指定[boxSize]控制更细的精度
  final TComponentSize? size;

  /// 自定义大小，会覆盖[size]的默认值
  final Size? boxSize;

  /// 厚度
  final double? thickness;

  /// 进度条颜色
  final Color? color;

  /// 蒙版颜色
  final Color? maskColor;

  /// 子组件
  final Widget? child;

  /// 加载文案
  final Widget? text;

  /// 延迟显示加载效果的时间，用于防止请求速度过快引起的加载闪烁
  final Duration? delay;

  @override
  State<TLoading> createState() => _TLoadingState();

  /// 显示全屏加载
  static Future<T?> showFullLoading<T>({
    required BuildContext context,
    TComponentSize? size,
    Size? boxSize,
    double? thickness,
    Color? color,
    Color? maskColor,
    Widget? child,
    Widget? text,
    Duration? delay,
  }) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: maskColor ?? colorScheme.maskDisabled,
      builder: (context) {
        return TLoading(
          delay: delay,
          text: text,
          size: size,
          color: color,
          thickness: thickness,
          boxSize: boxSize,
          child: child,
        );
      },
    );
  }
}

class _TLoadingState extends State<TLoading> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late ValueNotifier<bool> _show;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _show = ValueNotifier(false)..addListener(_handleShow);
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    if (widget.loading) {
      _handleDelayShow();
    }
  }

  /// 处理显示
  void _handleShow() {
    setState(() {
      if (widget.loading) {
        _controller.repeat();
      } else {
        _controller.stop();
      }
    });
  }

  /// 处理延迟显示
  void _handleDelayShow() {
    if (widget.delay != null) {
      _timer?.cancel();
      _timer = Timer(
        widget.delay!,
        () {
          _timer = null;
          _show.value = true;
        },
      );
    } else {
      _show.value = true;
    }
  }

  /// 处理隐藏
  void _hide() {
    _timer?.cancel();
    _timer = null;
    _show.value = false;
  }

  @override
  void didUpdateWidget(covariant TLoading oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.loading) {
      _handleDelayShow();
    } else {
      _hide();
    }
  }

  @override
  void dispose() {
    _show.dispose();
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_show.value) {
      if (widget.child != null) {
        return widget.child!;
      }
      return Container();
    }
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? theme.size;
    // 线条大小
    double strokeWidth = size.lazySizeOf(
      small: () => 2.5,
      medium: () => 4.5,
      large: () => 6,
    );

    // 渐变色
    var endColor = widget.color ?? colorScheme.brandColor;
    var startColor = endColor.withAlpha(0);
    var gradientColor = [startColor, endColor];

    // 加载器大小
    double wh = size.lazySizeOf(
      small: () => theme.fontData.fontSizeL - 3,
      medium: () => theme.fontData.fontSizeXXL - 8,
      large: () => 42,
    );
    var boxSize = widget.boxSize ?? Size.square(wh);

    Widget child = CustomPaint(
      size: boxSize,
      foregroundPainter: _TLoadingPainter(
        gradientColor: gradientColor,
        t: _controller.view,
        strokeWidth: widget.thickness ?? strokeWidth,
        size: boxSize,
      ),
    );

    // 加载主文案
    if (widget.text != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          child,
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: theme.fontData.fontSizeBodyMedium,
                color: colorScheme.brandColor,
              ),
              child: widget.text!,
            ),
          ),
        ],
      );
    }

    // 子组件
    if (widget.child != null) {
      // 蒙版颜色
      Color maskColor = widget.maskColor ?? colorScheme.maskDisabled;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Container(
            foregroundDecoration: BoxDecoration(
              color: maskColor,
            ),
            child: widget.child,
          ),
          child
        ],
      );
    }

    return child;
  }
}

class _TLoadingPainter extends CustomPainter {
  _TLoadingPainter({
    required this.t,
    required this.gradientColor,
    required this.strokeWidth,
    required this.size,
  }) : super(repaint: t);

  /// 动画
  final Animation<double> t;

  // 渐变颜色
  final List<Color> gradientColor;

  /// 线条宽度
  final double strokeWidth;

  /// 加载器大小
  final Size size;

  @override
  void paint(Canvas canvas, Size size) {
    // 加载器
    var loadingSize = this.size;
    Gradient gradient = SweepGradient(
      colors: gradientColor,
      transform: GradientRotation(pi * t.value * 2),
    );
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = gradient.createShader(Offset.zero & size);
    canvas.drawCircle(
        size.center(Offset.zero), min(loadingSize.width, loadingSize.height) / 2 - strokeWidth / 2, paint);
  }

  @override
  bool shouldRepaint(covariant _TLoadingPainter oldDelegate) {
    return this != oldDelegate;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TLoadingPainter &&
          runtimeType == other.runtimeType &&
          t == other.t &&
          gradientColor == other.gradientColor &&
          strokeWidth == other.strokeWidth &&
          size == other.size;

  @override
  int get hashCode => t.hashCode ^ gradientColor.hashCode ^ strokeWidth.hashCode ^ size.hashCode;
}
