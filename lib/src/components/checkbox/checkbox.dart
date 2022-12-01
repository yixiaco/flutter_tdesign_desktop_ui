import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 多选框
/// 多选框是一个选择控件，允许用户通过单击在选中和未选中之间切换
class TCheckbox<T> extends TFormItemValidate {
  const TCheckbox({
    super.key,
    super.name,
    super.focusNode,
    this.checked,
    this.defaultChecked = false,
    this.disabled = false,
    this.indeterminate = false,
    this.label,
    this.readonly = false,
    this.value,
    this.onChange,
    this.autofocus = false,
  });

  /// 是否选中
  final bool? checked;

  /// 是否选中。非受控属性
  final bool defaultChecked;

  /// 是否禁用
  final bool disabled;

  /// 是否半选
  final bool indeterminate;

  /// 主文案
  final Widget? label;

  /// 是否只读
  final bool readonly;

  /// 多选框的值
  final T? value;

  /// 值变化时触发
  final TCheckValueChange<T?>? onChange;

  /// 自动聚焦
  final bool autofocus;

  @override
  TFormItemValidateState<TCheckbox<T>> createState() => _TCheckboxState<T>();
}

class _TCheckboxState<T> extends TFormItemValidateState<TCheckbox<T>> with SingleTickerProviderStateMixin {
  final _TCheckboxPaint _painter = _TCheckboxPaint();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late bool checked;

  @override
  void initState() {
    super.initState();
    checked = widget.checked ?? widget.defaultChecked;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      value: _checked ? 1 : 0,
    )..addListener(() {
        _painter.t = _fadeAnimation.value;
      });

    _painter.t = _checked ? 1 : 0;

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: TVar.animTimeFnEaseIn,
      reverseCurve: TVar.animTimeFnEaseIn.flipped,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _painter.dispose();
  }

  @override
  void didUpdateWidget(TCheckbox<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.checked != oldWidget.checked && checked != widget.checked) {
      checked = widget.checked ?? false;
      formChange();
    }
    _painter
      ..checked = checked
      ..indeterminate = widget.indeterminate;
    animationTo();
  }

  void animationTo() {
    var checked = this.checked || widget.indeterminate;
    if (checked) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  bool get _checked => widget.indeterminate || checked;

  bool get disabled => formDisabled || widget.disabled;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var themeData = TCheckboxTheme.of(context);
    Widget? label = widget.label ?? themeData.label;

    // 快捷键
    Map<Type, Action<Intent>> actionMap = activeMap(context);

    // 鼠标
    const MaterialStateProperty<MouseCursor> effectiveMouseCursor = TMaterialStateMouseCursor.clickable;

    // 边框
    final MaterialStateProperty<TBorderSide> effectiveBorderSide = MaterialStateProperty.resolveWith((states) {
      Color color = _checked ? colorScheme.brandColor : colorScheme.borderLevel2Color;
      if (states.contains(MaterialState.hovered)) {
        color = colorScheme.brandColor;
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        color = colorScheme.brandColor;
      }
      if (states.contains(MaterialState.disabled)) {
        color = colorScheme.borderLevel2Color;
      }
      return TBorderSide(color: color, width: 1);
    });

    // 背景填充颜色
    final bgColor = MaterialStateProperty.resolveWith((states) {
      Color color = colorScheme.bgColorContainer;
      if (states.contains(MaterialState.disabled)) {
        color = colorScheme.bgColorComponentDisabled;
      }
      return color;
    });

    // 选中背景填充颜色
    final checkBgColor = MaterialStateProperty.resolveWith((states) {
      Color color = colorScheme.brandColor;
      if (states.contains(MaterialState.disabled)) {
        color = colorScheme.bgColorComponentDisabled;
      }
      return color;
    });

    // 选中的线条颜色
    final checkColor = MaterialStateProperty.resolveWith((states) {
      Color color = colorScheme.textColorAnti;
      if (states.contains(MaterialState.disabled)) {
        color = colorScheme.textColorDisabled;
      }
      return color;
    });

    if (label != null) {
      label = Padding(
        padding: EdgeInsets.symmetric(horizontal: TVar.spacer),
        child: DefaultTextStyle(
          style: TextStyle(
            fontSize: theme.fontData.fontSizeBase,
            color: disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
          ),
          child: label,
        ),
      );
    }

    return Semantics(
      checked: widget.checked,
      child: TMaterialStateButton(
        disabled: disabled,
        actions: actionMap,
        selected: widget.checked == true,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        cursor: effectiveMouseCursor,
        behavior: HitTestBehavior.translucent,
        onTap: () {
          _handleTap();
        },
        builder: (context, states) {
          return SizedBox(
            height: 22,
            child: TSpace(
              spacing: 0,
              crossAxisAlignment: CrossAxisAlignment.center,
              breakLine: false,
              children: [
                Container(
                  width: 16,
                  height: 16,
                  decoration: ShapeDecoration(
                    shape: TRoundedRectangleBorder(
                      side: effectiveBorderSide.resolve(states),
                      borderRadius: BorderRadius.circular(TVar.borderRadiusDefault),
                    ),
                  ),
                  child: CustomPaint(
                    size: const Size.square(16),
                    painter: _painter
                      ..backgroundColor = bgColor.resolve(states)
                      ..checkBackgroundColor = checkBgColor.resolve(states)
                      ..checked = checked
                      ..indeterminate = widget.indeterminate
                      ..checkColor = checkColor.resolve(states),
                  ),
                ),
                label,
              ],
            ),
          );
        },
      ),
    );
  }

  /// 处理选中事件
  void _handleTap() {
    if (!widget.readonly && !disabled) {
      if (widget.indeterminate) {
        // 半选=>选中
        widget.onChange?.call(true, !widget.indeterminate, widget.value);
      } else {
        // 选中=>未选中
        widget.onChange?.call(!checked, false, null);
      }
    }
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

  @override
  get formItemValue => checked ? widget.value : null;

  @override
  void reset(TFormResetType type) {
    switch (type) {
      case TFormResetType.empty:
        checked = false;
        break;
      case TFormResetType.initial:
        checked = widget.defaultChecked;
        break;
    }
    widget.onChange?.call(checked, false, checked ? widget.value : null);
  }
}

