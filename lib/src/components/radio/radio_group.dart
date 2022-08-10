import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 单选框组选项
class TRadioOption<T> {
  TRadioOption({
    required this.label,
    required this.value,
    this.disabled = false,
    this.allowUncheck = false,
  });

  /// 标签
  final Widget label;

  /// 值
  final T value;

  /// 是否禁选
  final bool disabled;

  /// 是否允许取消选中
  final bool allowUncheck;

  static TRadioOption<String> string({required String label, bool disabled = false, bool allowUncheck = false}) {
    return TRadioOption<String>(label: Text(label), value: label, disabled: disabled, allowUncheck: allowUncheck);
  }

  static List<TRadioOption<String>> strings({required List<String> labels, bool disabled = false, bool allowUncheck = false}) {
    return labels.map((label) => TRadioOption<String>(label: Text(label), value: label, disabled: disabled, allowUncheck: allowUncheck)).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TRadioOption &&
          runtimeType == other.runtimeType &&
          label == other.label &&
          value == other.value &&
          disabled == other.disabled &&
          allowUncheck == other.allowUncheck;

  @override
  int get hashCode => label.hashCode ^ value.hashCode ^ disabled.hashCode ^ allowUncheck.hashCode;
}

/// 单选组件按钮形式
enum TRadioVariant {
  /// radio样式
  radio,

  /// 边框型单选按钮样式
  outline,

  /// 主色填充型单选按钮样式
  primaryFilled,

  /// 默认填充型单选按钮样式
  defaultFilled;
}

/// 单选框组
class TRadioGroup<T> extends StatefulWidget {
  const TRadioGroup({
    Key? key,
    this.disabled = false,
    required this.options,
    required this.value,
    this.onChange,
    this.size,
    this.variant = TRadioVariant.radio,
    this.allowUncheck = false,
  }) : super(key: key);

  /// 是否禁用组件
  final bool disabled;

  /// 子元素
  final List<TRadioOption<T>> options;

  /// 选中值
  final T? value;

  /// 值变化时触发
  final void Function(T? value)? onChange;

  /// 组件尺寸
  final TComponentSize? size;

  /// 单选组件按钮形式
  final TRadioVariant variant;

  /// 是否允许取消选中
  final bool allowUncheck;

  /// 当前选中下标
  int get _index => value == null ? -1 : options.indexWhere((option) => option.value == value);

  @override
  State<TRadioGroup<T>> createState() => _TRadioGroupState<T>();
}

class _TRadioGroupState<T> extends State<TRadioGroup<T>> with SingleTickerProviderStateMixin {
  final _IndicatorBlockPainter _indicatorPainter = _IndicatorBlockPainter();
  late List<GlobalKey> _optionKeys;
  late AnimationController _controller;
  late Animation<double> _position;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: TVar.animDurationBase,
      value: widget._index != -1 ? 1 : 0,
    );
    _position = CurvedAnimation(
      parent: _controller,
      curve: TVar.animTimeFnEasing,
      reverseCurve: TVar.animTimeFnEasing.flipped,
    );
    _optionKeys = widget.options.map((option) => GlobalKey()).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _indicatorPainter.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(covariant TRadioGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.options.length > _optionKeys.length) {
      final int delta = widget.options.length - _optionKeys.length;
      _optionKeys.addAll(List<GlobalKey>.generate(delta, (int n) => GlobalKey()));
    } else if (widget.options.length < _optionKeys.length) {
      _optionKeys.removeRange(widget.options.length, _optionKeys.length);
    }
    if (widget.options.length != _optionKeys.length || widget.value != oldWidget.value) {
      _indicatorPainter._oldRect = _indicatorPainter._currentRect;
      if (widget._index != -1) {
        _controller.forward(from: 0);
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.variant == TRadioVariant.radio) {
      return radio();
    } else if (widget.variant == TRadioVariant.outline) {
      return outline(context);
    } else {
      return filled(context);
    }
  }

