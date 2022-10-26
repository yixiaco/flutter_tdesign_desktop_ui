import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

/// input滚动时的最小宽度
const double _kInputScrollMinWidth = 40;

enum TDecorationSlot {
  prefix,
  suffix,
  input,
  placeholder;
}

class _TDecoratorParentData extends ContainerBoxParentData<RenderBox> {
  TDecorationSlot? slot;

  @override
  String toString() => '${super.toString()}; slot=$slot';
}

class _TDecoratorData extends ParentDataWidget<_TDecoratorParentData> {
  const _TDecoratorData({
    required this.slot,
    required super.child,
  });

  final TDecorationSlot slot;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is _TDecoratorParentData);
    final _TDecoratorParentData parentData = renderObject.parentData! as _TDecoratorParentData;
    bool needsLayout = false;
    if (parentData.slot != slot) {
      parentData.slot = slot;
      needsLayout = true;
    }
    if (needsLayout) {
      final AbstractNode? targetParent = renderObject.parent;
      if (targetParent is RenderObject) {
        targetParent.markNeedsLayout();
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => TInputDecorator;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TDecorationSlot>('slot', slot));
  }
}

/// 输入框装饰器
class TInputDecorator extends MultiChildRenderObjectWidget {
  TInputDecorator({
    super.key,
    this.prefix,
    this.suffix,
    required this.input,
    this.placeholder,
    this.padding,
    required this.textAlign,
    required this.direction,
    required this.textBaseline,
    required this.autoWidth,
    required this.breakLine,
  }) : super(children: [
          _TDecoratorData(slot: TDecorationSlot.input, child: input),
          if (placeholder != null) _TDecoratorData(slot: TDecorationSlot.placeholder, child: placeholder),
          if (suffix != null) _TDecoratorData(slot: TDecorationSlot.suffix, child: suffix),
          if (prefix != null && prefix.isNotEmpty)
            ...List.generate(
                prefix.length, (index) => _TDecoratorData(slot: TDecorationSlot.prefix, child: prefix[index])),
        ]);

  /// 前缀
  final List<Widget>? prefix;

  /// 后缀
  final Widget? suffix;

  /// 输入框
  final Widget input;

  /// 占位符
  final Widget? placeholder;

  /// 内容边距
  final EdgeInsetsGeometry? padding;

  /// 文本框定位
  final TextAlign textAlign;

  /// 文本方向
  final TextDirection direction;

  /// 文本基线
  final TextBaseline textBaseline;

  /// 无论文本宽度如何，文本是否都将采用全宽。
  /// 当此设置为 true 时，宽度将基于文本宽度。
  final bool autoWidth;

  /// 是否换行
  final bool breakLine;

