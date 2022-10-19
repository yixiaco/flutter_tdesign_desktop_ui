import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 单选框
/// 单选框代表从一组互斥的选项中仅选择一个选项。
class TRadio<T> extends TFormItemValidate {
  const TRadio({
    Key? key,
    String? name,
    FocusNode? focusNode,
    this.allowUncheck = false,
    this.checked,
    this.defaultChecked,
    this.disabled = false,
    this.label,
    this.value,
    this.onChange,
    this.onClick,
    this.autofocus = false,
  }) : super(key: key, name: name, focusNode: focusNode);

  /// 是否允许取消选中
  final bool allowUncheck;

  /// 是否选中
  final bool? checked;

  /// 是否选中。非受控属性
  final bool? defaultChecked;

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

  /// 自动聚焦
  final bool autofocus;

  @override
  TFormItemValidateState<TRadio<T>> createState() => _TRadioState<T>();
}

class _TRadioState<T> extends TFormItemValidateState<TRadio<T>> with TickerProviderStateMixin, TToggleableStateMixin {
  final _TRadioPinter _painter = _TRadioPinter();

  bool? _checked;

  bool get checked => _checked ?? false;

  @override
  Duration get toggleDuration => TVar.animDurationBase;

  @override
  CurvedAnimation get position => _position;
  late CurvedAnimation _position;

  @override
  void initState() {
    _checked = widget.checked ?? widget.defaultChecked;
    super.initState();
    _position = CurvedAnimation(
      parent: positionController,
      curve: TVar.animTimeFnEaseOut,
      reverseCurve: TVar.animTimeFnEaseOut.flipped,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _position.dispose();
    _painter.dispose();
  }

  @override
  void didUpdateWidget(covariant TRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.checked != oldWidget.checked) {
      if(widget.checked != _checked) {
        _checked = widget.checked;
        formChange();
      }
      animateToValue();
    }
  }

  @override
  void handleTap([Intent? _]) {
    super.handleTap(_);
    widget.onClick?.call();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    // 鼠标
    const effectiveMouseCursor = TMaterialStateMouseCursor.clickable;

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
      Color color = checked ? colorScheme.brandColor : colorScheme.borderLevel2Color;
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
        padding: EdgeInsets.symmetric(horizontal: TVar.spacer),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: theme.fontData.fontSizeBase,
            color: widget.disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
          ),
          child: label,
        ),
      );
    }

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: checked,
      child: buildToggleable(
        mouseCursor: effectiveMouseCursor,
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
    );
  }

  @override
  ValueChanged<bool?>? get onChanged {
    return (value) {
      !tristate && checked ? null : widget.onChange?.call(value ?? false, widget.value);
    };
  }

  /// 如果为 true，则value可以为 true、false 或 null，否则value必须为 true 或 false。
  /// 当tristate为 true 且value为 null 时，控件被认为处于其第三个或“不确定”状态
  @override
  bool get tristate => widget.allowUncheck;

  @override
  bool? get value => checked;

  @override
  bool get isInteractive => !formDisabled && !widget.disabled;

  @override
  get formItemValue => value! ? widget.value : null;

  @override
  void reset(TFormResetType type) {
    switch (type) {
      case TFormResetType.empty:
        _checked = false;
        widget.onChange?.call(checked, null);
        break;
      case TFormResetType.initial:
        if (tristate || widget.defaultChecked == true) {
          _checked = widget.defaultChecked ?? false;
          widget.onChange?.call(checked, checked ? widget.value : null);
        }
        break;
    }
  }
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
