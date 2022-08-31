import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

const _kPeriod = Duration(milliseconds: 200);
const _kDefaultRippleColor = Color.fromRGBO(0, 0, 0, .35);

/// 斜8度水波纹
class TAngleRipple extends StatefulWidget {
  const TAngleRipple({
    Key? key,
    required this.beforeBuilder,
    required this.afterBuilder,
    this.disabled = false,
    this.selected = false,
    this.cursor,
    this.focusNode,
    this.autofocus = false,
    this.behavior = HitTestBehavior.translucent,
    this.onTap,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.actions,
    this.shortcuts,
    this.fixedRippleColor,
    this.enableFeedback,
  }) : super(key: key);

  /// 是否禁用
  final bool disabled;

  /// 是否选中状态
  final bool selected;

  /// 鼠标
  final MaterialStateProperty<MouseCursor?>? cursor;

  /// 子组件构建器之前
  final Widget Function(BuildContext context, Set<MaterialState> states) beforeBuilder;

  /// 子组件构建器之后
  final Widget Function(BuildContext context, Set<MaterialState> states, Widget child) afterBuilder;

  /// 焦点
  final FocusNode? focusNode;

  /// 是否自动聚焦
  final bool autofocus;

  /// 在命中测试期间的行为。
  final HitTestBehavior? behavior;

  /// 点击事件
  final GestureTapCallback? onTap;

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

  @override
  State<TAngleRipple> createState() => _TAngleRippleState();
}

class _TAngleRippleState extends State<TAngleRipple> with TickerProviderStateMixin {
  late AnimationController _angleController;
  late AnimationController _fadeOutController;
  late CurvedAnimation _transformAnimation;
  late Animation<int> _fadeOut;

  @override
  void initState() {
    _angleController = AnimationController(
      vsync: this,
      duration: _kPeriod,
    );
    _fadeOutController = AnimationController(
      vsync: this,
      duration: _kPeriod * 2,
    );

    _transformAnimation = CurvedAnimation(
      parent: _angleController,
      curve: TVar.animTimeFnEasing,
    );
    _fadeOut = _fadeOutController.drive(
      IntTween(
        begin: (widget.fixedRippleColor ?? _kDefaultRippleColor).alpha,
        end: 0,
      ).chain(CurveTween(curve: Curves.linear)),
    );
    super.initState();
  }

  @override
  void dispose() {
    _transformAnimation.dispose();
    _angleController.dispose();
    _fadeOutController.dispose();
    super.dispose();
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
        onLongPress: widget.onLongPress,
        behavior: widget.behavior,
        cursor: widget.cursor,
        selected: widget.selected,
        onFocusChange: widget.onFocusChange,
        onHover: widget.onHover,
        enableFeedback: widget.enableFeedback ?? true,
        builder: (context, states) {
          Widget child = CustomPaint(
            painter: _TAngleRipplePainter(
              transformAnimation: _transformAnimation,
              fadeOut: _fadeOut,
              fixedRippleColor: widget.fixedRippleColor ?? _kDefaultRippleColor,
            ),
            child: widget.beforeBuilder(context, states),
          );
          return widget.afterBuilder(context, states, child);
        },
      ),
    );
  }

  /// 处理点击事件
  void _handleOnTapDown([TapDownDetails? details]) {
    _angleController.forward(from: 0);
    _fadeOutController.value = 0;
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
    _angleController.forward();
    _fadeOutController.animateTo(1.0);
  }

  void cancel() {
    _angleController.forward();
    _fadeOutController.animateTo(1.0);
  }
}

class _TAngleRipplePainter extends CustomPainter {
  _TAngleRipplePainter({
    required this.transformAnimation,
    required this.fadeOut,
    required this.fixedRippleColor,
  }) : super(repaint: Listenable.merge([transformAnimation, fadeOut]));

  final CurvedAnimation transformAnimation;
  final Animation<int> fadeOut;

  /// 斜八角的动画颜色
  final Color fixedRippleColor;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = fixedRippleColor.withAlpha(fadeOut.value);

    var path = Path();
    // tan((180d / 22) = 8°) * 临边 = 对边
    var width = (size.width + tan(pi / 22) * size.height) * transformAnimation.value;
    if (width > 0) {
      path.addRect(Rect.fromLTWH(0, 0, width, size.height));
      canvas.drawPath(path.transform(Matrix4.skewX(-pi / 22).storage), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TAngleRipplePainter oldDelegate) {
    return this != oldDelegate;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _TAngleRipplePainter &&
          runtimeType == other.runtimeType &&
          transformAnimation == other.transformAnimation &&
          fadeOut == other.fadeOut &&
          fixedRippleColor == other.fixedRippleColor;

  @override
  int get hashCode => transformAnimation.hashCode ^ fadeOut.hashCode ^ fixedRippleColor.hashCode;
}
