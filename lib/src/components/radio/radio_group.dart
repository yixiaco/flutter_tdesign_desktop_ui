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

  static List<TRadioOption<String>> strings(
      {required List<String> labels, bool disabled = false, bool allowUncheck = false}) {
    return labels
        .map((label) =>
            TRadioOption<String>(label: Text(label), value: label, disabled: disabled, allowUncheck: allowUncheck))
        .toList();
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
class TRadioGroup<T> extends TFormItemValidate {
  const TRadioGroup({
    super.key,
    super.name,
    this.disabled = false,
    required this.options,
    required this.value,
    this.defaultValue,
    this.onChange,
    this.size,
    this.variant = TRadioVariant.radio,
    this.allowUncheck = false,
  });

  /// 是否禁用组件
  final bool disabled;

  /// 子元素
  final List<TRadioOption<T>> options;

  /// 选中值
  final T? value;

  /// 初始默认值，变更时不会更新组件值
  final T? defaultValue;

  /// 值变化时触发
  final TValueChange<T?>? onChange;

  /// 组件尺寸
  final TComponentSize? size;

  /// 单选组件按钮形式
  final TRadioVariant variant;

  /// 是否允许取消选中
  final bool allowUncheck;

  /// 当前选中下标
  int get _index => value == null ? -1 : options.indexWhere((option) => option.value == value);

  @override
  TFormItemValidateState<TRadioGroup<T>> createState() => _TRadioGroupState<T>();
}

class _TRadioGroupState<T> extends TFormItemValidateState<TRadioGroup<T>> with SingleTickerProviderStateMixin {
  final _IndicatorBlockPainter _indicatorPainter = _IndicatorBlockPainter();
  late List<GlobalKey> _optionKeys;
  late AnimationController _controller;
  late CurvedAnimation _position;
  T? _value;

  bool get disabled => formDisabled || widget.disabled;

  @override
  void initState() {
    _value = widget.value ?? widget.defaultValue;
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
    _position.dispose();
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
    if (widget.value != oldWidget.value && _value != widget.value) {
      _value = widget.value;
      formChange();
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
    if (widget.variant == TRadioVariant.primaryFilled) {
      textColor = MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return colorScheme.textColorAnti;
        }
        if (states.contains(MaterialState.disabled)) {
          return colorScheme.textColorDisabled;
        }
        if (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed)) {
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
        if (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed)) {
          return colorScheme.textColorPrimary;
        }
        return colorScheme.textColorSecondary;
      });
    }
    var box = List<Widget>.generate(widget.options.length, (index) {
      var option = widget.options[index];
      var disabled = this.disabled || option.disabled;
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
          allowUncheck: widget.allowUncheck || option.allowUncheck,
          checked: _value == option.value,
          size: widget.size,
          onChange: _valueChange,
        ),
      );
    });
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: colorScheme.bgColorComponent,
        borderRadius: BorderRadius.circular(TVar.borderRadiusDefault),
      ),
      child: RepaintBoundary(
        child: CustomPaint(
          painter: _indicatorPainter
            ..t = _position
            ..optionKeys = _optionKeys
            ..color = blockColor
            ..index = widget._index,
          child: TSpace(
            breakLine: false,
            spacing: 0,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: box,
          ),
        ),
      ),
    );
  }

  /// 单选型
  Widget radio() {
    List<Widget> box = widget.options
        .map((option) => TRadio<T>(
              disabled: disabled || option.disabled,
              allowUncheck: widget.allowUncheck || option.allowUncheck,
              label: option.label,
              value: option.value,
              checked: _value == option.value,
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
    } else if (!checked && _value == value) {
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
      if (states.contains(MaterialState.hovered) ||
          states.contains(MaterialState.focused) ||
          states.contains(MaterialState.pressed)) {
        return colorScheme.brandColorHover;
      }
      return colorScheme.textColorPrimary;
    });

    // 边框颜色
    final MaterialStateColor effectiveBorderColor = MaterialStateColor.resolveWith((states) {
      Color color = colorScheme.borderLevel2Color;
      if (states.contains(MaterialState.selected)) {
        color = colorScheme.brandColor;
      }
      if (states.contains(MaterialState.selected) && states.contains(MaterialState.disabled)) {
        color = colorScheme.brandColorDisabled;
      }
      return color;
    });

    var box = List<THollowChild>.generate(widget.options.length, (index) {
      var option = widget.options[index];
      return THollowChild(
        child: _TRadioButton<T>(
          label: option.label,
          value: option.value,
          textColor: textColor,
          backgroundColor: backgroundColor,
          disabled: disabled || option.disabled,
          allowUncheck: widget.allowUncheck ? true : option.allowUncheck,
          checked: _value == option.value,
          size: widget.size,
          onChange: _valueChange,
        ),
        disabled: disabled || option.disabled,
        checked: _value == option.value,
      );
    });
    return THollow(
      breakLine: true,
      radius: TVar.borderRadiusDefault,
      color: effectiveBorderColor,
      children: box,
    );
  }

  @override
  void reset(TFormResetType type) {
    switch (type) {
      case TFormResetType.empty:
        if (widget.allowUncheck) {
          _value = null;
          _valueChange(true, null);
        }
        break;
      case TFormResetType.initial:
        if (widget.allowUncheck || widget.defaultValue != null) {
          _value = widget.defaultValue;
          _valueChange(true, widget.defaultValue);
        }
        break;
    }
  }

  @override
  get formItemValue => _value;
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
        canvas.drawRRect(RRect.fromRectAndRadius(rect!, Radius.circular(TVar.borderRadiusDefault)), paint);
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

    canvas.drawRRect(RRect.fromRectAndRadius(rect!, Radius.circular(TVar.borderRadiusDefault)), paint);
  }
}

