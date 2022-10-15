import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

abstract class MaterialStateWidget extends Widget implements MaterialStateProperty<Widget> {
  const MaterialStateWidget({super.key});

  static MaterialStateWidget resolveWith(MaterialPropertyResolver<Widget> callback) => _MaterialStateWidget(callback);

  @override
  Widget resolve(Set<MaterialState> states);
}

class _MaterialStateWidget extends MaterialStateWidget {
  const _MaterialStateWidget(this._resolve) : super();
  final MaterialPropertyResolver<Widget> _resolve;

  @override
  Widget resolve(Set<MaterialState> states) => _resolve(states);

  @override
  Element createElement() {
    throw UnimplementedError();
  }
}

/// 一个通用的状态构建器
class TMaterialStateBuilder extends StatefulWidget {
  const TMaterialStateBuilder({
    Key? key,
    required this.builder,
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
  }) : super(key: key);

  /// 是否禁用
  final bool disabled;

  /// 是否选中状态
  final bool selected;

  /// 选中状态下是否可以点击
  final bool selectedClick;

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
    var effectiveCursor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    return FocusableActionDetector(
      mouseCursor: widget.cursor?.resolve(materialStates) ?? effectiveCursor.resolve(materialStates),
      onShowFocusHighlight: (value) => setMaterialState(MaterialState.focused, value),
      onShowHoverHighlight: _handleHovered,
      onFocusChange: widget.onFocusChange,
      enabled: !widget.disabled,
      autofocus: widget.autofocus,
      focusNode: widget.focusNode,
      actions: widget.actions,
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
        child: widget.builder(context, materialStates),
      ),
    );
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
