import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层
class TPopup extends StatefulWidget {
  const TPopup({
    Key? key,
    this.placement = TPopupPlacement.top,
    this.trigger = TPopupTrigger.hover,
    this.showArrow = false,
    this.disabled = false,
    this.visible,
    this.content,
    required this.child,
    this.onOpen,
    this.onClose,
    this.showDuration = const Duration(milliseconds: 250),
    this.hideDuration = const Duration(milliseconds: 150),
    this.destroyOnClose = false,
  })  : builderContent = null,
        super(key: key);

  const TPopup.build({
    Key? key,
    this.placement = TPopupPlacement.top,
    this.trigger = TPopupTrigger.hover,
    this.showArrow = false,
    this.disabled = false,
    this.visible,
    this.builderContent,
    required this.child,
    this.onOpen,
    this.onClose,
    this.showDuration = const Duration(milliseconds: 250),
    this.hideDuration = const Duration(milliseconds: 150),
    this.destroyOnClose = false,
  })  : content = null,
        super(key: key);

  /// 浮层出现位置
  final TPopupPlacement placement;

  /// 触发浮层出现的方式。可选项：hover/click/focus/context-menu
  final TPopupTrigger trigger;

  /// 是否显示浮层箭头
  final bool showArrow;

  /// 是否禁用组件
  final bool disabled;

  /// 是否显示浮层,默认为false,当你需要手动控制它时，你应该传输一个ValueNotifier
  final ValueNotifier<bool>? visible;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.ProxyWidget.child}
  final Widget child;

  /// 弹窗内容
  final Widget? content;

  /// 打开事件
  final void Function()? onOpen;

  /// 关闭事件
  final void Function()? onClose;

  /// hover和focus时，显示的延迟
  final Duration showDuration;

  /// hover和focus时，隐藏的延迟
  final Duration hideDuration;

  /// 是否在关闭浮层时销毁浮层
  final bool destroyOnClose;

  /// 使用build创建浮层
  final WidgetBuilder? builderContent;

  @override
  State<TPopup> createState() => TPopupState();
}

class TPopupState extends State<TPopup> with TickerProviderStateMixin {
  /// 显隐值
  late ValueNotifier<bool> visible;

  /// 区域焦点节点
  FocusScopeNode? _node;

  /// 动画控制器
  late AnimationController _controller;

  /// 默认淡入持续时间
  static const Duration _fadeInDuration = Duration(milliseconds: 150);

  /// 默认淡出持续时间
  static const Duration _fadeOutDuration = Duration(milliseconds: 75);

  /// 默认垂直偏移
  static const double _defaultVerticalOffset = 6.0;

  /// 显示浮层计时器
  Timer? _showTimer;

  /// 隐藏浮层计时器
  Timer? _hideTimer;

  /// 浮层对象
  OverlayEntry? _entry;

  /// 停止向上传播
  bool _stopPropagation = false;

  /// 是否存在全局指针路由事件
  bool _existGlobalPointerRoute = false;

  /// 链接浮层与组件
  final LayerLink _layerLink = LayerLink();

  late final ValueNotifier<TPopup> _popupWidget = ValueNotifier(widget);

  @override
  void initState() {
    visible = widget.visible ?? ValueNotifier(false);
    _controller = AnimationController(
      duration: _fadeInDuration,
      reverseDuration: _fadeOutDuration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);

    visible.removeListener(_showHidePopup);
    visible.addListener(_showHidePopup);
    // 初始化显隐
    _showHidePopup();
    if (widget.trigger == TPopupTrigger.focus) {
      _node = FocusScopeNode();
      _node!.addListener(_focusVisible);
    }
    super.initState();
  }

  /// 全局指针路由监听
  void _globalPointerRoute(event) {
    if (event is PointerUpEvent) {
      if (!_stopPropagation) {
        _updateVisible(false);
      }
      _stopPropagation = false;
    }
  }

  /// 动画状态改变
  void _handleStatusChanged(AnimationStatus status) {
    // 浮层被隐藏了，内部执行是否销毁动作
    if (status == AnimationStatus.dismissed) {
      _removeEntry();
    }
  }

  @override
  void dispose() {
    if (widget.visible == null) {
      visible.dispose();
    }
    // 销毁浮层
    _removeEntry(force: true);
    super.dispose();
  }

