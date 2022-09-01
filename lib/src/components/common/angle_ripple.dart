import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

const _kPeriod = Duration(milliseconds: 200);
const _kDefaultRippleColor = Color.fromRGBO(0, 0, 0, .35);

/// 水波纹
class TRipple extends StatefulWidget {
  const TRipple({
    Key? key,
    required this.builder,
    this.afterBuilder,
    this.disabled = false,
    this.selected = false,
    this.cursor,
    this.focusNode,
    this.autofocus = false,
    this.behavior = HitTestBehavior.translucent,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.actions,
    this.shortcuts,
    this.fixedRippleColor,
    this.enableFeedback,
    this.splashFactory = InkBevelAngleRipple.factory,
    this.radius,
    this.shape,
    this.backgroundColor,
  }) : super(key: key);

  /// 是否禁用
  final bool disabled;

  /// 是否选中状态
  final bool selected;

  /// 鼠标
  final MaterialStateProperty<MouseCursor?>? cursor;

  /// 子组件构建器之前
  final Widget Function(BuildContext context, Set<MaterialState> states) builder;

  /// 子组件构建器之后
  final Widget Function(BuildContext context, Set<MaterialState> states, Widget child)? afterBuilder;

  /// 焦点
  final FocusNode? focusNode;

  /// 是否自动聚焦
  final bool autofocus;

  /// 在命中测试期间的行为。
  final HitTestBehavior? behavior;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 松开点击回调
  final GestureTapUpCallback? onTapUp;

  /// 点击事件
  final GestureTapDownCallback? onTapDown;

  /// 取消点击回调
  final GestureTapCancelCallback? onTapCancel;

  /// 长按
  final GestureLongPressCallback? onLongPress;

  /// 鼠标经过
  final ValueChanged<bool>? onHover;

  /// 聚焦变更
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.actions.actions}
  final Map<Type, Action<Intent>>? actions;

  /// {@macro flutter.widgets.shortcuts.shortcuts}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// 斜八角的动画颜色
  final Color? fixedRippleColor;

  /// 检测到的手势是否应该提供声音和/或触觉反馈。
  /// 例如，在Android上，当反馈功能被启用时，轻按会产生点击声，长按会产生短暂的震动。
  /// 通常组件的默认值是true
  final bool? enableFeedback;

  /// 波纹
  final RippleFactory splashFactory;

  /// 圆角
  final BorderRadius? radius;

  /// 形状剪切
  final ShapeBorder? shape;

  /// 背景色
  final MaterialStateProperty<Color?>? backgroundColor;

  @override
  State<TRipple> createState() => _TRippleState();
}

class _TRippleState extends State<TRipple> with TickerProviderStateMixin {
  Set<RippleSplash>? _splashes;
  RippleSplash? _currentSplash;
  _TAngleRipplePainter painter = _TAngleRipplePainter();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    painter.dispose();
  }

  @override
  void deactivate() {
    super.deactivate();
    _removeSplash();
  }

  void _removeSplash() {
    if (_splashes != null) {
      final Set<RippleSplash> splashes = _splashes!;
      _splashes = null;
      for (final RippleSplash splash in splashes) {
        splash.dispose();
      }
      _currentSplash = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AllowTapListener(
      onTapUp: _handleCancel,
      onTapCancel: _handleCancel,
      child: TMaterialStateBuilder(
        shortcuts: widget.shortcuts,
        actions: widget.actions,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        disabled: widget.disabled,
        onTapDown: _handleOnTapDown,
        onTap: _handleTap,
        onTapUp: widget.onTapUp,
        onTapCancel: widget.onTapCancel,
        onLongPress: widget.onLongPress,
        behavior: widget.behavior,
        cursor: widget.cursor,
        selected: widget.selected,
        onFocusChange: widget.onFocusChange,
        onHover: widget.onHover,
        enableFeedback: widget.enableFeedback ?? true,
        builder: (context, states) {
          Widget child = CustomPaint(
            painter: painter..splashes = _splashes,
            child: widget.builder(context, states),
          );
          if (widget.backgroundColor != null) {
            child = Container(
              color: widget.backgroundColor?.resolve(states),
              child: child,
            );
          }
          if (widget.radius != null) {
            child = ClipRRect(
              borderRadius: widget.radius,
              child: child,
            );
          }
          if (widget.shape != null) {
            child = ClipPath(
              clipper: ShapeBorderClipper(shape: widget.shape!),
              child: child,
            );
          }
          if(widget.radius == null && widget.shape == null){
            child = ClipRect(
              child: child,
            );
          }
          return widget.afterBuilder?.call(context, states, child) ?? child;
        },
      ),
    );
  }

  /// 处理点击事件
  void _handleOnTapDown(TapDownDetails details) {
    var rippleController = RippleController(
      vsync: this,
      color: widget.fixedRippleColor ?? _kDefaultRippleColor,
      notifyListeners: painter.markNeedsPaint,
    );

    RippleSplash splash = createSplash(rippleController);
    _splashes ??= HashSet<RippleSplash>();
    _splashes!.add(splash);
    _currentSplash?.cancel();
    _currentSplash = splash;
    splash.start();
    widget.onTapDown?.call(details);
  }

  RippleSplash createSplash(RippleController rippleController) {
    RippleSplash? splash;
    void onRemoved() {
      if (_splashes != null) {
        assert(_splashes!.contains(splash));
        _splashes!.remove(splash);
        if (_currentSplash == splash) {
          _currentSplash = null;
        }
      }
    }

    splash = widget.splashFactory.create(
      controller: rippleController,
      referenceBox: context.findRenderObject() as RenderBox,
      onRemoved: onRemoved,
    );
    return splash;
  }

  void _handleTap() {
    confirm();
    widget.onTap?.call();
  }

  void _handleCancel([TapUpDetails? details]) {
    cancel();
  }

  ///当鼠标左键放开时
  void confirm() {
    _currentSplash?.confirm();
  }

  void cancel() {
    _currentSplash?.cancel();
  }
}

