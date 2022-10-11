import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 多选框
/// 多选框是一个选择控件，允许用户通过单击在选中和未选中之间切换
class TCheckbox<T> extends StatefulWidget {
  const TCheckbox({
    Key? key,
    this.checked = false,
    this.disabled = false,
    this.indeterminate = false,
    this.label,
    this.readonly = false,
    this.value,
    this.onChange,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  /// 是否选中
  final bool checked;

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

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  @override
  State<TCheckbox<T>> createState() => _TCheckboxState<T>();
}

class _TCheckboxState<T> extends State<TCheckbox<T>> with SingleTickerProviderStateMixin, MaterialStateMixin {
  final _TCheckboxPaint _painter = _TCheckboxPaint();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

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

    setMaterialState(MaterialState.disabled, widget.disabled);
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
    setMaterialState(MaterialState.disabled, widget.disabled);
    var oldChecked = oldWidget.checked || oldWidget.indeterminate;
    var checked = widget.checked || widget.indeterminate;
    if (checked != oldChecked) {
      _painter
        ..checked = widget.checked
        ..indeterminate = widget.indeterminate;
      animationTo();
    }
  }

  void animationTo() {
    var checked = widget.checked || widget.indeterminate;
    if (checked) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  get states => materialStates;

  bool get _checked {
    return widget.indeterminate ? true : widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var themeData = TCheckboxTheme.of(context);
    Widget? label = widget.label ?? themeData.label;

    // 快捷键
    Map<Type, Action<Intent>> actionMap = activeMap(context);

    // 鼠标
    final MaterialStateProperty<MouseCursor> effectiveMouseCursor = MaterialStateProperty.resolveWith<MouseCursor>((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

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
      Color color = _checked ? colorScheme.brandColor : colorScheme.bgColorContainer;
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
            color: widget.disabled ? colorScheme.textColorDisabled : colorScheme.textColorPrimary,
          ),
          child: label,
        ),
      );
    }

    return Semantics(
      checked: widget.checked,
      child: FocusableActionDetector(
        enabled: !widget.disabled,
        actions: actionMap,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        mouseCursor: effectiveMouseCursor.resolve(states),
        onShowFocusHighlight: _handleFocusHighlightChanged,
        onShowHoverHighlight: _handleHoverChanged,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _handleTap();
          },
          child: SizedBox(
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
                      ..checked = widget.checked
                      ..indeterminate = widget.indeterminate
                      ..checkColor = checkColor.resolve(states),
                  ),
                ),
                label,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 处理选中事件
  void _handleTap() {
    if (!widget.readonly && !widget.disabled) {
      if (widget.indeterminate) {
        // 半选=>选中
        widget.onChange?.call(true, !widget.indeterminate, widget.value);
      } else {
        // 选中=>未选中
        widget.onChange?.call(!widget.checked, false, widget.value);
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

  void _handleHoverChanged(bool value) {
    setMaterialState(MaterialState.hovered, value);
  }

  void _handleFocusHighlightChanged(bool value) {
    setMaterialState(MaterialState.focused, value);
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
    if (indeterminate || checked) {
      var opacity = backgroundColor.opacity;

      canvas.drawRect(
        const Offset(0, 0) & size,
        Paint()..color = backgroundColor.withOpacity(opacity * t),
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
