import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 复选框
class TCheckbox<T> extends StatefulWidget {
  const TCheckbox({
    Key? key,
    this.checked,
    this.disabled,
    this.indeterminate,
    this.label,
    this.readonly,
    this.prop,
    this.value,
    this.onChange,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  /// 是否选中
  final bool? checked;

  /// 是否禁用
  final bool? disabled;

  /// 是否半选
  final bool? indeterminate;

  /// 主文案
  final Widget? label;

  /// 是否只读
  final bool? readonly;

  /// 多选框的值
  final T? value;

  /// 表单验证中的属性名称
  final String? prop;

  /// 值变化时触发
  final TCheckValueChange<T>? onChange;

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  @override
  State<TCheckbox> createState() => _TCheckboxState();
}

class _TCheckboxState extends State<TCheckbox> with SingleTickerProviderStateMixin, MaterialStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(TCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  get states => materialStates;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var themeData = TCheckboxTheme.of(context);
    bool disabled = widget.disabled ?? themeData.disabled ?? false;
    var indeterminate = widget.indeterminate ?? themeData.indeterminate ?? false;
    var readonly = widget.readonly ?? themeData.readonly ?? false;
    if (disabled) {
      states.add(MaterialState.disabled);
    } else {
      states.remove(MaterialState.disabled);
    }

    Map<Type, Action<Intent>> actionMap = activeMap(indeterminate, context);

    final MaterialStateProperty<MouseCursor> effectiveMouseCursor = MaterialStateProperty.resolveWith<MouseCursor>((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    final MaterialStateProperty<TBorderSide> effectiveBorderSide = MaterialStateProperty.resolveWith((states) {
      Color color = widget.checked ?? indeterminate ? colorScheme.brandColor : colorScheme.borderLevel2Color;
      if (states.contains(MaterialState.hovered)) {
        color = colorScheme.brandColor;
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        color = colorScheme.brandColor;
      }
      return TBorderSide(color: color, width: 1);
    });

    return Semantics(
      checked: widget.checked ?? false,
      child: FocusableActionDetector(
        enabled: !disabled,
        actions: actionMap,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        mouseCursor: effectiveMouseCursor.resolve(states),
        onShowFocusHighlight: _handleFocusHighlightChanged,
        onShowHoverHighlight: _handleHoverChanged,
        child: SizedBox(
          height: 22,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: ShapeDecoration(
                  color: widget.checked ?? indeterminate ? colorScheme.brandColor : null,
                  shape: TRoundedRectangleBorder(
                    side: effectiveBorderSide.resolve(states),
                    borderRadius: BorderRadius.circular(ThemeDataConstant.borderRadius),
                  ),
                ),
                child: CustomPaint(
                  size: const Size(16, 16),
                  painter: _TCheckboxPaint(
                    color: colorScheme.textColorAnti,
                    strokeWidth: 2,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ThemeDataConstant.spacer),
                child: widget.label,
              )
            ],
          ),
        ),
      ),
    );

    // return Semantics(
    //   checked: widget.value ?? false,
    //   child: buildToggleable(
    //       mouseCursor: effectiveMouseCursor,
    //       focusNode: widget.focusNode,
    //       autofocus: widget.autofocus,
    //       size: size,
    //       painter: _painter
    //         ..position = position
    //         ..reaction = reaction
    //         ..reactionFocusFade = reactionFocusFade
    //         ..reactionHoverFade = reactionHoverFade
    //         ..hoverColor = colorScheme.bgColorContainer
    //         ..focusColor = colorScheme.bgColorContainer
    //         ..downPosition = downPosition
    //         ..isFocused = states.contains(MaterialState.focused)
    //         ..isHovered = states.contains(MaterialState.hovered)
    //         ..activeColor = colorScheme.brandColor
    //         ..inactiveColor = colorScheme.bgColorComponentDisabled
    //         .._side = effectiveBorderSide.resolve(states)),
    // );
  }

  Map<Type, Action<Intent>> activeMap(bool indeterminate, BuildContext context) {
    final Map<Type, Action<Intent>> actionMap = <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (intent) {
          if (indeterminate) return;
          switch (widget.checked) {
            case false:
              widget.onChange?.call(true, widget.value, indeterminate);
              break;
            case true:
              widget.onChange?.call(false, widget.value, indeterminate);
              break;
            case null:
              widget.onChange?.call(null, widget.value, indeterminate);
              break;
          }
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
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth * .8;
    var width = size.width;
    var height = size.height;
    final Offset origin = size / 2.0 - Size.square(width) / 2.0 as Offset;

    final Path path = Path();
    Offset start = Offset(width * 0.2, height * 0.5);
    Offset mid = Offset(width * 0.4, height * 0.7);
    Offset end = Offset(width * 0.8, height * 0.25);
    path.moveTo(origin.dx + start.dx, origin.dy + start.dy);
    path.lineTo(origin.dx + mid.dx, origin.dy + mid.dy);
    path.lineTo(origin.dx + end.dx, origin.dy + end.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TCheckboxPaint oldDelegate) {
    return this != oldDelegate;
  }
}
