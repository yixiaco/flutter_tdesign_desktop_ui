import 'package:dartx/dartx.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';

/// 一个通用的按钮状态构建器
class TMaterialStateButton extends StatefulWidget {
  const TMaterialStateButton({
    Key? key,
    this.builder,
    this.child,
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
    this.onLongPressUp,
    this.onLongPressCancel,
    this.onHover,
    this.onFocusChange,
    this.actions,
    this.shortcuts,
    this.enableFeedback = true,
  })  : assert(child != null || builder != null),
        super(key: key);

  /// 是否禁用
  final bool disabled;

  /// 是否选中状态
  final bool selected;

  /// 选中状态下是否可以点击
  final bool selectedClick;

  /// 鼠标
  final MaterialStateProperty<MouseCursor?>? cursor;

  /// 子组件构建器
  final Widget Function(BuildContext context, Set<MaterialState> states)? builder;

  final Widget? child;

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

  /// 长按放开
  final GestureLongPressUpCallback? onLongPressUp;

  /// 长按取消
  final GestureLongPressCancelCallback? onLongPressCancel;

  /// 鼠标经过
  final ValueChanged<bool>? onHover;

  /// 聚焦变更
  final ValueChanged<bool>? onFocusChange;

  /// {@macro flutter.widgets.actions.actions}
  final Map<Type, Action<Intent>>? actions;

  /// {@macro flutter.widgets.shortcuts.shortcuts}
  final Map<ShortcutActivator, Intent>? shortcuts;

  /// 检测到的手势是否应该提供声音和/或触觉反馈。
  /// 例如，在Android上，当反馈功能被启用时，轻按会产生点击声，长按会产生短暂的震动。
  /// 通常组件的默认值是true
  final bool enableFeedback;

  @override
  State<TMaterialStateButton> createState() => _TMaterialStateButtonState();
}

class _TMaterialStateButtonState extends State<TMaterialStateButton> with MaterialStateMixin {
  @override
  void initState() {
    super.initState();
    setMaterialState(MaterialState.selected, widget.selected);
    setMaterialState(MaterialState.disabled, widget.disabled);
  }

  @override
  void didUpdateWidget(covariant TMaterialStateButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(MaterialState.disabled, widget.disabled);
    setMaterialState(MaterialState.selected, widget.selected);
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
    var effectiveCursor = TMaterialStateMouseCursor.clickable;

    return FocusableActionDetector(
      mouseCursor: widget.cursor?.resolve(materialStates) ?? effectiveCursor.resolve(materialStates),
      onShowFocusHighlight: (value) => setMaterialState(MaterialState.focused, value),
      onShowHoverHighlight: _handleHovered,
      onFocusChange: widget.onFocusChange,
      enabled: !widget.disabled,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      actions: widget.actions ?? activeMap(context),
      shortcuts: widget.shortcuts,
      child: GestureDetector(
        behavior: widget.behavior,
        onTap: _handleTap,
        onTapDown: (details) {
          _onTap(true);
          if (_isClick) widget.onTapDown?.call(details);
        },
        onTapUp: (details) {
          _onTap(false);
          widget.onTapUp?.call(details);
        },
        onTapCancel: () {
          _onTap(false);
          widget.onTapCancel?.call();
        },
        onLongPress: widget.onLongPress != null ? _handleLongPress : null,
        onLongPressUp: widget.onLongPressUp,
        onLongPressCancel: widget.onLongPressCancel,
        child: TMaterialStateScope(
          states: Set.unmodifiable(materialStates),
          child: Builder(
            builder: (context) {
              if(widget.child != null) {
                return widget.child!;
              }
              return widget.builder!(context, materialStates);
            },
          ),
        ),
      ),
    );
  }

  Map<Type, Action<Intent>> activeMap(BuildContext context) {
    final Map<Type, Action<Intent>> actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (intent) {
          _handleTap();
          context.findRenderObject()!.sendSemanticsEvent(const TapSemanticEvent());
          return null;
        },
      ),
    };
    return actionMap;
  }

  void _handleLongPress() {
    if (!_isClick) {
      return;
    }
    if (widget.onLongPress != null) {
      if (widget.enableFeedback) {
        Feedback.forLongPress(context);
      }
      widget.onLongPress?.call();
    }
  }

  void _handleHovered(value) {
    if (!_isClick && value) {
      return;
    }
    setMaterialState(MaterialState.hovered, value);
    widget.onHover?.call(value);
  }

  void _handleTap() {
    if (!_isClick) {
      return;
    }
    if (widget.onTap != null) {
      if (widget.enableFeedback) {
        Feedback.forTap(context);
      }
      widget.onTap?.call();
    }
  }

  void _onTap(bool tap) {
    if (!_isClick && tap) {
      return;
    }
    setMaterialState(MaterialState.pressed, tap);
  }
}

/// 对于包装在[TMaterialStateButton]下的组件可以使用[TMaterialStateScope.of]的方式获取状态值
class TMaterialStateScope extends InheritedWidget {
  const TMaterialStateScope({
    super.key,
    required super.child,
    required Set<MaterialState> states,
  }) : _states = states;

  final Set<MaterialState> _states;

  @override
  bool updateShouldNotify(TMaterialStateScope oldWidget) {
    return !_states.contentEquals(oldWidget._states);
  }

  /// 查询最近的MaterialState状态
  static Set<MaterialState>? of(BuildContext context) {
    final TMaterialStateScope? scope = context.dependOnInheritedWidgetOfExactType<TMaterialStateScope>();
    return scope?._states;
  }
}

abstract class TMaterialStateMouseCursor extends MouseCursor implements MaterialStateProperty<MouseCursor> {
  const TMaterialStateMouseCursor();
  @override
  MouseCursor resolve(Set<MaterialState> states);

  @protected
  @override
  MouseCursorSession createSession(int device) {
    return resolve(<MaterialState>{}).createSession(device);
  }

  /// A mouse cursor for clickable material widgets, which resolves differently
  /// when the widget is disabled.
  ///
  /// By default this cursor resolves to [SystemMouseCursors.click]. If the widget is
  /// disabled, the cursor resolves to [SystemMouseCursors.noDrop].
  ///
  /// This cursor is the default for many Material widgets.
  static const TMaterialStateMouseCursor clickable = _EnabledAndDisabledMouseCursor(
    enabledCursor: SystemMouseCursors.click,
    disabledCursor: SystemMouseCursors.noDrop,
    name: 'clickable',
  );

  /// A mouse cursor for material widgets related to text, which resolves differently
  /// when the widget is disabled.
  ///
  /// By default this cursor resolves to [SystemMouseCursors.text]. If the widget is
  /// disabled, the cursor resolves to [SystemMouseCursors.noDrop].
  ///
  /// This cursor is the default for many Material widgets.
  static const TMaterialStateMouseCursor textable = _EnabledAndDisabledMouseCursor(
    enabledCursor: SystemMouseCursors.text,
    disabledCursor: SystemMouseCursors.noDrop,
    name: 'textable',
  );
}

class _EnabledAndDisabledMouseCursor extends TMaterialStateMouseCursor {
  const _EnabledAndDisabledMouseCursor({
    required this.enabledCursor,
    required this.disabledCursor,
    required this.name,
  });

  final MouseCursor enabledCursor;
  final MouseCursor disabledCursor;
  final String name;

  @override
  MouseCursor resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return disabledCursor;
    }
    return enabledCursor;
  }

  @override
  String get debugDescription => 'MaterialStateMouseCursor($name)';
}