  /// 判断[visible.value]状态，显示和隐藏浮层
  void _showHidePopup({bool? immediately}) {
    immediately = immediately ?? widget.trigger != TPopupTrigger.hover;
    if (visible.value) {
      _showPopup(immediately: immediately);
    } else {
      _hidePopup(immediately: immediately);
    }
  }

  /// 显示浮层
  void _showPopup({bool immediately = false}) {
    // hover、focus类型不需要监听指针事件
    if (!_existGlobalPointerRoute && widget.trigger.isTrue(click: true, contextMenu: true)) {
      // 监听全局指针事件，这样我们可以在单击其他控件时立即隐藏浮层。
      GestureBinding.instance.pointerRouter.addGlobalRoute(_globalPointerRoute);
      _existGlobalPointerRoute = true;
      // 阻止冒泡关闭浮层
      _stopPropagation = true;
    }
    _hideTimer?.cancel();
    _hideTimer = null;
    if (immediately || _controller.isAnimating) {
      _ensureVisible();
      return;
    }
    _showTimer ??= Timer(widget.showDuration, _ensureVisible);
  }

  /// 隐藏浮层
  void _hidePopup({bool immediately = false}) {
    if (_existGlobalPointerRoute) {
      // 移除监听全局指针事件
      GestureBinding.instance.pointerRouter.removeGlobalRoute(_globalPointerRoute);
      _existGlobalPointerRoute = false;
      _stopPropagation = false;
    }
    _showTimer?.cancel();
    _showTimer = null;
    if (immediately) {
      _reverseVisible();
      return;
    }
    _hideTimer ??= Timer(widget.hideDuration, _reverseVisible);
  }

  /// 立即显示浮层，不应该直接使用这个方法，而是使用[_showPopup]
  void _ensureVisible() {
    _showTimer?.cancel();
    _showTimer = null;
    if (_entry == null) {
      _createEntry();
    }
    widget.onOpen?.call();
    _controller.forward();
  }

  /// 浮层不可见.不应该直接使用这个方法，而是使用[_hidePopup]
  void _reverseVisible() {
    _controller.reverse();
  }

  /// 创建浮层对象，以及立即插入浮层.不应该直接使用这个方法，而是使用[_showPopup]
  void _createEntry() {
    final OverlayState overlayState = Overlay.of(
      context,
      debugRequiredFor: widget,
    )!;

    _entry = OverlayEntry(builder: (BuildContext context) {
      Widget child = _PopupOverlay(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: ThemeDataConstant.spacer),
        onPointerDown: (event) {
          if (widget.trigger.isTrue(click: true, contextMenu: true)) {
            _stopPropagation = true;
          }
        },
        // margin: _margin,
        onEnter: (_) {
          if (widget.trigger.isTrue(hover: true)) {
            if (!_controller.isDismissed) _updateVisible(true);
          }
        },
        onExit: (event) {
          if (widget.trigger.isTrue(hover: true)) {
            _updateVisible(false);
          }
        },
        animation: CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
        offset: _defaultVerticalOffset,
        layerLink: _layerLink,
        popupWidget: _popupWidget,
      );
      return child;
    });
    overlayState.insert(_entry!);
  }

  /// 销毁浮层对象.不应该直接使用这个方法，而是使用[_hidePopup]
  void _removeEntry({bool force = false}) {
    // 是否销毁
    if (widget.destroyOnClose || force) {
      _entry?.remove();
      _entry = null;
    }
    widget.onClose?.call();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (widget.trigger == TPopupTrigger.hover) {
      child = MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (event) => _updateVisible(true),
        onExit: (event) => _updateVisible(false),
        child: widget.child,
      );
    } else if (widget.trigger == TPopupTrigger.click) {
      child = AllowTapListener(
        onTap: () => _updateVisible(),
        child: widget.child,
      );
    } else if (widget.trigger == TPopupTrigger.contextMenu) {
      child = AllowTapListener(
        onSecondaryTap: () => _updateVisible(),
        child: widget.child,
      );
    } else if (widget.trigger == TPopupTrigger.focus) {
      child = FocusScope(
        node: _node,
        child: widget.child,
      );
    }
    return CompositedTransformTarget(
      link: _layerLink,
      child: child,
    );
  }

  /// 更新显示状态
  void _updateVisible([bool? visible]) {
    this.visible.value = visible ?? !this.visible.value;
  }

  @override
  void didUpdateWidget(TPopup oldWidget) {
    // 替换了widget后，焦点可能丢失
    if (widget.trigger == TPopupTrigger.focus) {
      if (_node == null) {
        _node = FocusScopeNode();
        _node!.addListener(_focusVisible);
      }
    } else {
      _node?.dispose();
      _node = null;
    }
    // 在下一帧时，更新这个持有对象
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        _popupWidget.value = widget;
      }
    });
    // 暂时先销毁浮层
    // _removeEntry(force: true);

    super.didUpdateWidget(oldWidget);
  }

  void _focusVisible() {
    if (_node!.hasFocus) {
      visible.value = true;
    } else {
      visible.value = false;
    }
  }
}

