import 'dart:math';

import 'package:flutter/material.dart';

const Duration _kFadeOutDuration = Duration(milliseconds: 400);

class _InkBevelAngleFactory extends InteractiveInkFeatureFactory {
  const _InkBevelAngleFactory();

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return InkBevelAngle(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      color: color,
      containedInkWell: containedInkWell,
      rectCallback: rectCallback,
      borderRadius: borderRadius,
      customBorder: customBorder,
      radius: radius,
      onRemoved: onRemoved,
      textDirection: textDirection,
    );
  }
}

RectCallback? _getClipCallback(RenderBox referenceBox, bool containedInkWell, RectCallback? rectCallback) {
  if (rectCallback != null) {
    assert(containedInkWell);
    return rectCallback;
  }
  if (containedInkWell) {
    return () => Offset.zero & referenceBox.size;
  }
  return null;
}

double _getTargetRadius(RenderBox referenceBox, bool containedInkWell, RectCallback? rectCallback, Offset position) {
  final Size size = rectCallback != null ? rectCallback().size : referenceBox.size;
  final double d1 = size
      .bottomRight(Offset.zero)
      .distance;
  final double d2 = (size.topRight(Offset.zero) - size.bottomLeft(Offset.zero)).distance;
  return max(d1, d2) / 2.0;
}

/// 斜8度水波纹
class InkBevelAngle extends InteractiveInkFeature {
  InkBevelAngle({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  })
      : _position = position,
        _borderRadius = borderRadius ?? BorderRadius.zero,
        _customBorder = customBorder,
        _textDirection = textDirection,
        _targetRadius = radius ?? _getTargetRadius(referenceBox, containedInkWell, rectCallback, position),
        _clipCallback = _getClipCallback(referenceBox, containedInkWell, rectCallback),
        super(controller: controller, referenceBox: referenceBox, color: color, onRemoved: onRemoved) {
    _angle = AnimationController(duration: const Duration(milliseconds: 200), vsync: controller.vsync)
      ..addListener(controller.markNeedsPaint)
      ..forward();

    // tan((180d / 22) = 8d) * 临边 = 对边
    _angleWidth = _angle.drive(Tween<double>(
      begin: 0,
      end: referenceBox.size.width + tan(pi / 22) * referenceBox.size.height,
    ).chain(CurveTween(curve: const Cubic(.38, 0, .24, 1))));

    _fadeOutController = AnimationController(duration: _kFadeOutDuration, vsync: controller.vsync)
      ..addListener(controller.markNeedsPaint)
      ..addStatusListener(_handleAlphaStatusChanged);

    _fadeOut = _fadeOutController.drive(
      Tween(
        begin: 0.9,
        end: 0.0,
      ).chain(_fadeOutIntervalTween)
      .chain(CurveTween(curve: Curves.linear)),
    );

    controller.addInkFeature(this);
  }

  static const InteractiveInkFeatureFactory splashFactory = _InkBevelAngleFactory();

  final Offset _position;
  final BorderRadius _borderRadius;
  final ShapeBorder? _customBorder;
  final double _targetRadius;
  final RectCallback? _clipCallback;
  final TextDirection _textDirection;

  late AnimationController _angle;
  late Animation<double> _angleWidth;

  late AnimationController _fadeOutController;
  late Animation<double> _fadeOut;
  static final Animatable<double> _fadeOutIntervalTween = CurveTween(curve: const Interval(.25, 1));

  void _handleAlphaStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      dispose();
    }
  }

  ///当鼠标左键放开时
  @override
  void confirm() {
    _angle.forward();
    _fadeOutController.animateTo(1.0, duration: _kFadeOutDuration);
  }

  @override
  void cancel() {
    _fadeOutController.animateTo(1.0, duration: _kFadeOutDuration);
  }

  @override
  void dispose() {
    _angle.dispose();
    _fadeOutController.dispose();
    super.dispose();
  }

  /// 亮度变暗L20
  static Color darkColor(Color color) {
    final hslColor = HSLColor.fromColor(color);
    // 亮度：0~1
    final lightness = max(hslColor.lightness - 0.2, 0.0);
    return hslColor.withLightness(lightness).toColor();
  }

  @override
  void paintFeature(Canvas canvas, Matrix4 transform) {
    final Paint paint = Paint()
      ..color = color.withOpacity(_fadeOut.value);

    final Offset? originOffset = MatrixUtils.getAsTranslation(transform);
    canvas.save();
    if (originOffset == null) {
      canvas.transform(transform.storage);
    } else {
      canvas.translate(originOffset.dx, originOffset.dy);
    }
    if (_clipCallback != null) {
      final Rect rect = _clipCallback!();
      if (_customBorder != null) {
        canvas.clipPath(_customBorder!.getOuterPath(rect, textDirection: _textDirection));
      } else if (_borderRadius != BorderRadius.zero) {
        canvas.clipRRect(RRect.fromRectAndCorners(
          rect,
          topLeft: _borderRadius.topLeft,
          topRight: _borderRadius.topRight,
          bottomLeft: _borderRadius.bottomLeft,
          bottomRight: _borderRadius.bottomRight,
        ));
      } else {
        canvas.clipRect(rect);
      }
    }

    var path = Path();
    path.addRect(Rect.fromLTWH(0, 0, _angleWidth.value, referenceBox.size.height));
    canvas.drawPath(path.transform(Matrix4.skewX(-pi / 22).storage), paint);
    canvas.restore();
  }
}
