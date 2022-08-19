import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 进度条组件
/// 展示操作的当前进度
class TProgress extends StatefulWidget {
  const TProgress({
    Key? key,
    this.color,
    this.showLabel = true,
    this.label,
    this.percentage = 0,
    this.size,
    this.status,
    this.strokeWidth,
    this.theme = TProgressTheme.line,
    this.trackColor,
  }) : super(key: key);

  /// 进度条颜色,多个颜色会形成渐变色
  final List<Color>? color;

  /// 是否显示标签
  final bool showLabel;

  /// 标签
  final Widget? label;

  /// 进度条百分比 0-100
  final double percentage;

  /// 进度条尺寸
  final TComponentSize? size;

  /// 进度条状态
  final TProgressStatus? status;

  /// 进度条线宽。宽度数值不能超过 size 的一半，否则不能输出环形进度
  final double? strokeWidth;

  /// 进度条风格。
  /// 值为 line，标签（label）显示在进度条右侧；
  /// 值为 plump，标签（label）显示在进度条里面；
  /// 值为 circle，标签（label）显示在进度条正中间。
  final TProgressTheme theme;

  /// 进度条未完成部分颜色
  final Color? trackColor;

  @override
  State<TProgress> createState() => _TProgressState();
}

class _TProgressState extends State<TProgress> {
  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var trackColor = widget.trackColor ?? colorScheme.bgColorComponent;

    // 线宽
    double? strokeWidth = widget.strokeWidth;
    if (strokeWidth == null) {
      switch (widget.theme) {
        case TProgressTheme.line:
          strokeWidth = 6;
          break;
        case TProgressTheme.plump:
          strokeWidth = 18;
          break;
        case TProgressTheme.circle:
          strokeWidth = 6;
          break;
      }
    }

    // 线条颜色
    List<Color>? color = widget.color;
    if (color == null) {
      switch (widget.status) {
        case TProgressStatus.success:
          color = [colorScheme.successColor];
          break;
        case TProgressStatus.error:
          color = [colorScheme.errorColor];
          break;
        case TProgressStatus.warning:
          color = [colorScheme.warningColor];
          break;
        default:
          color = [colorScheme.brandColor];
      }
    }

    switch(widget.theme) {
      case TProgressTheme.line:
        // TODO: Handle this case.
        break;
      case TProgressTheme.plump:
        // TODO: Handle this case.
        break;
      case TProgressTheme.circle:
        // TODO: Handle this case.
        break;
    }

    var list = <Widget>[
      Expanded(
        child: SizedBox(
          height: strokeWidth,
          child: CustomPaint(
            painter: _TLinePrinter(
              percentage: widget.percentage.clamp(0.0, 100.0),
              strokeWidth: strokeWidth,
              color: color,
              trackColor: trackColor,
            ),
          ),
        ),
      ),
    ];

    if (widget.showLabel) {
      Widget? label = _buildLabel(theme, colorScheme);
      list.add(Padding(
        padding: EdgeInsets.only(left: TVar.spacer1),
        child: label,
      ));
    }
    return Row(
      children: list,
    );
  }

  /// 构建标签
  Widget? _buildLabel(TThemeData theme, TColorScheme colorScheme) {
    Widget? label = widget.label;
    var iconSize = theme.fontSize * 1.20;

    Color fontColor;
    if(widget.theme != TProgressTheme.plump || widget.percentage <= 10) {
      fontColor = colorScheme.textColorPrimary;
    } else {
      fontColor = colorScheme.textColorAnti;
    }

    switch (widget.status) {
      case TProgressStatus.success:
        label = Icon(
          TIcons.checkCircleFilled,
          color: colorScheme.successColor,
          size: iconSize,
        );
        break;
      case TProgressStatus.error:
        label = Icon(
          TIcons.closeCircleFilled,
          color: colorScheme.errorColor,
          size: iconSize,
        );
        break;
      case TProgressStatus.warning:
        label = Icon(
          TIcons.errorCircleFilled,
          color: colorScheme.warningColor,
          size: iconSize,
        );
        break;
      default:
        label = Text(
          '${(widget.percentage).round()}%',
          style: TextStyle(
            fontSize: theme.fontSize,
            color: fontColor,
          ),
        );
    }
    return label;
  }
}

/// 线条
class _TLinePrinter extends CustomPainter {
  _TLinePrinter({
    required this.percentage,
    required this.color,
    required this.strokeWidth,
    required this.trackColor,
  });

  /// 进度条百分比 0-100
  final double percentage;

  /// 进度条颜色,多个颜色会形成渐变色
  final List<Color> color;

  /// 进度条线宽。宽度数值不能超过 size 的一半，否则不能输出环形进度
  final double strokeWidth;

  /// 进度条未完成部分颜色
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    // 圆角超出矩形部分
    var offset = Offset(strokeWidth / 2, 0);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..color = trackColor
      ..strokeWidth = strokeWidth;

    // 轨道
    var p1 = size.centerLeft(Offset.zero) + offset;
    var p2 = size.centerRight(Offset.zero) - offset;
    canvas.drawLine(p1, p2, paint);

    if (percentage == 0) {
      return;
    }
    var percentageSize = Size((size.width * percentage / 100).clamp(p1.dx, p2.dx), size.height);
    p2 = percentageSize.centerRight(Offset.zero);

    if (color.length >= 2) {
      Gradient gradient = LinearGradient(
        colors: color,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      );
      paint.shader = gradient.createShader(Offset.zero & percentageSize);
    } else {
      paint.color = color[0];
    }
    // 进度
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(covariant _TLinePrinter oldDelegate) {
    return this != oldDelegate;
  }
}
