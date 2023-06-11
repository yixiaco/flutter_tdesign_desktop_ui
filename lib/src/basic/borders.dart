import 'dart:ui';

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// 配合[TRoundedRectangleBorder]实现了虚线边框
class TBorderSide extends BorderSide {
  /// Creates the side of a border.
  ///
  /// By default, the border is 1.0 logical pixels wide and solid black.
  const TBorderSide({
    super.color = const Color(0xFF000000),
    super.width = 1.0,
    super.style = BorderStyle.solid,
    super.strokeAlign = BorderSide.strokeAlignInside,
    this.dashed = false,
  }) : assert(width >= 0.0);

  /// 虚线
  final bool dashed;

  /// A hairline black border that is not rendered.
  static const TBorderSide none = TBorderSide(width: 0.0, style: BorderStyle.none);

  @override
  TBorderSide scale(double t) {
    return TBorderSide(
      color: color,
      width: math.max(0.0, width * t),
      style: t <= 0.0 ? BorderStyle.none : style,
      dashed: dashed,
    );
  }

  /// Whether the two given [TBorderSide]s can be merged using
  /// [TBorderSide.merge].
  ///
  /// Two sides can be merged if one or both are zero-width with
  /// [TBorderSide.none], or if they both have the same color and style.
  ///
  /// The arguments must not be null.
  static bool canMerge(TBorderSide a, TBorderSide b) {
    if ((a.style == BorderStyle.none && a.width == 0.0) ||
        (b.style == BorderStyle.none && b.width == 0.0)) {
      return true;
    }
    return a.style == b.style
        && a.color == b.color && a.dashed == b.dashed;
  }

  /// Linearly interpolate between two border sides.
  ///
  /// The arguments must not be null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static TBorderSide lerp(TBorderSide a, TBorderSide b, double t) {
    if (t == 0.0) {
      return a;
    }
    if (t == 1.0) {
      return b;
    }
    final double width = lerpDouble(a.width, b.width, t)!;
    if (width < 0.0) {
      return TBorderSide.none;
    }
    if (a.style == b.style && a.dashed == b.dashed) {
      return TBorderSide(
        color: Color.lerp(a.color, b.color, t)!,
        width: width,
        style: a.style, // == b.style
        dashed: a.dashed,
      );
    }
    Color colorA, colorB;
    switch (a.style) {
      case BorderStyle.solid:
        colorA = a.color;
        break;
      case BorderStyle.none:
        colorA = a.color.withAlpha(0x00);
        break;
    }
    switch (b.style) {
      case BorderStyle.solid:
        colorB = b.color;
        break;
      case BorderStyle.none:
        colorB = b.color.withAlpha(0x00);
        break;
    }
    return TBorderSide(
      color: Color.lerp(colorA, colorB, t)!,
      width: width,
      dashed: b.dashed,
    );
  }

  @override
  BorderSide copyWith({
    Color? color,
    double? width,
    BorderStyle? style,
    double? strokeAlign,
    bool? dashed,
  }) {
    assert(width == null || width >= 0.0);
    return TBorderSide(
      color: color ?? this.color,
      width: width ?? this.width,
      style: style ?? this.style,
      strokeAlign: strokeAlign ?? this.strokeAlign,
      dashed: dashed ?? this.dashed,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is TBorderSide
        && other.color == color
        && other.width == width
        && other.style == style
        && other.strokeAlign == strokeAlign
        && other.dashed == dashed;
  }

  @override
  int get hashCode => Object.hash(color, width, style, dashed);
}

class TRoundedRectangleBorder extends RoundedRectangleBorder {
  const TRoundedRectangleBorder({
    super.side = TBorderSide.none,
    super.borderRadius = BorderRadius.zero,
  });

  @override
  RoundedRectangleBorder copyWith({BorderSide? side, BorderRadiusGeometry? borderRadius}) {
    return TRoundedRectangleBorder(
      side: side ?? this.side,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is TRoundedRectangleBorder && side is TBorderSide && a.side is TBorderSide) {
      return TRoundedRectangleBorder(
        side: TBorderSide.lerp(a.side as TBorderSide, side as TBorderSide, t),
        borderRadius: BorderRadiusGeometry.lerp(a.borderRadius, borderRadius, t)!,
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    switch (side.style) {
      case BorderStyle.none:
        break;
      case BorderStyle.solid:
        final double width = side.width;
        if (width == 0.0) {
          canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(rect), side.toPaint());
        } else {
          if(side is TBorderSide && (side as TBorderSide).dashed) {
            final RRect outer = borderRadius.resolve(textDirection).toRRect(rect);
            final RRect inner = outer.deflate(width * 0.75);
            final Paint paint = Paint()
              ..color = side.color
              ..style = PaintingStyle.stroke
              ..strokeWidth = width;

            var path = Path()..addRRect(inner);
            path = dashPath(path, 3, 2);
            canvas.drawPath(path, paint);
          } else {
            final RRect outer = borderRadius.resolve(textDirection).toRRect(rect);
            final RRect inner = outer.deflate(width);
            final Paint paint = Paint()
              ..color = side.color;
            canvas.drawDRRect(outer, inner, paint);
          }
        }
    }
  }

  /// 获取虚线路径
  /// [path] 路径
  /// [length] 线条长度
  /// [gap] 间隙长度
  /// [distance] 初始偏移
  static Path dashPath(final Path path, double length, [double? gap, double? distance = 0]) {
    gap ??= length;
    PathMetrics pathMetrics = path.computeMetrics();
    Path dest = Path();
    for (var metric in pathMetrics) {
      bool draw = true;
      while (distance! < metric.length) {
        if (draw) {
          dest.addPath(
            metric.extractPath(distance, distance + length),
            Offset.zero,
          );
          distance += length;
        } else {
          distance += gap;
        }
        draw = !draw;
      }
    }
    return dest;
  }
}
