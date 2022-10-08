import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 开关组件
/// 用于两个互斥选项，用来打开或关闭选项的选择控件
class TSwitch<T> extends StatefulWidget {
  const TSwitch({
    Key? key,
    required this.value,
    this.disabled = false,
    this.checkLabel,
    this.uncheckLabel,
    this.checkValue,
    this.uncheckValue,
    this.loading = false,
    this.size,
    this.onChange,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  /// 开关值, 可选[bool]、[checkValue]、[uncheckValue]
  final dynamic value;

  /// 是否禁用组件
  final bool disabled;

  /// 打开时的标签
  final Widget? checkLabel;

  /// 关闭时的标签
  final Widget? uncheckLabel;

  /// 选中时的值，默认为true
  final T? checkValue;

  /// 关闭时的值，默认为false
  final T? uncheckValue;

  /// 是否处于加载中状态
  final bool loading;

  /// 开关尺寸。
  final TComponentSize? size;

  /// 数据发生变化时触发
  final void Function(dynamic value)? onChange;

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  @override
  State<TSwitch<T>> createState() => _TSwitchState<T>();
}

class _TSwitchState<T> extends State<TSwitch<T>> with TickerProviderStateMixin, TToggleableStateMixin {
  @override
  Duration get toggleDuration => TVar.animDurationBase;

  @override
  CurvedAnimation get position => _position;
  late CurvedAnimation _position;

  @override
  void initState() {
    super.initState();
    _position = CurvedAnimation(
      parent: positionController,
      curve: TVar.animTimeFnEasing,
      reverseCurve: TVar.animTimeFnEasing.flipped,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _position.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var size = widget.size ?? theme.size;
    double minWidth = size.sizeOf(small: 28, medium: 36, large: 44);
    double height = size.sizeOf(small: 16, medium: 20, large: 24);
    double borderWidth = size.sizeOf(small: 2, medium: 2, large: 2);

    // 鼠标
    final effectiveMouseCursor = MaterialStateProperty.resolveWith<MouseCursor>((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    /// 选中颜色
    var checkColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.brandColorDisabled;
        } else if (widget.loading) {
          return colorScheme.brandColorFocus;
        } else {
          return colorScheme.brandColor;
        }
      } else {
        if (widget.loading) {
          return colorScheme.bgColorPage;
        } else if (states.contains(MaterialState.disabled)) {
          return colorScheme.bgColorComponentDisabled;
        } else {
          return colorScheme.gray5;
        }
      }
    });

    var handleOffset = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        return 4 + borderWidth;
      }
      return 0;
    });

    /// 选择标签
    Widget? label;
    if (value!) {
      label = widget.checkLabel;
    } else {
      label = widget.uncheckLabel;
    }
    if (widget.checkLabel != null || widget.uncheckLabel != null) {
      label ??= Container();
      double left = minWidth / 2 + 2;
      double right = size.sizeOf(small: 5, medium: 6, large: 8);
      label = IconTheme(
        data: IconThemeData(
          color: colorScheme.textColorAnti,
          size: theme.fontData.fontSizeL,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            fontFamily: theme.fontFamily,
            fontSize: size.sizeOf(
              small: 9,
              medium: theme.fontData.fontSizeS,
              large: theme.fontData.fontSizeS,
            ),
            color: colorScheme.textColorAnti,
          ),
          child: AnimatedOpacity(
            opacity: isPressed ? 0 : 1,
            duration: TVar.animDurationBase,
            child: AnimatedPadding(
              duration: TVar.animDurationBase,
              curve: TVar.animTimeFnEasing,
              padding: EdgeInsets.only(
                left: value! ? right : left,
                right: value! ? left : right,
              ),
              child: label,
            ),
          ),
        ),
      );
    }

    // 加载中...
    Widget? loading;
    if (widget.loading) {
      loading = const TLoading(size: TComponentSize.small);
    }

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: value,
      child: buildToggleable(
        mouseCursor: effectiveMouseCursor,
        child: Stack(
          children: [
            // 底部
            UnconstrainedBox(
              child: AnimatedContainer(
                constraints: BoxConstraints(
                  minWidth: minWidth,
                  minHeight: height,
                  maxHeight: height,
                ),
                duration: TVar.animDurationBase,
                curve: TVar.animTimeFnEaseOut,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / 2),
                  color: checkColor.resolve(states),
                ),
                child: label,
              ),
            ),
            // 滑块
            Positioned.fill(
              left: borderWidth,
              right: borderWidth,
              child: AnimatedAlign(
                alignment: value! ? Alignment.centerRight : Alignment.centerLeft,
                duration: TVar.animDurationBase,
                curve: TVar.animTimeFnEasing,
                child: AnimatedContainer(
                  width: height - 2 * borderWidth + handleOffset.resolve(states),
                  height: height - 2 * borderWidth,
                  duration: TVar.animDurationBase,
                  curve: TVar.animTimeFnEasing,
                  decoration: BoxDecoration(
                    color: colorScheme.textColorAnti,
                    borderRadius: BorderRadius.circular(TVar.borderRadiusExtraLarge),
                  ),
                  child: loading,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ValueChanged<bool?>? get onChanged => (value) => widget.onChange?.call(value! ? widget.checkValue ?? value : widget.uncheckValue ?? value);

  @override
  bool get tristate => false;

  @override
  bool? get value => widget.value == widget.checkValue || widget.value == true;

  @override
  bool get isInteractive => !widget.disabled && !widget.loading;
}
