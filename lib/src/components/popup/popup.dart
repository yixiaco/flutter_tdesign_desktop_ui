import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

part 'components/popup_overlay.dart';

part 'components/popup_position_delegate.dart';

part 'components/props.dart';

typedef PopupPositionCallback = void Function(bool isReverse);

/// 弹出层
/// 弹出层组件是其他弹窗类组件如气泡确认框实现的基础，当这些组件提供的能力不能满足定制需求时，可以在弹出层组件基础上封装
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
    this.destroyOnClose = true,
    this.builderContent,
    this.style,
  })  : assert(!(content != null && builderContent != null), 'content和builderContent只能给定一个'),
        assert(!(content == null && builderContent == null), 'content或builderContent不能为空'),
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
  final TCallback? onOpen;

  /// 关闭事件
  final TCallback? onClose;

  /// hover和focus时，显示的延迟
  final Duration showDuration;

  /// hover和focus时，隐藏的延迟
  final Duration hideDuration;

  /// 是否在关闭浮层时销毁浮层，默认为false.
  /// 因为一般不需要维护浮层内容的状态，这可以显著提升运行速度
  final bool destroyOnClose;

  /// 使用build创建浮层
  final WidgetBuilder? builderContent;

  /// 浮层样式
  final TPopupStyle? style;

  @override
  State<TPopup> createState() => TPopupState();
}

class TPopupState extends State<TPopup> with TickerProviderStateMixin {
  /// 显隐值
  ValueNotifier<bool>? _visible;

  /// 有效显隐值
  ValueNotifier<bool> get effectiveVisible => widget.visible ?? (_visible ??= ValueNotifier(false));

  /// 区域焦点节点
  FocusScopeNode? _node;

  /// 动画控制器
  late AnimationController _controller;

  /// 默认淡入持续时间
  static const Duration _fadeInDuration = Duration(milliseconds: 150);

  /// 默认淡出持续时间
  static const Duration _fadeOutDuration = Duration(milliseconds: 75);

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

  /// 弹出层key
  final GlobalKey<_PopupOverlayState> _overlayKey = GlobalKey();

  @override
  void initState() {
    _controller = AnimationController(
      duration: _fadeInDuration,
      reverseDuration: _fadeOutDuration,
      vsync: this,
    )..addStatusListener(_handleStatusChanged);

    effectiveVisible.addListener(_showHidePopup);
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
    if (event is PointerHoverEvent && widget.trigger.isTrue(hover: true)) {
      if (mounted) {
        var currentBox = context.findRenderObject() as RenderBox?;
        var box = _overlayKey.currentState?._containerKey.currentContext?.findRenderObject() as RenderBox?;
        if (box != null && currentBox != null) {
          var rect = box.localToGlobal(Offset.zero) & box.size;
          var currentRect = currentBox.localToGlobal(Offset.zero) & currentBox.size;
          if (rect.contains(event.position) || currentRect.contains(event.position)) {
            print('包含在坐标内');
          } else {
            _updateVisible(false);
          }
          print('rect:$rect,event:$event');
        }
      }
    }
    // 点击与右键监听鼠标松开事件
    if (event is PointerUpEvent && widget.trigger.isTrue(click: true, contextMenu: true)) {
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
    effectiveVisible.removeListener(_showHidePopup);
    _visible?.dispose();
    // 销毁浮层
    _removeEntry(force: true);
    super.dispose();
  }

  /// 判断[effectiveVisible.value]状态，显示和隐藏浮层
  void _showHidePopup({bool? immediately}) {
    immediately = immediately ?? widget.trigger != TPopupTrigger.hover;
    if (effectiveVisible.value) {
      _showPopup(immediately: immediately);
    } else {
      _hidePopup(immediately: immediately);
    }
  }

  /// 显示浮层
  void _showPopup({bool immediately = false}) {
    // focus类型不需要监听指针事件
    if (!_existGlobalPointerRoute && !widget.trigger.isTrue(focus: true)) {
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
        key: _overlayKey,
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
          // if (widget.trigger.isTrue(hover: true)) {
          //   _updateVisible(false);
          // }
        },
        animation: CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
        popupState: this,
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
    if (widget.onClose != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        widget.onClose?.call();
      });
    }
  }

  /// 更新显示状态
  void _updateVisible([bool? visible]) {
    effectiveVisible.value = visible ?? !effectiveVisible.value;
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
    if (widget.visible != oldWidget.visible) {
      (oldWidget.visible ?? _visible)?.removeListener(_showHidePopup);
      (widget.visible ?? _visible)?.addListener(_showHidePopup);
    }
    // 暂时先销毁浮层
    // _removeEntry(force: true);

    super.didUpdateWidget(oldWidget);
  }

  void _focusVisible() {
    if (_node!.hasFocus) {
      effectiveVisible.value = true;
    } else {
      effectiveVisible.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // 窗口变更时，通知到组件
    MediaQuery.of(context);
    // 在下一帧时，更新浮层
    if (_overlayKey.currentState != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted) {
          _overlayKey.currentState?.setState(() {});
        }
      });
    }
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
    return child;
  }
}
