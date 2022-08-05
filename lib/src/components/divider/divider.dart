import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

enum TDividerAlign {
  /// 靠左
  left,

  /// 靠右
  right,

  /// 居中
  center;
}

class TDivider extends StatelessWidget {
  const TDivider({
    Key? key,
    this.child,
    this.align = TDividerAlign.center,
    this.dashed = false,
    this.layout = Axis.horizontal,
    this.space,
    this.thickness,
  }) : super(key: key);

  /// 文本位置（仅在水平分割线有效）
  final TDividerAlign align;

  /// 子部件（仅在水平分割线有效）
  final Widget? child;

  /// 是否虚线
  final bool dashed;

  /// 分隔线类型有两种：水平和垂直
  final Axis layout;

  /// 线条宽（horizontal）/高(vertical)
  final double? space;

  /// 线条厚度
  final double? thickness;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var fontSize = theme.size.sizeOf(
      small: ThemeDataConstant.fontSizeS,
      medium: ThemeDataConstant.fontSizeBase,
      large: ThemeDataConstant.fontSizeL,
    );

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var data = MediaQuery.of(context);
        var size = data.size;
        var d = 1 / data.devicePixelRatio;
        var maxWidth = constraints.maxWidth == double.infinity ? size.width : constraints.maxWidth;
        double width;
        double height;
        EdgeInsetsGeometry margin;
        if (layout == Axis.horizontal) {
          width = space ?? maxWidth;
          height = thickness ?? d;
          margin = EdgeInsets.symmetric(vertical: ThemeDataConstant.spacer2);
          if (child != null) {
            Widget left;
            Widget right;
            switch (align) {
              case TDividerAlign.left:
                left = buildCustomPaint(width * 0.05, height, colorScheme);
                right = Expanded(child: buildCustomPaint(width, height, colorScheme));
                break;
              case TDividerAlign.right:
                left = Expanded(child: buildCustomPaint(width, height, colorScheme));
                right = buildCustomPaint(width * 0.05, height, colorScheme);
                break;
              case TDividerAlign.center:
                left = Expanded(child: buildCustomPaint(width, height, colorScheme));
                right = Expanded(child: buildCustomPaint(width, height, colorScheme));
                break;
            }
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                left,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: fontSize),
                  child: child!,
                ),
                right,
              ],
            );
          }
        } else {
          width = thickness ?? d;
          height = space ?? fontSize * 0.9;
          margin = EdgeInsets.symmetric(horizontal: ThemeDataConstant.spacer * 1.5);
        }

        return Padding(
          padding: margin,
          child: DefaultTextStyle(
            style: TextStyle(color: colorScheme.textColorPrimary),
            child: buildCustomPaint(width, height, colorScheme),
          ),
        );
      },
    );
  }

  CustomPaint buildCustomPaint(double width, double height, TColorScheme colorScheme) {
    return CustomPaint(
      size: Size(width, height),
      painter: TDividerCustomPainter(
        color: colorScheme.borderLevel1Color,
        dashed: dashed,
        direction: layout,
      ),
    );
  }
}

/// 分割线画笔
class TDividerCustomPainter extends CustomPainter {
  const TDividerCustomPainter({
    required this.color,
    required this.dashed,
    required this.direction,
  });

  /// 线条颜色
  final Color color;

  /// 是否是虚线
  final bool dashed;

  /// 方向
  final Axis direction;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..isAntiAlias = false;
    var path = Path();

    if (direction == Axis.vertical) {
      path.lineTo(0, size.height);
      paint.strokeWidth = size.width;
    } else {
      path.lineTo(size.width, 0);
      paint.strokeWidth = size.height;
    }

    if (dashed) {
      path = PathUtil.dashPath(path, 3, 2);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TDividerCustomPainter oldDelegate) {
    return this != oldDelegate;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TDividerCustomPainter &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          dashed == other.dashed &&
          direction == other.direction;

  @override
  int get hashCode => color.hashCode ^ dashed.hashCode ^ direction.hashCode;
}