  /// 填充型
  Container filled(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    late Color blockColor;
    late Color textColor;
    var padding = const EdgeInsets.all(2);
    if (widget.variant == TRadioVariant.primaryFilled) {
      textColor = MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return colorScheme.textColorAnti;
        }
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.textColorDisabled;
        }
        if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
          return colorScheme.textColorPrimary;
        }
        return colorScheme.textColorSecondary;
      });
    } else if (widget.variant == TRadioVariant.defaultFilled) {
      textColor = MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected) && states.contains(MaterialState.disabled)) {
          return colorScheme.textColorDisabled;
        }
        if (states.contains(MaterialState.selected)) {
          return colorScheme.textColorPrimary;
        }
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.textColorDisabled;
        }
        if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
          return colorScheme.textColorPrimary;
        }
        return colorScheme.textColorSecondary;
      });
    }
    var box = List<Widget>.generate(widget.options.length, (index) {
      var option = widget.options[index];
      var disabled = widget.disabled ? true : option.disabled;
      if (widget.variant == TRadioVariant.primaryFilled) {
        blockColor = disabled ? colorScheme.brandColorDisabled : colorScheme.brandColor;
      } else if (widget.variant == TRadioVariant.defaultFilled) {
        blockColor = disabled ? colorScheme.bgColorComponentDisabled : colorScheme.bgColorContainerSelect;
      }
      return KeyedSubtree(
        key: _optionKeys[index],
        child: _TRadioButton<T>(
          label: option.label,
          value: option.value,
          textColor: textColor,
          disabled: disabled,
          allowUncheck: widget.allowUncheck ? true : option.allowUncheck,
          checked: widget.value == option.value,
          size: widget.size,
          onChange: _valueChange,
        ),
      );
    });
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: colorScheme.bgColorComponent,
        borderRadius: BorderRadius.circular(TVar.borderRadius),
      ),
      child: CustomPaint(
        painter: _indicatorPainter
          ..t = _position
          ..optionKeys = _optionKeys
          ..color = blockColor
          ..index = widget._index,
        child: TSpace(
          breakLine: false,
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: box,
        ),
      ),
    );
  }

  /// 单选型
  Widget radio() {
    List<Widget> box = widget.options
        .map((option) => TRadio<T>(
              disabled: widget.disabled ? true : option.disabled,
              allowUncheck: widget.allowUncheck ? true : option.allowUncheck,
              label: option.label,
              value: option.value,
              checked: widget.value == option.value,
              onChange: _valueChange,
            ))
        .toList();
    return TSpace(
      breakLine: true,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: box,
    );
  }

  /// 值变更事件
  void _valueChange(checked, value) {
    if (checked) {
      widget.onChange?.call(value);
    } else if (!checked && widget.value == value) {
      widget.onChange?.call(null);
    }
  }

  /// 边框型
  Widget outline(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    Color? backgroundColor = MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.selected) && states.contains(MaterialState.disabled)) {
        return colorScheme.bgColorSpecialComponent;
      }
      if (states.contains(MaterialState.disabled)) {
        return colorScheme.bgColorComponentDisabled;
      }
      return Colors.transparent;
    });

    Color textColor = MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.selected) && states.contains(MaterialState.disabled)) {
        return colorScheme.brandColorDisabled;
      }
      if (states.contains(MaterialState.disabled)) {
        return colorScheme.textColorDisabled;
      }
      if (states.contains(MaterialState.selected)) {
        return colorScheme.brandColor;
      }
      if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        return colorScheme.brandColorHover;
      }
      return colorScheme.textColorPrimary;
    });

    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    var box = List<Widget>.generate(widget.options.length, (index) {
      bool isLast = index == widget.options.length - 1;
      var option = widget.options[index];

      // 边框
      MaterialStateProperty<BoxBorder>? border = MaterialStateProperty.resolveWith((states) {
        Color color = colorScheme.borderLevel2Color;
        if (states.contains(MaterialState.selected)) {
          color = colorScheme.brandColor;
        }
        if (states.contains(MaterialState.selected) && states.contains(MaterialState.disabled)) {
          color = colorScheme.brandColorDisabled;
        }
        return Border.all(width: 1 / devicePixelRatio, color: color);
      });

      // 圆角
      BorderRadius? radius;
      if (index == 0) {
        radius = BorderRadius.only(
          topLeft: Radius.circular(TVar.borderRadius),
          bottomLeft: Radius.circular(TVar.borderRadius),
        );
      } else if (isLast) {
        radius = BorderRadius.only(
          topRight: Radius.circular(TVar.borderRadius),
          bottomRight: Radius.circular(TVar.borderRadius),
        );
      }
      return _TRadioButton<T>(
        label: option.label,
        value: option.value,
        textColor: textColor,
        backgroundColor: backgroundColor,
        disabled: widget.disabled ? true : option.disabled,
        allowUncheck: widget.allowUncheck ? true : option.allowUncheck,
        checked: widget.value == option.value,
        size: widget.size,
        border: border,
        radius: radius,
        onChange: _valueChange,
      );
    });
    return TSpace(
      spacing: 0,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: box,
    );
  }
}

/// 滑块指示器
class _IndicatorBlockPainter extends AnimationChangeNotifierPainter {
  Rect? _oldRect;
  Rect? _currentRect;

  int get index => _index!;
  int? _index;

  set index(int value) {
    if (value == _index) {
      return;
    }
    _index = value;
    notifyListeners();
  }

  Color get color => _color!;
  Color? _color;

  set color(Color value) {
    if (value == _color) {
      return;
    }
    _color = value;
    notifyListeners();
  }

  List<GlobalKey> get optionKeys => _optionKeys!;
  List<GlobalKey>? _optionKeys;

