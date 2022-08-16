import 'package:flutter/material.dart';

/// 自定义input边框装饰器，增加了阴影功能
class CustomOutlineInputBorder extends OutlineInputBorder {
  const CustomOutlineInputBorder({
    super.borderSide = const BorderSide(),
    super.borderRadius = const BorderRadius.all(Radius.circular(4.0)),
    super.gapPadding = 4.0,
    this.shadows,
  });

  final List<BoxShadow>? shadows;

  @override
  void paint(Canvas canvas, Rect rect, {double? gapStart, double gapExtent = 0.0, double gapPercentage = 0.0, TextDirection? textDirection}) {
    if (shadows?.isNotEmpty ?? false) {
      for (var boxShadow in shadows!) {
        final Paint paint = boxShadow.toPaint();
        final Rect bounds = rect.shift(boxShadow.offset).inflate(boxShadow.spreadRadius);
        var inner = borderRadius.resolve(textDirection).toRRect(rect);
        var outer = borderRadius.resolve(textDirection).toRRect(bounds);
        if (boxShadow.spreadRadius > 0) {
          canvas.drawDRRect(outer, inner, paint);
        } else {
          canvas.drawDRRect(inner, outer, paint);
        }
        // canvas.drawRRect(borderRadius.resolve(textDirection).toRRect(bounds), paint);
      }
    }
    super.paint(
      canvas,
      rect,
      gapStart: gapStart,
      gapExtent: gapExtent,
      gapPercentage: gapPercentage,
      textDirection: textDirection,
    );
  }

  @override
  OutlineInputBorder copyWith({
    BorderSide? borderSide,
    BorderRadius? borderRadius,
    double? gapPadding,
    List<BoxShadow>? shadows,
  }) {
    return CustomOutlineInputBorder(
      borderSide: borderSide ?? this.borderSide,
      borderRadius: borderRadius ?? this.borderRadius,
      gapPadding: gapPadding ?? this.gapPadding,
      shadows: shadows ?? this.shadows,
    );
  }

  @override
  CustomOutlineInputBorder scale(double t) {
    return CustomOutlineInputBorder(
      borderSide: borderSide.scale(t),
      borderRadius: borderRadius * t,
      gapPadding: gapPadding * t,
      shadows: shadows?.map((e) => e.scale(t)).toList(),
    );
  }

  @override
  ShapeBorder? lerpFrom(ShapeBorder? a, double t) {
    if (a is CustomOutlineInputBorder) {
      final CustomOutlineInputBorder outline = a;
      return CustomOutlineInputBorder(
        borderRadius: BorderRadius.lerp(outline.borderRadius, borderRadius, t)!,
        borderSide: BorderSide.lerp(outline.borderSide, borderSide, t),
        gapPadding: outline.gapPadding,
        shadows: Shadow.lerpList(outline.shadows, shadows, t)?.cast<BoxShadow>(),
      );
    }
    return super.lerpFrom(a, t);
  }

  @override
  ShapeBorder? lerpTo(ShapeBorder? b, double t) {
    if (b is CustomOutlineInputBorder) {
      final CustomOutlineInputBorder outline = b;
      return CustomOutlineInputBorder(
        borderRadius: BorderRadius.lerp(borderRadius, outline.borderRadius, t)!,
        borderSide: BorderSide.lerp(borderSide, outline.borderSide, t),
        gapPadding: outline.gapPadding,
        shadows: Shadow.lerpList(shadows, outline.shadows, t)?.cast<BoxShadow>(),
      );
    }
    return super.lerpTo(b, t);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is CustomOutlineInputBorder &&
        other.borderSide == borderSide &&
        other.borderRadius == borderRadius &&
        other.gapPadding == gapPadding &&
        other.shadows == shadows;
  }

  @override
  int get hashCode => Object.hash(borderSide, borderRadius, gapPadding, shadows);
}
