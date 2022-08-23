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
  }) : super(key: key);

  /// 是否禁用
  final bool disabled;

  /// 是否选中状态
  final bool selected;

  /// 鼠标
  final MaterialStateProperty<MouseCursor>? cursor;

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
      onShowHoverHighlight: (value) => setMaterialState(MaterialState.hovered, value),
      enabled: !widget.disabled,
      child: GestureDetector(
        behavior: widget.behavior,
        onTap: () {
          _onTap(true);
          widget.onTap?.call();
        },
        onTapCancel: () => _onTap(false),
        onTapUp: (details) => _onTap(false),
        child: widget.builder(context, materialStates),
      ),
    );
  }

  void _onTap(bool tap) {
    if (widget.disabled) {
      return;
    }
    setMaterialState(MaterialState.pressed, tap);
  }
}
