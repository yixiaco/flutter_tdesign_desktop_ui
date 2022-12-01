import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

const _kPeriod = Duration(milliseconds: 200);
const _kDefaultRippleColor = Color.fromRGBO(0, 0, 0, .35);

typedef RippleBuilder = Widget Function(BuildContext context, Set<MaterialState> states);
typedef RippleAfterBuilder = Widget Function(BuildContext context, Set<MaterialState> states, Widget child);

/// 水波纹
class TRipple extends StatefulWidget {
  const TRipple({
    super.key,
    required this.builder,
    this.afterBuilder,
    this.disabled = false,
    this.selected = false,
    this.selectedClick = true,
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
    this.animatedDuration,
    this.curve = Curves.linear,
  });

  /// 是否禁用
  final bool disabled;

  /// 是否选中状态
  final bool selected;

  /// 选中状态下是否可以点击
  final bool selectedClick;

  /// 鼠标
  final MaterialStateProperty<MouseCursor?>? cursor;

  /// 子组件构建器之前
  final RippleBuilder builder;

  /// 子组件构建器之后
  final RippleAfterBuilder? afterBuilder;

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

  /// 波纹，默认是一个斜8°工厂[InkBevelAngleRipple],赋值为null时，不会创建波纹
  final RippleFactory? splashFactory;

  /// 圆角
  final BorderRadius? radius;

  /// 形状剪切
  final ShapeBorder? shape;

  /// 背景色
  final MaterialStateProperty<Color?>? backgroundColor;

  /// 动画持续时间
  final Duration? animatedDuration;

  /// 动画曲线
  final Curve curve;

  @override
  State<TRipple> createState() => _TRippleState();
}

class _TRippleState extends State<TRipple> with TickerProviderStateMixin {
  Set<RippleSplash>? _splashes;
  RippleSplash? _currentSplash;
  _TAngleRipplePainter painter = _TAngleRipplePainter();

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

  bool get _isClick {
    if (widget.disabled) {
      return false;
    }
    if (widget.selected && !widget.selectedClick) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return AllowTapListener(
      onTapDown: _handleOnTapDown,
      onTapUp: _handleUp,
      onTapCancel: _handleCancel,
      child: TMaterialStateButton(
        shortcuts: widget.shortcuts,
        actions: widget.actions ?? activeMap(context),
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        disabled: widget.disabled,
        onTapDown: widget.onTapDown,
        onTap: widget.onTap,
        onTapUp: widget.onTapUp,
        onTapCancel: widget.onTapCancel,
        onLongPress: widget.onLongPress,
        behavior: widget.behavior,
        cursor: widget.cursor,
        selected: widget.selected,
        selectedClick: widget.selectedClick,
        onFocusChange: widget.onFocusChange,
        onHover: widget.onHover,
        enableFeedback: widget.enableFeedback ?? true,
        child: Builder(
          builder: (context) {
            var states = TMaterialStateScope.of(context)!;
            Widget child = CustomPaint(
              painter: painter..splashes = _splashes,
              child: widget.builder(context, states),
            );
            if (widget.backgroundColor != null) {
              if (widget.animatedDuration != null) {
                child = AnimatedContainer(
                  color: widget.backgroundColor?.resolve(states),
                  duration: widget.animatedDuration!,
                  curve: widget.curve,
                  child: child,
                );
              } else {
                child = Container(
                  color: widget.backgroundColor?.resolve(states),
                  child: child,
                );
              }
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
            if (widget.radius == null && widget.shape == null) {
              child = ClipRect(
                child: child,
              );
            }
            return widget.afterBuilder?.call(context, states, child) ?? child;
          },
        ),
      ),
    );
  }

  Map<Type, Action<Intent>> activeMap(BuildContext context) {
    final Map<Type, Action<Intent>> actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (intent) {
          if (widget.disabled) {
            return;
          }
          if (widget.selected && !widget.selectedClick) {
            return;
          }
          _doSplash();
          _confirm();
          widget.onTap?.call();
          context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
          return null;
        },
      ),
    };
    return actionMap;
  }

  /// 处理点击事件
  void _handleOnTapDown(TapDownDetails details) {
    if(!_isClick) {
      return;
    }
    _doSplash();
  }

  void _doSplash() {
    var rippleController = RippleController(
      vsync: this,
      color: widget.fixedRippleColor ?? _kDefaultRippleColor,
      notifyListeners: painter.markNeedsPaint,
    );

    RippleSplash? splash = createSplash(rippleController);
    if (splash != null) {
      _splashes ??= HashSet<RippleSplash>();
      _splashes!.add(splash);
      _currentSplash?.cancel();
      _currentSplash = splash;
      splash.start();
    }
  }

  RippleSplash? createSplash(RippleController rippleController) {
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

    splash = widget.splashFactory?.create(
      controller: rippleController,
      referenceBox: context.findRenderObject() as RenderBox,
      onRemoved: onRemoved,
    );
    return splash;
  }

  void _handleUp(TapUpDetails details) {
    _confirm();
  }

  void _handleCancel([TapUpDetails? details]) {
    _cancel();
  }

  ///当鼠标左键放开时
  void _confirm() {
    _currentSplash?.confirm();
  }

  void _cancel() {
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
  /// 波纹控制器
  final RippleController controller;

  /// 释放资源时需要执行的删除回调
  final void Function() onRemove;

  const RippleSplash({
    required this.controller,
    required this.onRemove,
  });

  /// 开始动画
  void start();

  /// 左键释放执行的动画
  void confirm();

  /// 取消点击时执行的动画
  void cancel();

  /// 画图
  void paint(Canvas canvas, Size size);

  /// 释放资源
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
  void start() {
    _angleController.forward(from: 0);
    _fadeOutController.value = 0;
  }

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
}