class _TCheckboxPaint extends ChangeNotifier implements CustomPainter {
  /// 线条宽度
  static const double strokeWidth = 2;

  /// 线条颜色
  Color get checkColor => _checkColor!;
  Color? _checkColor;

  set checkColor(Color value) {
    if (_checkColor == value) {
      return;
    }
    _checkColor = value;
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

  /// 选中背景颜色
  Color get checkBackgroundColor => _checkBackgroundColor!;
  Color? _checkBackgroundColor;

  set checkBackgroundColor(Color value) {
    if (_checkBackgroundColor == value) {
      return;
    }
    _checkBackgroundColor = value;
    notifyListeners();
  }

  /// 是否选中
  bool get checked => _checked!;
  bool? _checked;

  set checked(bool value) {
    if (_checked == value) {
      return;
    }
    _checked = value;
    notifyListeners();
  }

  /// 是否半选
  bool get indeterminate => _indeterminate!;
  bool? _indeterminate;

  set indeterminate(bool value) {
    if (_indeterminate == value) {
      return;
    }
    _indeterminate = value;
    notifyListeners();
  }

  /// 时间曲度
  double get t => _t ?? (indeterminate || checked ? 1 : 0);
  double? _t;

  set t(double value) {
    if (_t == value) {
      return;
    }
    _t = value;
    notifyListeners();
  }

  @override
  void paint(Canvas canvas, Size size) {
    var opacity2 = checkColor.opacity;
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = checkColor.withOpacity(opacity2 * t)
      ..strokeWidth = strokeWidth * .8;
    var width = size.width;
    var height = size.height;

    drawBackground(canvas, size);

    drawDash(width, height, canvas, paint);
  }

  /// 绘制线条
  void drawDash(double width, double height, Canvas canvas, Paint paint) {
    final Path path = Path();
    if (indeterminate) {
      path.moveTo(width * 0.2, height * 0.5);
      path.lineTo(width * 0.8, height * 0.5);
      canvas.drawPath(path, paint);
    } else if (checked) {
      const Offset origin = Offset(0, 0);

      Offset start = Offset(width * 0.2, height * 0.5);
      Offset mid = Offset(width * 0.4, height * 0.7);
      Offset end = Offset(width * 0.8, height * 0.25);
      path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
      path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
      path.lineTo(origin.dx + end.dx, origin.dy + end.dy);
      canvas.drawPath(path, paint);
    }
  }

  /// 绘制背景
  void drawBackground(Canvas canvas, Size size) {
    canvas.drawRect(
      const Offset(0, 0) & size,
      Paint()..color = backgroundColor,
    );
    if (indeterminate || checked) {
      var opacity = checkBackgroundColor.opacity;
      canvas.drawRect(
        const Offset(0, 0) & size,
        Paint()..color = checkBackgroundColor.withOpacity(opacity * t),
      );
    }
  }

  @override
  bool shouldRepaint(_TCheckboxPaint oldDelegate) {
    return this != oldDelegate;
  }

  @override
  bool? hitTest(Offset position) => null;

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;
}