  @override
  RenderTDecoration createRenderObject(BuildContext context) {
    return RenderTDecoration(
      prefixLength: prefix?.length ?? 0,
      textAlign: textAlign,
      textBaseline: textBaseline,
      direction: direction,
      padding: padding,
      autoWidth: autoWidth,
      breakLine: breakLine,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderTDecoration renderObject) {
    renderObject
      ..prefixLength = prefix?.length ?? 0
      ..direction = direction
      ..textBaseline = textBaseline
      ..textAlign = textAlign
      ..padding = padding
      ..autoWidth = autoWidth
      ..breakLine = breakLine;
  }
}

class RenderTDecoration extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _TDecoratorParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _TDecoratorParentData>,
        DebugOverflowIndicatorMixin {
  RenderTDecoration({
    EdgeInsetsGeometry? padding,
    required int prefixLength,
    required TextAlign textAlign,
    required TextDirection direction,
    required TextBaseline textBaseline,
    required bool autoWidth,
    required bool breakLine,
  })  : _padding = padding,
        _prefixLength = prefixLength,
        _textAlign = textAlign,
        _direction = direction,
        _textBaseline = textBaseline,
        _autoWidth = autoWidth,
        _breakLine = breakLine;

  RenderBox? _findRenderBox(TDecorationSlot slot) {
    RenderBox? child = firstChild;
    while (child != null) {
      var parentData = child.parentData as _TDecoratorParentData;
      if (parentData.slot == slot) {
        return child;
      }
      child = parentData.nextSibling;
    }
    return child;
  }

  RenderBox? get input => _findRenderBox(TDecorationSlot.input);

  RenderBox? get placeholder => _findRenderBox(TDecorationSlot.placeholder);

  List<RenderBox> get prefixes {
    List<RenderBox> boxes = [];
    RenderBox? child = firstChild;
    while (child != null) {
      var parentData = child.parentData as _TDecoratorParentData;
      if (parentData.slot == TDecorationSlot.prefix) {
        boxes.add(child);
      }
      child = parentData.nextSibling;
    }
    return boxes;
  }

  RenderBox? get suffix => _findRenderBox(TDecorationSlot.suffix);

  /// prefix数量
  int get prefixLength => _prefixLength;
  int _prefixLength;

  set prefixLength(int value) {
    if (_prefixLength == value) {
      return;
    }
    _prefixLength = value;
    markNeedsLayout();
  }

  /// 内容边距
  EdgeInsetsGeometry? get padding => _padding;
  EdgeInsetsGeometry? _padding;

  set padding(EdgeInsetsGeometry? value) {
    if (_padding == value) {
      return;
    }
    _padding = value;
    markNeedsLayout();
  }

  /// 文本框定位
  TextAlign get textAlign => _textAlign;
  TextAlign _textAlign;

  set textAlign(TextAlign value) {
    if (_textAlign == value) {
      return;
    }
    _textAlign = value;
    markNeedsLayout();
  }

  /// 文本方向
  TextDirection get direction => _direction;
  TextDirection _direction;

  set direction(TextDirection value) {
    if (_direction == value) {
      return;
    }
    _direction = value;
    markNeedsLayout();
  }

  /// 文本基线
  TextBaseline get textBaseline => _textBaseline;
  TextBaseline _textBaseline;

  set textBaseline(TextBaseline value) {
    if (_textBaseline == value) {
      return;
    }
    _textBaseline = value;
    markNeedsLayout();
  }

  /// 无论文本宽度如何，文本是否都将采用全宽。
  /// 当此设置为 true 时，宽度将基于文本宽度。
  bool get autoWidth => _autoWidth;
  bool _autoWidth;

  set autoWidth(bool value) {
    if (_autoWidth == value) {
      return;
    }
    _autoWidth = value;
    markNeedsLayout();
  }

  /// 是否换行
  bool get breakLine => _breakLine;
  bool _breakLine;

  set breakLine(bool value) {
    if (_breakLine == value) {
      return;
    }
    _breakLine = value;
    markNeedsLayout();
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _TDecoratorParentData) {
      child.parentData = _TDecoratorParentData();
    }
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (prefixes.isNotEmpty) {
      for (var prefix in prefixes) {
        visitor(prefix);
      }
    }
    if (placeholder != null) {
      visitor(placeholder!);
    }
    if (input != null) {
      visitor(input!);
    }
    if (suffix != null) {
      visitor(suffix!);
    }
  }

  @override
  bool get sizedByParent => false;

