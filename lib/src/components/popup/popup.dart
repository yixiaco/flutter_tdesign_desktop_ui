import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

part 'components/popup_level_notifier.dart';

part 'components/popup_overlay.dart';

part 'components/popup_position_delegate.dart';

part 'components/type.dart';

typedef PopupPositionCallback = void Function(bool isReverse);

/// 弹出层
/// 弹出层组件是其他弹窗类组件如气泡确认框实现的基础，当这些组件提供的能力不能满足定制需求时，可以在弹出层组件基础上封装
class TPopup extends StatefulWidget {
  const TPopup({
    super.key,
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
    this.hideEmptyPopup = false,
    this.style,
  });

  /// 浮层出现位置
  final TPopupPlacement placement;

  /// 触发浮层出现的方式。可选项：hover/click/focus/contextMenu
  final TPopupTrigger trigger;

  /// 是否显示浮层箭头
  final bool showArrow;

  /// 是否禁用组件
  final bool disabled;

  /// 是否显示浮层,默认为false,当你需要手动控制它时，你应该传输一个[TPopupVisible]
  final TPopupVisible? visible;

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

  /// 浮层是否隐藏空内容，默认不隐藏
  final bool hideEmptyPopup;

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

  /// 焦点节点
  final FocusNode _node = FocusNode();
  final FocusScopeNode _popupScopeNode = FocusScopeNode(skipTraversal: true);

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

  /// 是否存在全局指针路由事件
  bool _existGlobalPointerRoute = false;

  /// 弹出层key
  final GlobalKey<_PopupOverlayState> _overlayKey = GlobalKey();

  _PopupLevel? _popupLevel;

