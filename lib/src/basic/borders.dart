import 'dart:ui';

import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 配合[TRoundedRectangleBorder]实现了虚线边框
class TBorderSide extends BorderSide {
  /// Creates the side of a border.
  ///
  /// By default, the border is 1.0 logical pixels wide and solid black.
  const TBorderSide({
    super.color = const Color(0xFF000000),
    super.width = 1.0,
    super.style = BorderStyle.solid,
    this.dashed = false,
    this.antiAlias = false,
  }) : assert(width >= 0.0);

  /// 虚线
  final bool dashed;

  /// 是否对画布上绘制的线条和图像应用抗锯齿
  final bool antiAlias;

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
    if ((a.style == BorderStyle.none && a.width == 0.0) || (b.style == BorderStyle.none && b.width == 0.0)) {
      return true;
    }
    return a.style == b.style && a.color == b.color && a.dashed == b.dashed;
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
    if (a.style == b.style && a.dashed == b.dashed && a.antiAlias == b.antiAlias) {
      return TBorderSide(
        color: Color.lerp(a.color, b.color, t)!,
        width: width,
        style: a.style,
        // == b.style
        dashed: a.dashed,
        antiAlias: a.antiAlias,
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
      antiAlias: b.antiAlias,
    );
  }

  @override
  BorderSide copyWith({
    Color? color,
    double? width,
    BorderStyle? style,
    bool? dashed,
    bool? antiAlias,
  }) {
    assert(width == null || width >= 0.0);
    return TBorderSide(
      color: color ?? this.color,
      width: width ?? this.width,
      style: style ?? this.style,
      dashed: dashed ?? this.dashed,
      antiAlias: antiAlias ?? this.antiAlias,
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
    return other is TBorderSide &&
        other.color == color &&
        other.width == width &&
        other.style == style &&
        other.dashed == dashed &&
        other.antiAlias == antiAlias;
  }

  @override
  int get hashCode => Object.hash(color, width, style, dashed, antiAlias);

  @override
  String toString() => '${objectRuntimeType(this, 'TBorderSide')}($color, ${width.toStringAsFixed(1)}, $style, $dashed, $antiAlias)';
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
          final RRect outer = borderRadius.resolve(textDirection).toRRect(rect);
          final RRect inner = outer.deflate(width * 0.75);
          final Paint paint = Paint()
            ..color = side.color
            ..style = PaintingStyle.stroke
            ..strokeWidth = width;

          var path = Path()..addRRect(inner);
          if (side is TBorderSide) {
            var borderSide = (side as TBorderSide);
            if(borderSide.dashed) {
              path = PathUtil.dashPath(path, 3, 2);
            }
            paint.isAntiAlias = borderSide.antiAlias;
          }
          canvas.drawPath(path, paint);
        }
    }
  }
}