class _TAngleRipplePainter extends ChangeNotifier implements CustomPainter {
  Set<RippleSplash>? get splashes => _splashes;
  Set<RippleSplash>? _splashes;

  set splashes(Set<RippleSplash>? splash) {
    if (_splashes != splash) {
      _splashes = splash;
      notifyListeners();
    }
  }

  void markNeedsPaint() {
    notifyListeners();
  }

  @override
  void paint(Canvas canvas, Size size) {
    _splashes?.forEach((splash) {
      splash.paint(canvas, size);
    });
  }

  @override
  bool shouldRepaint(covariant _TAngleRipplePainter oldDelegate) {
    return this != oldDelegate;
  }

  @override
  bool? hitTest(Offset position) {
    return null;
  }

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// 波纹控制器
class RippleController {
  RippleController({
    required this.vsync,
    required this.notifyListeners,
    required this.color,
  });

  /// 波纹颜色
  Color color;

  /// 动画Ticker
  final TickerProvider vsync;

  /// 通知更新重绘
  void Function() notifyListeners;
}

/// 实现波纹需要继承的基类
abstract class RippleSplash {
  final RippleController controller;

  final void Function() onRemove;

  const RippleSplash({
    required this.controller,
    required this.onRemove,
  });

  void start();

  void confirm();

  void cancel();

  void paint(Canvas canvas, Size size);

  @mustCallSuper
  void dispose() {
    onRemove();
  }
}

/// 创建水波纹工厂
abstract class RippleFactory {
  const RippleFactory();

  /// 创建一个波纹
  RippleSplash create({
    required RippleController controller,
    required RenderBox referenceBox,
    required VoidCallback onRemoved,
  });
}

/// 斜8°波纹工厂
class _InkBevelAngleRippleFactory extends RippleFactory {
  const _InkBevelAngleRippleFactory();

  @override
  RippleSplash create({
    required RippleController controller,
    required RenderBox referenceBox,
    required VoidCallback onRemoved,
  }) {
    return InkBevelAngleRipple(
      controller: controller,
      onRemove: onRemoved,
    );
  }
}

/// 斜8°波纹
class InkBevelAngleRipple extends RippleSplash {
  InkBevelAngleRipple({
    required super.controller,
    required super.onRemove,
  }) {
    _angleController = AnimationController(
      vsync: controller.vsync,
      duration: _kPeriod,
    )..addListener(controller.notifyListeners);
    _fadeOutController = AnimationController(
      vsync: controller.vsync,
      duration: _kPeriod * 2,
    )
      ..addListener(controller.notifyListeners)
      ..addStatusListener(_handleAlphaStatusChanged);

    _transformAnimation = CurvedAnimation(
      parent: _angleController,
      curve: TVar.animTimeFnEasing,
    );
    _fadeOut = _fadeOutController.drive(
      IntTween(
        begin: (controller.color).alpha,
        end: 0,
      ).chain(CurveTween(curve: Curves.linear)),
    );
  }

  void _handleAlphaStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      dispose();
    }
  }

  static const RippleFactory factory = _InkBevelAngleRippleFactory();

  late AnimationController _angleController;
  late AnimationController _fadeOutController;
  late CurvedAnimation _transformAnimation;
  late Animation<int> _fadeOut;

  @override
  void cancel() {
    _angleController.forward();
    _fadeOutController.animateTo(1.0);
  }

  @override
  void confirm() {
    _angleController.forward();
    _fadeOutController.animateTo(1.0);
  }

  @override
  void dispose() {
    super.dispose();
    _transformAnimation.dispose();
    _angleController.dispose();
    _fadeOutController.dispose();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = controller.color.withAlpha(_fadeOut.value);

    var path = Path();
    // tan((180d / 22) = 8°) * 临边 = 对边
    var width = (size.width + tan(pi / 22) * size.height) * _transformAnimation.value;
    if (width > 0) {
      path.addRect(Rect.fromLTWH(0, 0, width, size.height));
      canvas.drawPath(path.transform(Matrix4.skewX(-pi / 22).storage), paint);
    }
  }

  @override
  void start() {
    _angleController.forward(from: 0);
    _fadeOutController.value = 0;
  }
}
