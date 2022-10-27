import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 进度条组件
/// 展示操作的当前进度
class TProgress extends ImplicitlyAnimatedWidget {
  const TProgress({
    super.key,
    this.color,
    this.showLabel = true,
    this.label,
    this.percentage = 0,
    this.boxSize,
    this.size,
    this.status,
    this.strokeWidth,
    this.theme = TProgressTheme.line,
    this.trackColor,
    super.curve = Curves.linear,
    super.duration = const Duration(milliseconds: 200),
    super.onEnd,
  });

  /// 进度条颜色,多个颜色会形成渐变色
  final List<Color>? color;

  /// 是否显示标签
  final bool showLabel;

  /// 标签
  final Widget? label;

  /// 进度条百分比 0-100
  final double percentage;

  /// 盒子大小
  final Size? boxSize;

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
  AnimatedWidgetBaseState<TProgress> createState() => _TProgressState();
}

class _TProgressState extends AnimatedWidgetBaseState<TProgress> {
  late Tween<double> _percentage;

  /// 动画进度
  double get animationPercentage => _percentage.evaluate(animation);

  /// 实时进度
  double get percentage => widget.percentage.clamp(0, 100);

  /// 如果是默认状态，则值100时变更为success状态
  TProgressStatus? get status {
    if(widget.status == null) {
      if(animationPercentage >= 100.0){
        return TProgressStatus.success;
      } else {
        return null;
      }
    } else if(widget.status == TProgressStatus.active && animationPercentage >= 100){
      return TProgressStatus.success;
    }
    return widget.status;
  }

  @override
  void initState() {
    _percentage = Tween<double>(begin: percentage, end: percentage);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _percentage = visitor(
      _percentage,
      widget.percentage.clamp(0.0, 100.0),
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>;
  }

  /// 构建标签
  Widget? _buildLabel(TThemeData theme, TColorScheme colorScheme) {
    Widget? label = widget.label;
    var size = widget.size ?? theme.size;
    IconThemeData? iconThemeData;
    TextStyle style;
    switch (widget.theme) {
      case TProgressTheme.line:
        var iconSize = theme.fontSize * 1.20;
        style = TextStyle(
          fontSize: theme.fontData.fontSizeBodyMedium,
          color: colorScheme.textColorPrimary,
          overflow: TextOverflow.ellipsis,
        );
        switch (status) {
          case TProgressStatus.success:
            iconThemeData = IconThemeData(
              color: colorScheme.successColor,
              size: iconSize,
            );
            label ??= const Icon(TIcons.checkCircleFilled);
            break;
          case TProgressStatus.error:
            iconThemeData = IconThemeData(
              color: colorScheme.errorColor,
              size: iconSize,
            );
            label ??= const Icon(TIcons.closeCircleFilled);
            break;
          case TProgressStatus.warning:
            iconThemeData = IconThemeData(
              color: colorScheme.warningColor,
              size: iconSize,
            );
            label ??= const Icon(TIcons.errorCircleFilled);
            break;
          default:
            label ??= Text('${(percentage).round()}%');
        }
        break;
      case TProgressTheme.plump:
        Color fontColor;
        if (animationPercentage <= 10) {
          fontColor = colorScheme.textColorPrimary;
        } else {
          fontColor = colorScheme.textColorAnti;
        }
        style = TextStyle(
          fontSize: theme.fontData.fontSizeS,
          color: fontColor,
          overflow: TextOverflow.ellipsis,
        );
        label ??= Text('${(percentage).round()}%');
        break;
      case TProgressTheme.circle:
        double fontSize = size.sizeOf(small: 14, medium: 20, large: 36);
        var iconSize = fontSize * 2.40;
        style = TextStyle(
          fontSize: fontSize,
          color: colorScheme.textColorPrimary,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w500,
        );
        switch (status) {
          case TProgressStatus.success:
            iconThemeData = IconThemeData(
              color: colorScheme.successColor,
              size: iconSize,
            );
            label ??= const Icon(TIcons.check);
            break;
          case TProgressStatus.error:
            iconThemeData = IconThemeData(
              color: colorScheme.errorColor,
              size: iconSize,
            );
            label ??= const Icon(TIcons.close);
            break;
          case TProgressStatus.warning:
            iconThemeData = IconThemeData(
              color: colorScheme.warningColor,
              size: iconSize,
            );
            label ??= const Icon(TIcons.error);
            break;
          default:
            label ??= Text('${(percentage).round()}%');
        }
        break;
    }
    if (iconThemeData != null) {
      label = IconTheme(data: iconThemeData, child: label);
    }
    label = DefaultTextStyle(style: style, child: label);
    return label;
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var trackColor = widget.trackColor ?? colorScheme.bgColorComponent;
    var size = widget.size ?? theme.size;

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
          strokeWidth = size.sizeOf(small: 4, medium: 6, large: 6)!;
          break;
      }
    }

