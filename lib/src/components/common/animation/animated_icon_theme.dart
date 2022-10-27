import 'package:flutter/widgets.dart';

/// 自定义动画icon样式
class TAnimatedIconTheme extends ImplicitlyAnimatedWidget {
  const TAnimatedIconTheme({
    super.key,
    this.color,
    this.opacity,
    this.size,
    this.shadows,
    required this.child,
    super.curve = Curves.linear,
    this.data,
    required super.duration,
    super.onEnd,
  });

  /// icon颜色
  final Color? color;

  /// 透明度
  final double? opacity;

  /// icon大小
  final double? size;

  /// icon阴影
  final List<Shadow>? shadows;

  /// icon theme data
  final IconThemeData? data;

  /// 子组件,执行动画期间，会立即改变
  final Widget child;

  @override
  AnimatedWidgetBaseState<TAnimatedIconTheme> createState() => _TAnimatedIconState();
}

class _TAnimatedIconState extends AnimatedWidgetBaseState<TAnimatedIconTheme> {
  ColorTween? _color;
  Tween<double>? _opacity;
  Tween<double>? _size;
  ShadowsTween? _shadows;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color = visitor(_color, widget.color ?? widget.data?.color, (dynamic value) => ColorTween(begin: value as Color))
        as ColorTween?;
    _opacity = visitor(
            _opacity, widget.opacity ?? widget.data?.opacity, (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
    _size = visitor(_size, widget.size ?? widget.data?.size, (dynamic value) => Tween<double>(begin: value as double))
        as Tween<double>?;
    _shadows = visitor(_shadows, widget.shadows ?? widget.data?.shadows,
        (dynamic value) => ShadowsTween(begin: value as List<Shadow>)) as ShadowsTween?;
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(
        color: _color?.evaluate(animation),
        size: _size?.evaluate(animation),
        opacity: _opacity?.evaluate(animation).clamp(0.0, 1.0),
        shadows: _shadows?.evaluate(animation),
      ),
      child: widget.child,
    );
  }
}

class ShadowsTween extends Tween<List<Shadow>?> {
  ShadowsTween({List<Shadow>? begin, List<Shadow>? end}) : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  List<Shadow>? lerp(double t) => Shadow.lerpList(begin, end, t);
}
