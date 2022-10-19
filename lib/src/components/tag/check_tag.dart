import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 可选择标签
/// 标签有已选和未选两种状态，可以通过点击标签来切换。类似多选框的效果。
class TCheckTag extends StatefulWidget {
  const TCheckTag({
    Key? key,
    this.checked = false,
    required this.child,
    this.disabled = false,
    this.size,
    this.onChange,
    this.onClick,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  /// 标签选中的状态
  final bool checked;

  /// 子组件
  final Widget child;

  /// 标签禁用态
  final bool disabled;

  /// 标签尺寸
  final TComponentSize? size;

  /// 变更标签选中状态时触发
  final TValueChange<bool>? onChange;

  /// 点击标签时触发
  final void Function()? onClick;

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  @override
  State<TCheckTag> createState() => _TCheckTagState();
}

class _TCheckTagState extends State<TCheckTag> with TickerProviderStateMixin, TToggleableStateMixin {
  @override
  void handleTap([Intent? _]) {
    super.handleTap(_);
    widget.onClick?.call();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? theme.size;

    // 鼠标
    const effectiveMouseCursor = TMaterialStateMouseCursor.clickable;

    // 文本颜色
    var textColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return colorScheme.textColorAnti;
      }
      return null;
    });

    // 背景填充颜色
    final bgColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected) && states.contains(MaterialState.hovered)) {
        return colorScheme.brandColorHover;
      }
      if (states.contains(MaterialState.selected)) {
        return colorScheme.brandColor;
      }
      if (states.contains(MaterialState.hovered)) {
        return colorScheme.bgColorComponentHover;
      }
      return colorScheme.bgColorComponent;
    });

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: widget.checked,
      child: buildToggleable(
        mouseCursor: effectiveMouseCursor,
        child: AbsorbPointer(
          child: TTag(
            size: size,
            disabled: widget.disabled,
            backgroundColor: bgColor.resolve(states),
            textColor: textColor.resolve(states),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  ValueChanged<bool?>? get onChanged => (value) => widget.onChange?.call(value!);

  @override
  bool get tristate => false;

  @override
  bool? get value => widget.checked;

  @override
  bool get isInteractive => !widget.disabled;
}
