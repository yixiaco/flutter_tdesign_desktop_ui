import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
  }) : super(key: key);

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

  /// 当[trigger]为focus时,传入焦点有助于帮助管理焦点的监听。
  /// 如果[child]是一个[ButtonStyleButton]、[TextField]、[EditableText]
  // final FocusNode? focusNode;

  /// 保存所有弹出层
  static final List<TPopupState> _popups = [];

  /// 关闭其他弹出层
  static void closeOtherPopup(TPopupState current) {
    if (_popups.isNotEmpty) {
      // Avoid concurrent modification.
      final List<TPopupState> popups = _popups.toList();
      for (final TPopupState state in popups) {
        if (state == current) {
          continue;
        }
      }
    }
  }

  @override
  State<TPopup> createState() => TPopupState();
}

class TPopupState extends State<TPopup> with TickerProviderStateMixin {
  /// 显隐值
  late ValueNotifier<bool> visible;

  /// 区域焦点节点
  late FocusScopeNode node;

  /// 动画控制器
  late AnimationController _controller;

  /// 默认淡入持续时间
  static const Duration _fadeInDuration = Duration(milliseconds: 150);

  /// 默认淡出持续时间
  static const Duration _fadeOutDuration = Duration(milliseconds: 75);

  /// 默认垂直偏移
  static const double _defaultVerticalOffset = 6.0;
  static const bool _defaultPreferBelow = true;

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
      node = FocusScopeNode();
      node.addListener(() {
        if (node.hasFocus) {
          visible.value = true;
        } else {
          visible.value = false;
        }
      });
    }
    super.initState();
  }

  /// 全局指针路由监听
  void _globalPointerRoute(event) {
    if (event is PointerUpEvent) {
      if (!_stopPropagation) {
        _hidePopup(immediately: true);
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
  void _showHidePopup() {
    var immediately = widget.trigger != TPopupTrigger.hover;
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
    visible.value = true;
    _hideTimer?.cancel();
    _hideTimer = null;
    if (immediately) {
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
    visible.value = false;
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
    _controller.forward();
  }

  /// 浮层不可见.不应该直接使用这个方法，而是使用[_hidePopup]
  void _reverseVisible() {
    _controller.reverse();
  }

  /// 创建浮层对象，以及立即插入浮层.不应该直接使用这个方法，而是使用[_showPopup]
  void _createEntry() {
    var theme = TTheme.of(context);
    final OverlayState overlayState = Overlay.of(
      context,
      debugRequiredFor: widget,
    )!;
    final RenderBox box = context.findRenderObject()! as RenderBox;
    final Offset target = box.localToGlobal(
      box.size.bottomCenter(Offset.zero),
      ancestor: overlayState.context.findRenderObject(),
    );

    // We create this widget outside of the overlay entry's builder to prevent
    // updated values from happening to leak into the overlay when the overlay
    // rebuilds.
    var colorScheme = theme.colorScheme;
    var popupShadow = theme.shadow2Inset;
    // var popupTopArrowShadow = [theme.shadowInsetLeft, theme.shadowInsetBottom];
    // var popupLeftArrowShadow = [theme.shadowInsetLeft, theme.shadowInsetTop];
    // var popupBottomArrowShadow = [theme.shadowInsetTop, theme.shadowInsetRight];
    // var popupRightArrowShadow = [theme.shadowInsetRight, theme.shadowInsetBottom];

    _entry = OverlayEntry(builder: (BuildContext context) {
      return _PopupOverlay(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: spacer),
        onPointerDown: widget.trigger.isTrue(click: true, contextMenu: true) ? (event) => _stopPropagation = true : null,
        // margin: _margin,
        onEnter: widget.trigger.isTrue(hover: true)
            ? (_) {
                if (!_controller.isDismissed) _showPopup(immediately: true);
              }
            : null,
        onExit: widget.trigger.isTrue(hover: true) ? (_) => _hidePopup() : null,
        animation: CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
        decoration: BoxDecoration(
          color: colorScheme.bgColorContainer,
          boxShadow: popupShadow,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        target: target,
        verticalOffset: _defaultVerticalOffset,
        preferBelow: _defaultPreferBelow,
        child: widget.content,
      );
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
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (widget.trigger == TPopupTrigger.hover) {
      child = MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (event) => visible.value = true,
        onExit: (event) => visible.value = false,
        child: widget.child,
      );
    } else if (widget.trigger == TPopupTrigger.click) {
      child = AllowTapListener(
        onTap: () => visible.value = !visible.value,
        child: widget.child,
      );
    } else if (widget.trigger == TPopupTrigger.contextMenu) {
      child = AllowTapListener(
        onSecondaryTap: () => visible.value = !visible.value,
        child: widget.child,
      );
    } else if (widget.trigger == TPopupTrigger.focus) {
      child = FocusScope(
        node: node,
        child: widget.child,
      );
    }
    return child;
  }
}

/// A delegate for computing the layout of a tooltip to be displayed above or
/// bellow a target specified in the global coordinate system.
class _PopupPositionDelegate extends SingleChildLayoutDelegate {
  /// Creates a delegate for computing the layout of a tooltip.
  ///
  /// The arguments must not be null.
  _PopupPositionDelegate({
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
  });

  /// The offset of the target the tooltip is positioned near in the global
  /// coordinate system.
  final Offset target;

  /// The amount of vertical distance between the target and the displayed
  /// tooltip.
  final double verticalOffset;

  /// Whether the tooltip is displayed below its widget by default.
  ///
  /// If there is insufficient space to display the tooltip in the preferred
  /// direction, the tooltip will be displayed in the opposite direction.
  final bool preferBelow;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
  }

  @override
  bool shouldRelayout(_PopupPositionDelegate oldDelegate) {
    return target != oldDelegate.target || verticalOffset != oldDelegate.verticalOffset || preferBelow != oldDelegate.preferBelow;
  }
}

class _PopupOverlay extends StatefulWidget {
  const _PopupOverlay({
    Key? key,
    this.padding,
    this.margin,
    required this.animation,
    required this.target,
    required this.verticalOffset,
    required this.preferBelow,
    this.onEnter,
    this.onExit,
    this.child,
    this.decoration,
    this.onPointerDown,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final Animation<double> animation;
  final Offset target;
  final double verticalOffset;
  final bool preferBelow;
  final PointerDownEventListener? onPointerDown;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final Widget? child;

  @override
  State<_PopupOverlay> createState() => _PopupOverlayState();
}

class _PopupOverlayState extends State<_PopupOverlay> {
  late ValueNotifier<bool> visible;

  @override
  void initState() {
    visible = ValueNotifier(false);
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
      visible.value = true;
    } else {
      visible.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    Widget result = ValueListenableBuilder<bool>(
      builder: (BuildContext context, value, Widget? child) {
        return DefaultTextStyle(
          style: TextStyle(fontSize: fontSizeBase, fontFamily: theme.fontFamily),
          child: Visibility(
            visible: value,
            maintainState: true,
            child: child ?? Container(),
          ),
        );
      },
      valueListenable: visible,
      child: FadeTransition(
        opacity: widget.animation,
        child: Container(
          decoration: widget.decoration,
          padding: widget.padding,
          margin: widget.margin,
          child: widget.child,
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

    // 当小部件完全不显示时，忽略所有事件
    return Positioned.fill(
      child: CustomSingleChildLayout(
        delegate: _PopupPositionDelegate(
          target: widget.target,
          verticalOffset: widget.verticalOffset,
          preferBelow: widget.preferBelow,
        ),
        child: result,
      ),
    );
  }
}