  set optionKeys(List<GlobalKey> value) {
    if (value == _optionKeys) {
      return;
    }
    _optionKeys = value;
    notifyListeners();
  }

  double get offsetX {
    if (index > 0) {
      var box = optionKeys[index].currentContext!.findRenderObject() as RenderBox;
      var dx = box.localToGlobal(const Offset(0, 0)).dx;
      var beforeBox = optionKeys[0].currentContext!.findRenderObject() as RenderBox;
      var dx2 = beforeBox.localToGlobal(const Offset(0, 0)).dx;
      return dx - dx2;
    }
    return 0;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;
    if (index == -1) {
      if (_currentRect != null) {
        var rect = Rect.lerp(_currentRect!.center & Size.zero, _currentRect, t.value);
        canvas.drawRRect(RRect.fromRectAndRadius(rect!, Radius.circular(TVar.borderRadius)), paint);
        if (t.value == 0) {
          _currentRect = null;
        }
      }
      return;
    }
    var optionKey = optionKeys[index];
    var optionWidth = optionKey.currentContext!.size!.width;
    var optionHeight = optionKey.currentContext!.size!.height;
    _currentRect = Rect.fromLTWH(offsetX, 0, optionWidth, optionHeight);

    var oldRect = _oldRect ?? _currentRect!.center & Size.zero;
    var rect = Rect.lerp(oldRect, _currentRect, t.value);

    canvas.drawRRect(RRect.fromRectAndRadius(rect!, Radius.circular(TVar.borderRadius)), paint);
  }
}

/// 单选按钮
class _TRadioButton<T> extends StatefulWidget {
  const _TRadioButton({
    Key? key,
    this.allowUncheck = false,
    this.checked,
    this.disabled = false,
    required this.label,
    required this.value,
    this.onChange,
    this.onClick,
    this.focusNode,
    this.autofocus = false,
    required this.textColor,
    this.backgroundColor,
    this.size,
    this.border,
    this.radius,
  }) : super(key: key);

  /// 是否允许取消选中
  final bool allowUncheck;

  /// 是否选中
  final bool? checked;

  /// 是否为禁用态
  final bool disabled;

  /// 主文案
  final Widget label;

  /// 单选按钮的值
  final T value;

  /// 选中状态变化时触发
  final TRadioChange<T>? onChange;

  /// 点击时触发
  final TCallback? onClick;

  /// 文本颜色
  final Color textColor;

  /// 背景颜色
  final Color? backgroundColor;

  /// 边框
  final MaterialStateProperty<BoxBorder>? border;

  /// 边框圆角
  final BorderRadius? radius;

  /// 组件大小
  final TComponentSize? size;

  final FocusNode? focusNode;

  final bool autofocus;

  bool get _checked => checked == true;

  @override
  State<_TRadioButton<T>> createState() => _TRadioButtonState<T>();
}

class _TRadioButtonState<T> extends State<_TRadioButton<T>> with TickerProviderStateMixin, TToggleableStateMixin {
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
      curve: TVar.animTimeFnEaseOut,
      reverseCurve: TVar.animTimeFnEaseOut.flipped,
    );
  }

  @override
  void didUpdateWidget(covariant _TRadioButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // if (widget._checked != oldWidget._checked) {
    //   animateToValue();
    // }
  }

  @override
  void handleTap([Intent? _]) {
    super.handleTap(_);
    widget.onClick?.call();
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var size = widget.size ?? theme.size;
    var padding = size.lazySizeOf(
      small: () => EdgeInsets.symmetric(horizontal: TVar.spacerS),
      medium: () => EdgeInsets.symmetric(vertical: TVar.spacerS, horizontal: TVar.spacer2),
      large: () => EdgeInsets.symmetric(vertical: TVar.spacer, horizontal: TVar.spacer3),
    );

    // 鼠标
    final effectiveMouseCursor = MaterialStateProperty.resolveWith<MouseCursor>((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    // 颜色
    var color = MaterialStateProperty.resolveAs(widget.textColor, states);

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
          behavior: HitTestBehavior.translucent,
          child: Semantics(
            enabled: isInteractive,
            child: Container(
              decoration: BoxDecoration(
                color: MaterialStateProperty.resolveAs(widget.backgroundColor, states),
                border: widget.border?.resolve(states),
                borderRadius: widget.radius,
              ),
              padding: padding,
              child: DefaultTextStyle(
                style: TextStyle(
                  fontSize: theme.fontSize,
                  color: color,
                ),
                child: widget.label,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  ValueChanged<bool?>? get onChanged {
    return (value) => !widget.allowUncheck && widget._checked ? null : widget.onChange?.call(value ?? false, widget.value);
  }

  @override
  bool get tristate => widget.allowUncheck;

  @override
  bool? get value => widget.checked ?? false;

  @override
  bool get isInteractive => !widget.disabled;
}