/// 用于计算要在全局坐标系中指定的目标上方或下方显示的浮层布局的代理。
class _PopupPositionDelegate extends SingleChildLayoutDelegate {
  /// 创建用于计算浮层布局的委托。
  ///
  /// 参数不能为null。
  _PopupPositionDelegate({
    required this.offset,
    required this.placement,
    required this.margin,
    required this.layerLink,
  });

  /// 与组件之间的偏移量
  final double offset;

  /// 浮层的方向
  final TPopupPlacement placement;

  /// 与窗口边界之间的距离
  final double margin;

  /// 与父组件之间的链接
  final LayerLink layerLink;

  /// 上一次获取到的偏移
  _PopupOffset? _target;

  /// 上一次的位置
  Offset? _offset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

  /// 儿童应放置的位置。
  /// “size”参数是父对象的大小，如果该大小不满足传递给[getSize]的约束，则可能与[getSize]返回的值不同。
  /// “childSize”参数是子对象的大小，它将满足[getConstraintsForChild]返回的约束。
  /// 默认情况下，将子对象定位在父对象的左上角。
  @override
  Offset getPositionForChild(Size size, Size childSize) {
    _readLeader();
    if (layerLink.leaderSize == null || layerLink.leader == null) {
      // 推迟到下一帧更新
      SchedulerBinding.instance.addPostFrameCallback((Duration timeStamp) {
        _readLeader();
      });
    }
    if (_target == null) {
      return _offset ?? const Offset(0, 0);
    }
    // 浮层在组件中的偏移
    _PopupOffset target = _target!;
    double x, y;
    if (placement.isVertical()) {
      // VERTICAL DIRECTION
      var to = target.placement(placement);
      // 适合在下方显示
      final bool fitsBelow = to.dy + offset + childSize.height <= size.height - margin;
      // 适合在上方显示
      final bool fitsAbove = to.dy - offset - childSize.height >= margin;
      // 是否合适在下方显示
      final bool isBelow = placement.isBottom() ? fitsBelow || !fitsAbove : !(fitsAbove || !fitsBelow);
      if (isBelow) {
        y = math.min(target.bottom.dy + offset, size.height - margin);
      } else {
        y = math.max(target.top.dy - offset - childSize.height, margin);
      }
      if (size.width < childSize.width) {
        // 子组件比窗口大
        var center = (size.width - childSize.width) / 2.0;
        x = placement.valueOf(topLeft: 0, bottomLeft: 0, top: center, bottom: center, topRight: 0, bottomRight: 0)!;
      } else {
        if (placement.isTrue(topLeft: true, bottomLeft: true)) {
          final double normalizedTargetX = to.dx.clamp(margin, size.width - margin - childSize.width);
          x = normalizedTargetX;
        } else if (placement.isTrue(topRight: true, bottomRight: true)) {
          var normalizedTargetRight = to.dx.clamp(margin, size.width - margin);
          x = normalizedTargetRight - childSize.width;
        } else {
          final double normalizedTargetX = to.dx.clamp(margin, size.width - margin);
          final double edge = margin + childSize.width / 2.0;
          if (normalizedTargetX < edge) {
            x = margin;
          } else if (normalizedTargetX > size.width - edge) {
            x = size.width - margin - childSize.width;
          } else {
            x = normalizedTargetX - childSize.width / 2.0;
          }
        }
      }
    } else {
      // HORIZONTAL DIRECTION
      var to = target.placement(placement);
      // 适合在右方显示
      final bool fitsRight = to.dx + offset + childSize.width <= size.width - margin;
      // 适合在左方显示
      final bool fitsLeft = to.dx - offset - childSize.width >= margin;
      // 是否合适在右方显示
      final bool isRight = placement.isRight() ? fitsRight || !fitsLeft : !(fitsLeft || !fitsRight);
      if (isRight) {
        x = math.min(target.right.dx + offset, size.width - margin);
      } else {
        x = math.min(target.left.dx - offset - childSize.width, size.width - childSize.width - margin);
      }

      if (size.height < childSize.height) {
        // 子组件比窗口大
        var center = (size.height - childSize.height) / 2.0;
        y = placement.valueOf(leftTop: 0, rightTop: 0, top: center, bottom: center, leftBottom: 0, rightBottom: 0)!;
      } else {
        if (placement.isTrue(leftTop: true, rightTop: true)) {
          final double normalizedTargetY = to.dy.clamp(margin, size.height - margin - childSize.height);
          y = normalizedTargetY;
        } else if (placement.isTrue(leftBottom: true, rightBottom: true)) {
          var normalizedTargetY = to.dy.clamp(margin, size.height - margin);
          y = normalizedTargetY - childSize.height;
        } else {
          final double normalizedTargetY = to.dy.clamp(margin, size.height - margin);
          final double edge = margin + childSize.height / 2.0;
          if (normalizedTargetY < edge) {
            y = margin;
          } else if (normalizedTargetY > size.height - edge) {
            y = size.height - margin - childSize.height;
          } else {
            y = normalizedTargetY - childSize.height / 2.0;
          }
        }
      }
    }
    _offset = Offset(x, y);
    return _offset!;
  }

