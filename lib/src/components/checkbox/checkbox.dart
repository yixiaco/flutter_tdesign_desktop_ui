import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 复选框
class TCheckbox<T> extends StatefulWidget {
  const TCheckbox({
    Key? key,
    this.checked = false,
    this.disabled = false,
    this.indeterminate = false,
    this.label,
    this.readonly = false,
    this.prop,
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

  /// 表单验证中的属性名称
  final String? prop;

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
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  /// 默认淡入持续时间
  static const Duration _fadeInDuration = Duration(milliseconds: 150);

  /// 默认淡出持续时间
  static const Duration _fadeOutDuration = Duration(milliseconds: 75);

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _fadeInDuration,
      reverseDuration: _fadeOutDuration,
    )..addStatusListener((status) { });

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    setMaterialState(MaterialState.disabled, widget.disabled);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(TCheckbox<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    setMaterialState(MaterialState.disabled, widget.disabled);
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
      Color? color = _checked ? colorScheme.brandColor : null;
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
                    color: bgColor.resolve(states),
                    shape: TRoundedRectangleBorder(
                      side: effectiveBorderSide.resolve(states),
                      borderRadius: BorderRadius.circular(ThemeDataConstant.borderRadius),
                    ),
                  ),
                  child: CustomPaint(
                    size: const Size.square(16),
                    painter: _TCheckboxPaint(
                      color: checkColor.resolve(states),
                      strokeWidth: 2,
                      checked: widget.checked,
                      indeterminate: widget.indeterminate,
                    ),
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

class _TCheckboxPaint extends CustomPainter {
  const _TCheckboxPaint({
    required this.color,
    required this.strokeWidth,
    required this.checked,
    required this.indeterminate,
  });

  /// 线条颜色
  final Color color;

  /// 线条宽度
  final double strokeWidth;

  /// 是否选中
  final bool checked;

  /// 是否半选
  final bool indeterminate;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth * .8;
    var width = size.width;
    var height = size.height;

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

  @override
  bool shouldRepaint(_TCheckboxPaint oldDelegate) {
    return this != oldDelegate;
  }
}