  static double _minWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMinIntrinsicWidth(height);
  }

  static double _maxWidth(RenderBox? box, double height) {
    return box == null ? 0.0 : box.getMaxIntrinsicWidth(height);
  }

  static double _minHeight(RenderBox? box, double width) {
    return box == null ? 0.0 : box.getMinIntrinsicHeight(width);
  }

  static Size _boxSize(RenderBox? box) => box == null ? Size.zero : box.size;

  static BoxParentData _boxParentData(RenderBox box) => box.parentData! as BoxParentData;

  EdgeInsets get contentPadding => padding as EdgeInsets? ?? EdgeInsets.zero;

  @override
  double computeMinIntrinsicWidth(double height) {
    var width = contentPadding.left +
        prefixes.map((e) => _minWidth(e, height)).reduce((value, element) => value + element) +
        math.max(_minWidth(input, height), _minWidth(placeholder, height)) +
        _minWidth(suffix, height) +
        contentPadding.right;
    if (constraints.minWidth > width) {
      return constraints.minWidth;
    }
    if (constraints.maxWidth.isInfinite) {
      return width;
    }
    if (autoWidth && !breakLine) {
      return width;
    }
    if (constraints.maxWidth < width) {
      return constraints.maxWidth;
    }
    return width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    var width = contentPadding.left +
        prefixes.map((e) => _maxWidth(e, height)).reduce((value, element) => value + element) +
        math.max(_maxWidth(input, height), _maxWidth(placeholder, height)) +
        _maxWidth(suffix, height) +
        contentPadding.right;
    if (constraints.minWidth > width) {
      return constraints.minWidth;
    }
    if (constraints.maxWidth.isInfinite) {
      return width;
    }
    if (autoWidth && !breakLine) {
      return width;
    }
    if (constraints.maxWidth < width) {
      return constraints.maxWidth;
    }
    return width;
  }

  double _lineHeight(double width, List<RenderBox?> boxes) {
    double height = 0.0;
    for (final RenderBox? box in boxes) {
      if (box == null) {
        continue;
      }
      height = math.max(_minHeight(box, width), height);
    }
    return height;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    width = math.max(width - contentPadding.horizontal, 0.0);
    double prefixHeight = 0;
    double prefixWidth = 0;
    final double suffixHeight = _minHeight(suffix, width);
    final double suffixWidth = _minWidth(suffix, suffixHeight);
    if (breakLine) {
      double cpw = 0;
      double availableWidth = width - suffixWidth;
      List<double> levelHeight = [0];
      var level = 0;
      for (int i = 0; i < prefixes.length; i++) {
        var prefix = prefixes[i];
        var ph = _minHeight(prefix, availableWidth);
        var pw = _minWidth(prefix, ph);
        if (i > 0 && cpw + pw > availableWidth) {
          cpw = pw;
          level++;
          levelHeight.add(ph);
          cpw = pw;
        } else {
          cpw += pw;
          levelHeight[level] = math.max(ph, levelHeight[level]);
        }
      }
      prefixHeight = levelHeight.reduce((value, element) => value + element);
      double inputHeight =
          _lineHeight(availableWidth - cpw - contentPadding.horizontal, <RenderBox?>[input, placeholder]);

      final double contentHeight = contentPadding.vertical + inputHeight;
      final double containerHeight = <double>[contentHeight, prefixHeight, suffixHeight].reduce(math.max);
      const double minContainerHeight = 20;
      return math.max(containerHeight, minContainerHeight);
    } else {
      for (var prefix in prefixes) {
        var ph = _minHeight(prefix, width);
        var pw = _minWidth(prefix, ph);
        prefixWidth = math.min(prefixWidth + pw, width);
        prefixHeight = math.max(prefixHeight, ph);
      }

      final double availableInputWidth = math.max(width - prefixWidth - suffixWidth, 0.0);
      final double inputHeight = _lineHeight(availableInputWidth, <RenderBox?>[input, placeholder]);
      final double inputMaxHeight = <double>[inputHeight, prefixHeight, suffixHeight].reduce(math.max);

      final double contentHeight = contentPadding.top + inputMaxHeight + contentPadding.bottom;
      final double containerHeight = <double>[contentHeight].reduce(math.max);
      const double minContainerHeight = 20;
      return math.max(containerHeight, minContainerHeight);
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return computeMinIntrinsicHeight(width);
  }

  @override
  double computeDistanceToActualBaseline(TextBaseline baseline) {
    return _boxParentData(input!).offset.dy + input!.computeDistanceToActualBaseline(baseline)!;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    assert(debugCannotComputeDryLayout(
      reason: 'Layout requires baseline metrics, which are only available after a full layout.',
    ));
    return Size.zero;
  }

  // Lay out the given box if needed, and return its baseline.
  double _layoutLineBox(RenderBox? box, BoxConstraints constraints) {
    if (box == null) {
      return 0.0;
    }
    box.layout(constraints, parentUsesSize: true);
    final double baseline = box.getDistanceToBaseline(textBaseline)!;

    assert(() {
      if (baseline >= 0) {
        return true;
      }
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary("One of InputDecorator's children reported a negative baseline offset."),
        ErrorDescription(
          '${box.runtimeType}, of size ${box.size}, reported a negative '
          'alphabetic baseline of $baseline.',
        ),
      ]);
    }());
    return baseline;
  }

  @override
  void performLayout() {
    if (!autoWidth) {
      assert(
        constraints.maxWidth < double.infinity,
        'An TDecorator, which is typically created by a TInputBox, cannot '
        'have an unbounded width.\n'
        'This happens when the parent widget does not provide a finite width '
        'constraint. For example, if the TDecorator is contained by a Row, '
        'then its width must be constrained. An Expanded widget or a SizedBox '
        'can be used to constrain the width of the TDecorator or the '
        'TInputBox that contains it.',
      );
    }
    var input = this.input;
    var placeholder = this.placeholder;
    var suffix = this.suffix;
    var prefixes = this.prefixes;

    final Map<RenderBox?, double> boxToBaseline = <RenderBox?, double>{};
    var result = _decoratorLayout(boxToBaseline);
    double inputWidth = result.inputWidth;
    bool isMaxWidth = result.isMaxWidth;
    double maxHeight = result.maxHeight;
    double maxWidth = result.maxWidth;
    int level = result.levelHeight.length - 1;
    List<double> levelHeight = result.levelHeight;
    var availableWidth = result.availableWidth;

    // final double inputInternalBaseline = math.max(
    //   boxToBaseline[input]!,
    //   boxToBaseline[placeholder]!,
    // );

    double cpw0 = 0;
    double offsetTop = 0;
    double currentRowHeight = 0;
    if (breakLine) {
      int level = 0;
      double offsetLeft;
      for (int i = 0; i < prefixes.length; i++) {
        var prefix = prefixes[i];
        var width = prefix.size.width;
        if (i > 0 && width + cpw0 > availableWidth) {
          // 换行
          level++;
          offsetLeft = 0;
          cpw0 = width;
        } else {
          offsetLeft = cpw0;
          // 未换行
          cpw0 += width;
        }
        if (level == 0) {
          offsetTop = 0;
        } else {
          offsetTop = levelHeight.sublist(0, level).reduce((value, element) => value + element);
        }
        currentRowHeight = levelHeight[level];
        _boxParentData(prefix).offset = Offset(offsetLeft, offsetTop + (currentRowHeight - prefix.size.height) / 2);
      }
      if (input != null) {
        if (cpw0 + inputWidth + contentPadding.horizontal > availableWidth) {
          level++;
          cpw0 = 0;
          offsetTop = levelHeight.sublist(0, level).reduce((value, element) => value + element);
        }
        currentRowHeight = levelHeight[level];
      }
    } else {
      currentRowHeight = levelHeight[level];
      for (int i = 0; i < prefixes.length; i++) {
        var prefix = prefixes[i];
        _boxParentData(prefix).offset = Offset(cpw0, (currentRowHeight - prefix.size.height) / 2);
        cpw0 += prefix.size.width;
      }
    }
    if (level == 0) {
      if (maxHeight < constraints.minHeight) {
        currentRowHeight = constraints.minHeight;
      }
      if (currentRowHeight < _boxSize(suffix).height) {
        currentRowHeight = _boxSize(suffix).height;
      }
    }
    if (input != null) {
      _boxParentData(input).offset = Offset(
          cpw0 + contentPadding.left, offsetTop + (currentRowHeight - input.size.height) / 2 + contentPadding.top);
    }
    if (placeholder != null) {
      double offsetLeft;
      switch (textAlign) {
        left:
        case TextAlign.left:
          offsetLeft = cpw0;
          break;
        right:
        case TextAlign.right:
          offsetLeft = cpw0 + inputWidth - _boxSize(placeholder).width;
          break;
        case TextAlign.center:
          offsetLeft = cpw0 + (inputWidth - _boxSize(placeholder).width) / 2;
          break;
        case TextAlign.justify:
          offsetLeft = cpw0;
          break;
        case TextAlign.start:
          switch (direction) {
            case TextDirection.rtl:
              continue right;
            case TextDirection.ltr:
              continue left;
          }
        case TextAlign.end:
          switch (direction) {
            case TextDirection.rtl:
              continue left;
            case TextDirection.ltr:
              continue right;
          }
      }
      _boxParentData(placeholder).offset = Offset(offsetLeft + contentPadding.left,
          offsetTop + (currentRowHeight - placeholder.size.height) / 2 + contentPadding.top);
    }
    if (isMaxWidth) {
      maxWidth = constraints.maxWidth;
    }
    if (suffix != null) {
      _boxParentData(suffix).offset = Offset(
        maxWidth - _boxSize(suffix).width,
        (constraints.constrainHeight(maxHeight) - _boxSize(suffix).height) / 2,
      );
    }
    size = Size(maxWidth, constraints.constrainHeight(maxHeight));
  }

  /// 计算布局宽高
  _TDecoratorLayoutResult _decoratorLayout(Map<RenderBox?, double> boxToBaseline) {
    var input = this.input;
    var placeholder = this.placeholder;
    var suffix = this.suffix;
    var prefixes = this.prefixes;

    final BoxConstraints boxConstraints = constraints.loosen();

    boxToBaseline[suffix] = _layoutLineBox(suffix, boxConstraints);
    var suffixWidth = _boxSize(suffix).width;
    var availableWidth = constraints.maxWidth - suffixWidth;

    double inputWidth = 0;
    double otherWidth = 0;
    bool isMaxWidth = false;
    double maxHeight = 0;
    double maxWidth = 0;
    double cpw = 0;
    var level = 0;
    List<double> levelHeight = [0];
    // 计算input高度
    void computedInputLayout({double? min, double? max}) {
      if (autoWidth) {
        // 自动宽度
        var minInputWidth = math.max(0.0, min ?? constraints.minWidth - otherWidth);
        var maxInputWidth = math.max(0.0, max ?? availableWidth - contentPadding.horizontal);
        // 换行并且自动宽度
        boxToBaseline[placeholder] = _layoutLineBox(
          placeholder,
          boxConstraints.copyWith(
            minWidth: 0,
            maxWidth: maxInputWidth,
          ),
        );
        boxToBaseline[input] = _layoutLineBox(
          input,
          boxConstraints.copyWith(
            minWidth: math.max(_boxSize(placeholder).width, minInputWidth),
            maxWidth: maxInputWidth,
          ),
        );
        inputWidth = _boxSize(input).width;
      } else {
        isMaxWidth = true;
        // 全宽
        inputWidth = math.max(
          0.0,
          max ?? constraints.maxWidth - otherWidth,
        );
        boxToBaseline[placeholder] = _layoutLineBox(
          placeholder,
          boxConstraints.copyWith(
            minWidth: 0,
            maxWidth: inputWidth,
          ),
        );
        boxToBaseline[input] = _layoutLineBox(
          input,
          boxConstraints.copyWith(
            minWidth: 0,
            maxWidth: inputWidth,
          ),
        );
      }
    }

    // 计算prefix高度、宽度
    if (breakLine) {
      for (var prefix in prefixes) {
        boxToBaseline[prefix] = _layoutLineBox(prefix, boxConstraints);
      }
      for (int i = 0; i < prefixes.length; i++) {
        var pw = _boxSize(prefixes[i]).width;
        var ph = _boxSize(prefixes[i]).height;
        if (i > 0 && pw + cpw > availableWidth) {
          // 换行
          level++;
          isMaxWidth = true;
          levelHeight.add(ph);
          maxWidth = math.max(maxWidth, pw);
          cpw = pw;
        } else {
          levelHeight[level] = math.max(ph, levelHeight[level]);
          // 未换行
          cpw += pw;
          maxWidth = math.max(maxWidth, cpw);
        }
      }
      otherWidth = contentPadding.horizontal + cpw + suffixWidth;
      if (contentPadding.horizontal + cpw > availableWidth) {
        // 换行
        otherWidth = contentPadding.horizontal + suffixWidth;
        computedInputLayout();
      } else {
        computedInputLayout();
      }
      if (contentPadding.horizontal + cpw + inputWidth > availableWidth) {
        // 换行
        cpw = inputWidth + contentPadding.horizontal;
        maxWidth = math.max(cpw, maxWidth);

        // The field can be occupied by a hint or by the input itself
        final double placeholderHeight = placeholder == null ? 0 : placeholder.size.height;
        final double inputDirectHeight = input == null ? 0 : input.size.height;
        final double inputHeight = math.max(placeholderHeight, inputDirectHeight);

        level++;

        levelHeight.add(contentPadding.vertical + inputHeight);
      } else {
        cpw += inputWidth + contentPadding.horizontal;
        maxWidth = math.max(cpw, maxWidth);

        // 该字段可以由提示或输入本身占用
        final double placeholderHeight = placeholder == null ? 0 : placeholder.size.height;
        final double inputDirectHeight = input == null ? 0 : input.size.height;
        // 计算输入文本容器的高度。
        final double inputHeight = math.max(placeholderHeight, inputDirectHeight);

        levelHeight[level] = math.max(contentPadding.vertical + inputHeight, levelHeight[level]);
      }
      maxWidth += suffixWidth;

      // 将多行prefix高度累加
      maxHeight = levelHeight.reduce((value, element) => value + element);

      final double suffixHeight = suffix == null ? 0 : suffix.size.height;
      final double contentHeight = math.max(maxHeight, suffixHeight);

      final double maxContainerHeight = boxConstraints.maxHeight;
      maxHeight = math.min(contentHeight, maxContainerHeight);
    } else {
      for (var prefix in prefixes) {
        boxToBaseline[prefix] = _layoutLineBox(
          prefix,
          boxConstraints.copyWith(
              maxWidth: math.max(0, availableWidth - maxWidth - contentPadding.horizontal - _kInputScrollMinWidth)),
        );
        var pw = _boxSize(prefix).width;
        var ph = _boxSize(prefix).height;
        maxHeight = math.max(ph, maxHeight);
        maxWidth += pw;
        levelHeight[level] = math.max(levelHeight[level], ph);
      }
      maxWidth += suffixWidth;
      otherWidth = contentPadding.horizontal + maxWidth;
      computedInputLayout(max: constraints.maxWidth - otherWidth);
      // 该字段可以由提示或输入本身占用
      final double placeholderHeight = placeholder == null ? 0 : placeholder.size.height;
      final double inputDirectHeight = input == null ? 0 : input.size.height;
      // 计算输入文本容器的高度。
      final double inputHeight = math.max(placeholderHeight, inputDirectHeight);
      maxWidth += inputWidth + contentPadding.horizontal;

      levelHeight[level] = math.max(contentPadding.vertical + inputHeight, levelHeight[level]);
      // 将多行prefix高度累加
      maxHeight = levelHeight.reduce((value, element) => value + element);

      final double suffixHeight = suffix == null ? 0 : suffix.size.height;
      final double contentHeight = math.max(maxHeight, suffixHeight);

      final double maxContainerHeight = boxConstraints.maxHeight;
      maxHeight = math.min(contentHeight, maxContainerHeight);
    }
    return _TDecoratorLayoutResult(
      isMaxWidth: isMaxWidth,
      inputWidth: inputWidth,
      levelHeight: levelHeight,
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      availableWidth: availableWidth,
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        context.paintChild(child, _boxParentData(child).offset + offset);
      }
    }

    for (var prefix in prefixes) {
      doPaint(prefix);
    }
    doPaint(input);
    doPaint(suffix);
    doPaint(placeholder);
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }
}

class _TDecoratorLayoutResult {
  final bool isMaxWidth;
  final double inputWidth;
  final List<double> levelHeight;
  final double maxWidth;
  final double maxHeight;
  final double availableWidth;

  const _TDecoratorLayoutResult({
    required this.isMaxWidth,
    required this.inputWidth,
    required this.levelHeight,
    required this.maxWidth,
    required this.maxHeight,
    required this.availableWidth,
  });
}
