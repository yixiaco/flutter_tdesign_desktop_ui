import 'package:flutter/material.dart';

/// 一个通用的状态构建器
class TMaterialStateBuilder extends StatefulWidget {
  const TMaterialStateBuilder({
    Key? key,
    required this.builder,
    this.disabled = false,
    this.selected = false,
    this.cursor,
    this.focusNode,
    this.autofocus = false,
    this.behavior = HitTestBehavior.translucent,
    this.onTap,
    this.onTapUp,
    this.onTapCancel,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.actions,
    this.shortcuts,
    this.enableFeedback = true,
  }) : super(key: key);

  /// 是否禁用
  final bool disabled;

  /// 是否选中状态
  final bool selected;

  /// 鼠标
  final MaterialStateProperty<MouseCursor?>? cursor;

  /// 子组件构建器
  final Widget Function(BuildContext context, Set<MaterialState> states) builder;

  /// 焦点
  final FocusNode? focusNode;

  /// 是否自动聚焦
  final bool autofocus;

  /// 在命中测试期间的行为。
  final HitTestBehavior? behavior;

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 取消点击回调
  final GestureTapCancelCallback? onTapCancel;

  /// 松开点击回调
  final GestureTapUpCallback? onTapUp;

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

  /// 检测到的手势是否应该提供声音和/或触觉反馈。
  /// 例如，在Android上，当反馈功能被启用时，轻按会产生点击声，长按会产生短暂的震动。
  /// 通常组件的默认值是true
  final bool enableFeedback;

  @override
  State<TMaterialStateBuilder> createState() => _TMaterialStateBuilderState();
}

class _TMaterialStateBuilderState extends State<TMaterialStateBuilder> with MaterialStateMixin {
  @override
  void initState() {
    super.initState();
    setMaterialState(MaterialState.selected, widget.selected);
    setMaterialState(MaterialState.disabled, widget.disabled);
  }

  @override
  void didUpdateWidget(covariant TMaterialStateBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(MaterialState.disabled, widget.disabled);
    setMaterialState(MaterialState.selected, widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    var effectiveCursor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    return FocusableActionDetector(
      mouseCursor: widget.cursor?.resolve(materialStates) ?? effectiveCursor.resolve(materialStates),
      onShowFocusHighlight: (value) => setMaterialState(MaterialState.focused, value),
      onShowHoverHighlight: _handleHoved,
      onFocusChange: widget.onFocusChange,
      enabled: !widget.disabled,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      actions: widget.actions,
      shortcuts: widget.shortcuts,
      child: GestureDetector(
        behavior: widget.behavior,
        onTap: () {
          _onTap(true);
        },
        onLongPress: _handleLongPress,
        onTapCancel: () {
          _onTap(false);
          widget.onTapCancel?.call();
        },
        onTapUp: (details) {
          _onTap(false);
          widget.onTapUp?.call(details);
        },
        child: widget.builder(context, materialStates),
      ),
    );
  }

  void _handleLongPress() {
    if (widget.onLongPress != null) {
      if (widget.enableFeedback) {
        Feedback.forLongPress(context);
      }
      widget.onLongPress?.call();
    }
  }

  void _handleHoved(value) {
    setMaterialState(MaterialState.hovered, value);
    widget.onHover?.call(value);
  }

  void _onTap(bool tap) {
    if (widget.disabled) {
      return;
    }
    if (widget.onTap != null && tap) {
      if (widget.enableFeedback) {
        Feedback.forTap(context);
      }
      widget.onTap?.call();
    }
    setMaterialState(MaterialState.pressed, tap);
  }
}