  /// 读取leader的值
  void _readLeader() {
    if (layerLink.leader != null) {
      _target = _PopupOffset.linkOf(layerLink);
    }
  }

  @override
  bool shouldRelayout(_PopupPositionDelegate oldDelegate) {
    return layerLink != oldDelegate.layerLink || offset != oldDelegate.offset || placement != oldDelegate.placement || margin != oldDelegate.margin;
  }
}

/// 浮层内容对象
class _PopupOverlay extends StatefulWidget {
  const _PopupOverlay({
    Key? key,
    this.padding,
    this.margin,
    required this.animation,
    required this.offset,
    this.onEnter,
    this.onExit,
    this.onPointerDown,
    required this.layerLink,
    required this.popupWidget,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Animation<double> animation;

  /// 与组件之间的偏移量
  final double offset;
  final PointerDownEventListener? onPointerDown;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final LayerLink layerLink;
  final ValueNotifier<TPopup> popupWidget;

  @override
  State<_PopupOverlay> createState() => _PopupOverlayState();
}

class _PopupOverlayState extends State<_PopupOverlay> {
  late ValueNotifier<bool> _visible;

  @override
  void initState() {
    _visible = ValueNotifier(false);
    _updateIgnore();
    widget.animation.addListener(_updateIgnore);
    super.initState();
  }

  @override
  void dispose() {
    widget.animation.removeListener(_updateIgnore);
    super.dispose();
  }

  void _updateIgnore() {
    if (widget.animation.value > 0) {
      _visible.value = true;
    } else {
      _visible.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    // We create this widget outside of the overlay entry's builder to prevent
    // updated values from happening to leak into the overlay when the overlay
    // rebuilds.
    var colorScheme = theme.colorScheme;
    var popupShadow = theme.shadow2Inset;
    var popupTopArrowShadow = [theme.shadowInsetLeft, theme.shadowInsetBottom];
    // var popupLeftArrowShadow = [theme.shadowInsetLeft, theme.shadowInsetTop];
    // var popupBottomArrowShadow = [theme.shadowInsetTop, theme.shadowInsetRight];
    // var popupRightArrowShadow = [theme.shadowInsetRight, theme.shadowInsetBottom];

    // 当小部件完全不显示时，忽略所有事件
    return ValueListenableBuilder(
      builder: (BuildContext context, value, Widget? child) {
        Widget result = ValueListenableBuilder<bool>(
          builder: (BuildContext context, value, Widget? child) {
            return DefaultTextStyle(
              style: TextStyle(fontSize: ThemeDataConstant.fontSizeBase, fontFamily: theme.fontFamily),
              child: Visibility(
                visible: value,
                maintainState: true,
                child: child!,
              ),
            );
          },
          valueListenable: _visible,
          child: FadeTransition(
            opacity: widget.animation,
            child: Container(
              decoration: ShapeDecoration(
                color: colorScheme.bgColorContainer,
                shadows: [...popupShadow, ...popupTopArrowShadow],
                shape: BubbleShapeBorder(
                    arrowAngle: 6,
                    arrowHeight: 6,
                    direction: BubbleDirection.bottom,
                    radius: BorderRadius.circular(ThemeDataConstant.borderRadius),
                    position: const BubblePosition.end(8)),
              ),
              padding: widget.padding,
              child: widget.popupWidget.value.content ?? widget.popupWidget.value.builderContent?.call(context),
            ),
          ),
        );
        if (widget.onEnter != null || widget.onExit != null) {
          result = MouseRegion(
            onEnter: widget.onEnter,
            onExit: widget.onExit,
            child: result,
          );
        }
        if (widget.onPointerDown != null) {
          result = Listener(
            onPointerDown: widget.onPointerDown,
            child: result,
          );
        }

        return Positioned.fill(
          child: CustomSingleChildLayout(
            delegate: _PopupPositionDelegate(
              offset: widget.offset,
              placement: widget.popupWidget.value.placement,
              margin: 5.0,
              layerLink: widget.layerLink,
            ),
            child: result,
          ),
        );
      },
      valueListenable: widget.popupWidget,
    );
  }
}

/// 浮层偏移对象
class _PopupOffset {
  /// 上
  Offset top;

  /// 左
  Offset left;

  /// 右
  Offset right;

  /// 下
  Offset bottom;

  /// 上左
  Offset topLeft;

  /// 上右
  Offset topRight;

  /// 下左
  Offset bottomLeft;

  /// 下右
  Offset bottomRight;

  /// 左上
  Offset leftTop;

  /// 左下
  Offset leftBottom;

  /// 右上
  Offset rightTop;

  /// 右下
  Offset rightBottom;

  _PopupOffset({
    required this.top,
    required this.left,
    required this.right,
    required this.bottom,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
    required this.leftTop,
    required this.leftBottom,
    required this.rightTop,
    required this.rightBottom,
  });

  factory _PopupOffset.linkOf(LayerLink layerLink) {
    // 组件大小
    Size leaderSize = layerLink.leaderSize ?? const Size(0, 0);
    // 父坐标系中的位置
    var offset = layerLink.leader?.offset ?? const Offset(0, 0);
    final Offset top = leaderSize.topCenter(offset);
    final Offset left = leaderSize.centerLeft(offset);
    final Offset right = leaderSize.centerRight(offset);
    final Offset bottom = leaderSize.bottomCenter(offset);
    final Offset topLeft = leaderSize.topLeft(offset);
    final Offset topRight = leaderSize.topRight(offset);
    final Offset bottomLeft = leaderSize.bottomLeft(offset);
    final Offset bottomRight = leaderSize.bottomRight(offset);
    return _PopupOffset(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
      leftTop: topLeft,
      leftBottom: bottomLeft,
      rightTop: topRight,
      rightBottom: bottomRight,
    );
  }

  /// 根据浮层出现位置，返回相应的[Offset]
  Offset placement(TPopupPlacement placement) {
    switch (placement) {
      case TPopupPlacement.top:
        return top;
      case TPopupPlacement.left:
        return left;
      case TPopupPlacement.right:
        return right;
      case TPopupPlacement.bottom:
        return bottom;
      case TPopupPlacement.topLeft:
        return topLeft;
      case TPopupPlacement.topRight:
        return topRight;
      case TPopupPlacement.bottomLeft:
        return bottomLeft;
      case TPopupPlacement.bottomRight:
        return bottomRight;
      case TPopupPlacement.leftTop:
        return leftTop;
      case TPopupPlacement.leftBottom:
        return leftBottom;
      case TPopupPlacement.rightTop:
        return rightTop;
      case TPopupPlacement.rightBottom:
        return rightBottom;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _PopupOffset &&
          runtimeType == other.runtimeType &&
          top == other.top &&
          left == other.left &&
          right == other.right &&
          bottom == other.bottom &&
          topLeft == other.topLeft &&
          topRight == other.topRight &&
          bottomLeft == other.bottomLeft &&
          bottomRight == other.bottomRight &&
          leftTop == other.leftTop &&
          leftBottom == other.leftBottom &&
          rightTop == other.rightTop &&
          rightBottom == other.rightBottom;

  @override
  int get hashCode =>
      top.hashCode ^
      left.hashCode ^
      right.hashCode ^
      bottom.hashCode ^
      topLeft.hashCode ^
      topRight.hashCode ^
      bottomLeft.hashCode ^
      bottomRight.hashCode ^
      leftTop.hashCode ^
      leftBottom.hashCode ^
      rightTop.hashCode ^
      rightBottom.hashCode;
}
