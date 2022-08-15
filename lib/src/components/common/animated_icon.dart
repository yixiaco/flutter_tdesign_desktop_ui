import 'package:flutter/widgets.dart';

/// 自定义动画icon
class TAnimatedIcon extends ImplicitlyAnimatedWidget {
  const TAnimatedIcon({
    Key? key,
    this.color,
    this.opacity,
    this.size,
    this.shadows,
    required this.child,
    Curve curve = Curves.linear,
    required Duration duration,
    VoidCallback? onEnd,
  }) : super(key: key, curve: curve, duration: duration, onEnd: onEnd);

  /// The default color for icons.
  final Color? color;

  final double? opacity;

  /// The default size for icons.
  final double? size;

  /// The default shadow for icons.
  final List<Shadow>? shadows;

  /// 子组件,执行动画期间，会立即改变
  final Widget child;

  @override
  AnimatedWidgetBaseState<TAnimatedIcon> createState() => _TAnimatedIconState();
}

class _TAnimatedIconState extends AnimatedWidgetBaseState<TAnimatedIcon> {
  ColorTween? _color;
  Tween<double>? _opacity;
  Tween<double>? _size;
  ShadowsTween? _shadows;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color = visitor(_color, widget.color, (dynamic value) => ColorTween(begin: value as Color)) as ColorTween?;
    _opacity = visitor(_opacity, widget.opacity, (dynamic value) => Tween<double>(begin: value as double)) as Tween<double>?;
    _size = visitor(_size, widget.size, (dynamic value) => Tween<double>(begin: value as double)) as Tween<double>?;
    _shadows = visitor(_shadows, widget.shadows, (dynamic value) => ShadowsTween(begin: value as List<Shadow>)) as ShadowsTween?;
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
        child: widget.child);
  }
}

class ShadowsTween extends Tween<List<Shadow>?> {
  ShadowsTween({List<Shadow>? begin, List<Shadow>? end}) : super(begin: begin, end: end);

  /// Returns the value this variable has at the given animation clock value.
  @override
  List<Shadow>? lerp(double t) => Shadow.lerpList(begin, end, t);
}