  late Map<Type, Action<Intent>> actions = <Type, Action<Intent>>{
    DismissIntent: _DismissModalAction(() {
      _node.unfocus();
      _popupScopeNode.unfocus();
      _updateVisible(false);
    }),
  };

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
    _node.addListener(_focusVisible);
    _popupScopeNode.addListener(_focusVisible);
    super.initState();
  }

  /// 全局指针路由监听
  void _globalPointerRoute(event) {
    if (event is PointerHoverEvent && widget.trigger.isTrue(hover: true)) {
      _handlePointerBounds(event);
    }
    // 通知、点击与右键监听鼠标松开事件
    else if (event is PointerUpEvent && widget.trigger.isTrue(click: true, contextMenu: true, notifier: true)) {
      // 先检查子浮层的事件
      var popupOverlayState = _overlayKey.currentState;
      if (popupOverlayState != null) {
        var set = popupOverlayState.levelNotifier.children;
        for (var child in set) {
          child.currentState?.widget.popupState._globalPointerRoute(event);
        }
      }
      // 检查当前浮层的事件,处理鼠标越界时隐藏
      _handlePointerBounds(event);
    } else if (event is PointerUpEvent && widget.trigger.isTrue(focus: true)) {
      _handlePointerBounds(event);
    }
  }

  /// 处理鼠标越界时隐藏
  void _handlePointerBounds(PointerEvent event) {
    if (mounted) {
      var currentBox = context.findRenderObject() as RenderBox?;
      var box = _overlayKey.currentState?._containerKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null && currentBox != null) {
        var rect = box.localToGlobal(Offset.zero) & box.size;
        var currentRect = currentBox.localToGlobal(Offset.zero) & currentBox.size;
        if (!rect.contains(event.position) && !currentRect.contains(event.position)) {
          if (_overlayKey.currentState!.levelNotifier.children.isEmpty) {
            _updateVisible(false);
          }
        }
      }
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
    // 销毁浮层
    _removeEntry(force: true);
    effectiveVisible.removeListener(_showHidePopup);
    _visible?.dispose();
    _controller.dispose();
    _node.dispose();
    _popupScopeNode.dispose();
    _showTimer?.cancel();
    _hideTimer?.cancel();
    super.dispose();
  }

  /// 判断[effectiveVisible.formItemValue]状态，显示和隐藏浮层
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
    if (!_existGlobalPointerRoute) {
      // 监听全局指针事件，这样我们可以在单击其他控件时立即隐藏浮层。
      GestureBinding.instance.pointerRouter.addGlobalRoute(_globalPointerRoute);
      _existGlobalPointerRoute = true;
    }
    _showTimer?.cancel();
    _showTimer = null;
    assert(widget.content != null || widget.hideEmptyPopup);
    if (widget.content == null && widget.hideEmptyPopup) {
      effectiveVisible.value = false;
      return;
    }
    if (_entry == null) {
      _createEntry();
    }
    _popupLevel?.popupLevel.addOverlay(_overlayKey);
    widget.onOpen?.call();
    _controller.forward();
  }

  /// 浮层不可见.不应该直接使用这个方法，而是使用[_hidePopup]
  void _reverseVisible() {
    if (_entry != null) {
      _popupLevel?.popupLevel.removeOverlay(_overlayKey);
      widget.onClose?.call();
    }
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
        focusScopeNode: _popupScopeNode,
        onEnter: (_) {
          if (widget.trigger.isTrue(hover: true)) {
            if (!_controller.isDismissed) _updateVisible(true);
          }
        },
        animation: CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
        popupState: this,
        onRemove: () => _removeEntry(force: true),
      );
      return Actions(
        actions: actions,
        child: child,
      );
    });
    overlayState.insert(_entry!);
  }

  /// 销毁浮层对象.不应该直接使用这个方法，而是使用[_hidePopup]
  void _removeEntry({bool force = false}) {
    if (_node.hasFocus) {
      _node.unfocus();
    }
    if (_popupScopeNode.hasFocus) {
      _popupScopeNode.unfocus();
    }
    if (_existGlobalPointerRoute) {
      // 移除监听全局指针事件
      GestureBinding.instance.pointerRouter.removeGlobalRoute(_globalPointerRoute);
      _existGlobalPointerRoute = false;
    }
    _popupLevel?.popupLevel.removeOverlay(_overlayKey);
    // 是否销毁
    if (widget.destroyOnClose || force) {
      _entry?.remove();
      _entry = null;
    }
  }

  /// 更新显示状态
  void _updateVisible([bool? visible]) {
    effectiveVisible.value = visible ?? !effectiveVisible.value;
  }

  @override
  void didUpdateWidget(TPopup oldWidget) {
    if (widget.visible != oldWidget.visible) {
      (oldWidget.visible ?? _visible)?.removeListener(_showHidePopup);
      (widget.visible ?? _visible)?.addListener(_showHidePopup);
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _popupLevel = _PopupLevel.of(context);
  }

  void _focusVisible() {
    if (widget.trigger == TPopupTrigger.focus) {
      if (_node.hasFocus || _popupScopeNode.hasFocus) {
        effectiveVisible.value = true;
      } else {
        effectiveVisible.value = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (widget.disabled) {
      return child;
    }
    _notifyPopupUpdate();
    switch (widget.trigger) {
      case TPopupTrigger.hover:
        child = MouseRegion(
          hitTestBehavior: HitTestBehavior.translucent,
          onEnter: (event) => _updateVisible(true),
          onExit: (event) => _updateVisible(false),
          child: widget.child,
        );
        break;
      case TPopupTrigger.click:
        child = AllowTapListener(
          onTap: () => _updateVisible(),
          child: widget.child,
        );
        break;
      case TPopupTrigger.contextMenu:
        child = AllowTapListener(
          onSecondaryTap: () => _updateVisible(),
          child: widget.child,
        );
        break;
      case TPopupTrigger.notifier:
        child = NotificationListener<TPopupNotification>(
          onNotification: (notification) {
            _updateVisible();
            return true;
          },
          child: widget.child,
        );
        break;
      case TPopupTrigger.focus:
        break;
      case TPopupTrigger.none:
        break;
    }
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        _notifyPopupUpdate();
        return false;
      },
      child: SizeChangedLayoutNotifier(
        child: Actions(
          actions: actions,
          child: Focus(
            focusNode: _node,
            child: RepaintBoundary(
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  /// 当布局变更时，通知到浮层
  void _notifyPopupUpdate() {
    // 在下一帧时，更新浮层
    if (_overlayKey.currentState != null) {
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        if (mounted && (_overlayKey.currentState?.mounted ?? false)) {
          _overlayKey.currentState?.setState(() {});
        }
      });
    }
  }
}

class _DismissModalAction extends DismissAction {
  _DismissModalAction(this.callback);

  final VoidCallback callback;

  @override
  Object? invoke(DismissIntent intent) {
    callback();
    return null;
  }
}