/// 单选按钮
class _TRadioButton<T> extends StatefulWidget {
  const _TRadioButton({
    super.key,
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
  });

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

  /// 焦点
  final FocusNode? focusNode;

  /// 是否自动聚焦
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

  Color? oldColor;
  Color? currentColor;

  @override
  void initState() {
    super.initState();
    _position = CurvedAnimation(
      parent: positionController,
      curve: TVar.animTimeFnEaseOut,
      reverseCurve: TVar.animTimeFnEaseOut.flipped,
    );
    positionController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _TRadioButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget._checked != oldWidget._checked) {
      oldColor = currentColor;
      positionController.forward(from: 0);
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
    var size = widget.size ?? theme.size;
    var padding = size.lazySizeOf(
      small: () => EdgeInsets.symmetric(horizontal: TVar.spacerS),
      medium: () => EdgeInsets.symmetric(vertical: TVar.spacerS, horizontal: TVar.spacer2),
      large: () => EdgeInsets.symmetric(vertical: TVar.spacer, horizontal: TVar.spacer3),
    );

    // 鼠标
    const effectiveMouseCursor = TMaterialStateMouseCursor.clickable;

    // 颜色
    var color = MaterialStateProperty.resolveAs(widget.textColor, states);
    currentColor = color;

    return Semantics(
      inMutuallyExclusiveGroup: true,
      checked: widget.checked,
      child: buildToggleable(
        mouseCursor: effectiveMouseCursor,
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
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
              color: Color.lerp(oldColor ?? currentColor, currentColor, position.value),
            ),
            child: widget.label,
          ),
        ),
      ),
    );
  }

  @override
  ValueChanged<bool?>? get onChanged {
    return (value) =>
        !widget.allowUncheck && widget._checked ? null : widget.onChange?.call(value ?? false, widget.value);
  }

  @override
  bool get tristate => widget.allowUncheck;

  @override
  bool? get value => widget._checked;

  @override
  bool get isInteractive => !widget.disabled;
}