    // 线条颜色
    List<Color>? color = widget.color;
    if (color == null) {
      switch (status) {
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

    // 运动状态
    var isAction = widget.status == TProgressStatus.active && percentage < 100;
    switch (widget.theme) {
      case TProgressTheme.line:
        var list = <Widget>[
          Expanded(
            child: _TProgressActionPaint(
              action: isAction,
              willChange: isAction,
              isComplex: isAction,
              size: Size.fromHeight(strokeWidth),
              painter: (animation) {
                return _TLinePrinter(
                  percentage: animationPercentage,
                  strokeWidth: strokeWidth!,
                  color: color!,
                  trackColor: trackColor,
                  animation: animation,
                  actionColor: colorScheme.textColorAnti,
                );
              },
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
      case TProgressTheme.plump:
        Widget? label;
        if (widget.showLabel) {
          AlignmentGeometry alignment1;
          AlignmentGeometry alignment2;
          double widthFactor;
          if (animationPercentage > 10) {
            alignment1 = Alignment.centerLeft;
            alignment2 = Alignment.centerRight;
            widthFactor = animationPercentage / 100;
          } else {
            alignment1 = Alignment.centerRight;
            alignment2 = Alignment.centerLeft;
            widthFactor = 1 - animationPercentage / 100;
          }
          label = FractionallySizedBox(
            alignment: alignment1,
            widthFactor: widthFactor,
            child: Align(
              alignment: alignment2,
              child: Padding(
                padding: EdgeInsets.only(left: strokeWidth / 2 + TVar.spacer1),
                child: _buildLabel(theme, colorScheme),
              ),
            ),
          );
        }
        return Container(
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: strokeWidth,
          ),
          child: _TProgressActionPaint(
            action: isAction,
            willChange: isAction,
            isComplex: isAction,
            painter: (animation) {
              return _TLinePrinter(
                percentage: animationPercentage,
                strokeWidth: strokeWidth!,
                color: color!,
                trackColor: trackColor,
                animation: animation,
                actionColor: colorScheme.textColorAnti,
              );
            },
            child: label,
          ),
        );
      case TProgressTheme.circle:
        Widget? label;
        var boxSize = widget.boxSize;
        boxSize ??= Size.square(size.sizeOf(small: 72, medium: 112, large: 160));

        if (widget.showLabel) {
          label = Center(child: _buildLabel(theme, colorScheme));
        }
        return Container(
          constraints: BoxConstraints.tightFor(
            width: boxSize.width,
            height: boxSize.height,
          ),
          child: _TProgressActionPaint(
            action: isAction,
            willChange: isAction,
            isComplex: isAction,
            painter: (animation) {
              return _TCirclePainter(
                percentage: animationPercentage,
                strokeWidth: strokeWidth!,
                color: color!,
                trackColor: trackColor,
                animation: animation,
                actionColor: colorScheme.textColorAnti,
              );
            },
            child: label,
          ),
        );
    }
  }
}

typedef AnimationPainter = CustomPainter Function(Animation<double> animation);

class _TProgressActionPaint extends StatefulWidget {
  const _TProgressActionPaint({
    super.key,
    this.painter,
    this.size = Size.zero,
    this.isComplex = false,
    this.willChange = false,
    this.child,
    required this.action,
  });

  /// 子组件
  final Widget? child;

  /// 继承自[CustomPaint.painter]
  final AnimationPainter? painter;

  /// 继承自[CustomPaint.size]
  final Size size;

  /// 继承自[CustomPaint.isComplex]
  final bool isComplex;

  /// 继承自[CustomPaint.willChange]
  final bool willChange;

  /// 是否是运动状态
  final bool action;

  @override
  State<_TProgressActionPaint> createState() => _TProgressActionPaintState();
}

class _TProgressActionPaintState extends State<_TProgressActionPaint> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation curvedAnimation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    curvedAnimation = CurvedAnimation(parent: _animationController, curve: const Cubic(.23, .99, .86, .2));
    if (widget.action) {
      _animationController.repeat();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _TProgressActionPaint oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.action != oldWidget.action) {
      if (widget.action) {
        _animationController.repeat();
      } else {
        _animationController.value = 0;
        _animationController.stop();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    curvedAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: widget.painter?.call(curvedAnimation),
      size: widget.size,
      isComplex: widget.isComplex,
      willChange: widget.willChange,
      child: widget.child,
    );
  }
}

/// 线条
class _TLinePrinter extends CustomPainter {
  const _TLinePrinter({
    required this.animation,
    required this.percentage,
    required this.color,
    required this.strokeWidth,
    required this.trackColor,
    required this.actionColor,
  }) : super(repaint: animation);

  /// 动画
  final Animation<double> animation;

  /// 进度条百分比 0-100
  final double percentage;

  /// 进度条颜色,多个颜色会形成渐变色
  final List<Color> color;

  /// 进度条线宽。宽度数值不能超过 size 的一半，否则不能输出环形进度
  final double strokeWidth;

  /// 进度条未完成部分颜色
  final Color trackColor;

  /// 运动状态颜色
  final Color actionColor;

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
    if (p2.dx <= p1.dx) {
      return;
    }
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

    // action动画
    if(animation.value > 0) {
      var value = animation.value;
      if (value <= .35) {
        var tween = Tween<double>(begin: .1, end: .4);
        paint.color = actionColor.withOpacity(tween.transform(value));
      } else {
        var tween = Tween<double>(begin: .4, end: 0);
        paint.color = actionColor.withOpacity(tween.transform(value));
      }
      paint.shader = null;
      paint.strokeCap = StrokeCap.round;
      canvas.drawLine(p1, Offset(max(p1.dx, p2.dx * value), p2.dy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TLinePrinter oldDelegate) {
    return this != oldDelegate;
  }
}

/// 圆形
class _TCirclePainter extends CustomPainter {
  const _TCirclePainter({
    required this.animation,
    required this.percentage,
    required this.color,
    required this.strokeWidth,
    required this.trackColor,
    required this.actionColor,
  }) : super(repaint: animation);

  /// 动画
  final Animation<double> animation;

  /// 进度条百分比 0-100
  final double percentage;

  /// 进度条颜色,多个颜色会形成渐变色
  final List<Color> color;

  /// 进度条线宽。宽度数值不能超过 size 的一半，否则不能输出环形进度
  final double strokeWidth;

  /// 进度条未完成部分颜色
  final Color trackColor;

  /// 运动状态颜色
  final Color actionColor;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    var effectiveSize = Size(size.width - strokeWidth, size.height - strokeWidth);
    var offset = Offset(strokeWidth / 2, strokeWidth / 2);

    // 轨道
    paint.color = trackColor;
    canvas.drawArc(offset & effectiveSize, 0, pi * 2, false, paint);

    var endAngle = pi * 2 * (percentage / 100);
    if (endAngle == 0) {
      return;
    }
    if (color.length > 1) {
      var radians = (-pi / 2) - (strokeWidth * 4 / (pi * effectiveSize.width));
      Gradient gradient = SweepGradient(
        colors: color,
        endAngle: endAngle,
        transform: GradientRotation(radians),
      );
      paint.shader = gradient.createShader(offset & effectiveSize);
    } else {
      paint.color = color[0];
    }

    canvas.drawArc(offset & effectiveSize, -pi / 2, endAngle, false, paint);

    // action动画
    if (animation.value > 0) {
      var value = animation.value;
      if (value <= .35) {
        var tween = Tween<double>(begin: .1, end: .4);
        paint.color = actionColor.withOpacity(tween.transform(value));
      } else {
        var tween = Tween<double>(begin: .4, end: 0);
        paint.color = actionColor.withOpacity(tween.transform(value));
      }
      paint.shader = null;
      paint.strokeCap = StrokeCap.round;
      canvas.drawArc(offset & effectiveSize, -pi / 2, endAngle * animation.value, false, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TCirclePainter oldDelegate) {
    return this != oldDelegate;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TCirclePainter &&
          runtimeType == other.runtimeType &&
          percentage == other.percentage &&
          color == other.color &&
          strokeWidth == other.strokeWidth &&
          trackColor == other.trackColor;

  @override
  int get hashCode => percentage.hashCode ^ color.hashCode ^ strokeWidth.hashCode ^ trackColor.hashCode;
}
