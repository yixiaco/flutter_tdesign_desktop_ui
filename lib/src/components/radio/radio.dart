import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 单选框
class TRadio<T> extends StatefulWidget {
  const TRadio({
    Key? key,
    this.allowUncheck = false,
    this.checked,
    this.disabled = false,
    this.label,
    this.value,
    this.onChange,
    this.onClick,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  /// 是否允许取消选中
  final bool allowUncheck;

  /// 是否选中
  final bool? checked;

  /// 是否为禁用态
  final bool disabled;

  /// 主文案
  final Widget? label;

  /// 单选按钮的值
  final T? value;

  /// 选中状态变化时触发
  final TRadioChange<T>? onChange;

  /// 点击时触发
  final TCallback? onClick;

  final FocusNode? focusNode;

  final bool autofocus;

  @override
  State<TRadio<T>> createState() => _TRadioState<T>();
}

class _TRadioState<T> extends State<TRadio<T>> with TickerProviderStateMixin, TToggleableStateMixin {
  final _TRadioPinter _painter = _TRadioPinter();

  @override
  Duration get toggleDuration => ThemeDataConstant.animDurationBase;

  @override
  CurvedAnimation get position => _position;
  late CurvedAnimation _position;

  @override
  void initState() {
    super.initState();
    _position = CurvedAnimation(
      parent: positionController,
      curve: ThemeDataConstant.animTimeFnEaseOut,
      reverseCurve: ThemeDataConstant.animTimeFnEaseOut.flipped,
    );
  }

  @override
  void didUpdateWidget(covariant TRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.checked != oldWidget.checked) {
      animateToValue();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    // 鼠标
    final effectiveMouseCursor = MaterialStateProperty.resolveWith<MouseCursor>((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    // 选中颜色
    var checkColor = MaterialStateProperty.resolveWith((states) {
      Color color = colorScheme.brandColor;
      if (states.contains(MaterialState.disabled)) {
        color = colorScheme.textColorDisabled;
      }
      return color;
    });

    // 背景填充颜色
    final bgColor = MaterialStateProperty.resolveWith((states) {
      Color color = colorScheme.bgColorContainer;
      if (states.contains(MaterialState.disabled)) {
        color = colorScheme.bgColorComponentDisabled;
      }
      return color;
    });

    // 边框颜色
    final borderColor = MaterialStateProperty.resolveWith((states) {
      Color color = widget.checked != null && widget.checked! ? colorScheme.brandColor : colorScheme.borderLevel2Color;
      if (states.contains(MaterialState.hovered)) {
        color = colorScheme.brandColor;
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        color = colorScheme.brandColor;
      }
      if (states.contains(MaterialState.disabled)) {
        color = colorScheme.borderLevel2Color;
      }
      return color;
    });

    Widget? label = widget.label;
    if (label != null) {
      label = Padding(
        padding: EdgeInsets.symmetric(horizontal: ThemeDataConstant.spacer),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: ThemeDataConstant.fontSizeBase,
            color: widget.disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
          ),
          child: label,
        ),
      );
    }

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: widget.checked,
      child: FocusableActionDetector(
        actions: actionMap,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enabled: isInteractive,
        onShowFocusHighlight: handleFocusHighlightChanged,
        onShowHoverHighlight: handleHoverChanged,
        mouseCursor: effectiveMouseCursor.resolve(states),
        child: GestureDetector(
          excludeFromSemantics: !isInteractive,
          onTapDown: handleTapDown,
          onTap: handleTap,
          onTapUp: handleTapEnd,
          onTapCancel: handleTapEnd,
          child: Semantics(
            enabled: isInteractive,
            child: SizedBox(
              height: 22,
              child: TSpace(
                spacing: 0,
                crossAxisAlignment: CrossAxisAlignment.center,
                breakLine: false,
                children: [
                  CustomPaint(
                    size: const Size.square(18),
                    painter: _painter
                      ..position = position
                      ..reaction = reaction
                      ..reactionFocusFade = reactionFocusFade
                      ..reactionHoverFade = reactionHoverFade
                      ..downPosition = downPosition
                      ..isFocused = isFocused
                      ..isHovered = isHovered
                      ..checkColor = checkColor.resolve(states)
                      ..backgroundColor = bgColor.resolve(states)
                      ..borderColor = borderColor.resolve(states),
                  ),
                  label,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ValueChanged<bool?>? get onChanged => (value) => widget.onChange?.call(value, widget.value);

  /// 果为 true，则value可以为 true、false 或 null，否则value必须为 true 或 false。
  /// 当tristate为 true 且value为 null 时，控件被认为处于其第三个或“不确定”状态
  @override
  bool get tristate => widget.allowUncheck;

  @override
  bool? get value => widget.checked;

  @override
  bool get isInteractive => !widget.disabled;
}

class _TRadioPinter extends ToggleablePainter {
  // 选中颜色
  Color get checkColor => _checkColor!;
  Color? _checkColor;

  set checkColor(Color value) {
    if (_checkColor == value) {
      return;
    }
    _checkColor = value;
    notifyListeners();
  }

  // 边框颜色
  Color get borderColor => _borderColor!;
  Color? _borderColor;

  set borderColor(Color value) {
    if (_borderColor == value) {
      return;
    }
    _borderColor = value;
    notifyListeners();
  }

  /// 背景颜色
  Color get backgroundColor => _backgroundColor!;
  Color? _backgroundColor;

  set backgroundColor(Color value) {
    if (_backgroundColor == value) {
      return;
    }
    _backgroundColor = value;
    notifyListeners();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = (Offset.zero & size).center;

    var width = size.width - 2;

    // Background circle
    final Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;
    canvas.drawCircle(center, width / 2, paint);

    // Outer circle
    paint.color = borderColor;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(center, width / 2, paint);

    // Inner circle
    if (!position.isDismissed) {
      var opacity = checkColor.opacity;
      paint.style = PaintingStyle.fill;
      paint.color = checkColor.withOpacity(opacity * position.value);
      canvas.drawCircle(center, width / 4, paint);
    }
  }
}
