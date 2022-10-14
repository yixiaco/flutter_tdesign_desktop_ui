import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dart:math' as math;

enum TDecorationSlot {
  prefix,
  suffix,
  input,
  tips,
  placeholder,
  container;
}

class TDecorator extends RenderObjectWidget with SlottedMultiChildRenderObjectWidgetMixin<TDecorationSlot> {
  const TDecorator({
    super.key,
    this.prefix,
    this.suffix,
    required this.input,
    this.tips,
    this.placeholder,
    this.container,
    this.padding,
    required this.textAlign,
    required this.direction,
    required this.textBaseline,
    required this.forceLine,
  });

  /// 前缀
  final Widget? prefix;

  /// 后缀
  final Widget? suffix;

  /// 输入框
  final Widget input;

  /// 提示
  final Widget? tips;

  /// 占位符
  final Widget? placeholder;

  /// 装饰器
  final Widget? container;

  /// 内容边距
  final EdgeInsetsGeometry? padding;

  /// 文本框定位
  final TextAlign textAlign;

  /// 文本方向
  final TextDirection direction;

  /// 文本基线
  final TextBaseline textBaseline;

  /// 无论文本宽度如何，文本是否都将采用全宽。
  // 当此设置为 false 时，宽度将基于文本宽度。
  final bool forceLine;

  @override
  Iterable<TDecorationSlot> get slots => TDecorationSlot.values;

  @override
  Widget? childForSlot(TDecorationSlot slot) {
    switch (slot) {
      case TDecorationSlot.prefix:
        return prefix;
      case TDecorationSlot.suffix:
        return suffix;
      case TDecorationSlot.input:
        return input;
      case TDecorationSlot.tips:
        return tips;
      case TDecorationSlot.placeholder:
        return placeholder;
      case TDecorationSlot.container:
        return container;
    }
  }

  @override
  TRenderDecoration createRenderObject(BuildContext context) {
    return TRenderDecoration(
      textAlign: textAlign,
      textBaseline: textBaseline,
      direction: direction,
      padding: padding,
      forceLine: forceLine,
    );
  }

  @override
  void updateRenderObject(BuildContext context, TRenderDecoration renderObject) {
    renderObject
      ..direction = direction
      ..textBaseline = textBaseline
      ..textAlign = textAlign
      ..padding = padding
      ..forceLine = forceLine;
  }
}

class TRenderDecoration extends RenderBox with SlottedContainerRenderObjectMixin<TDecorationSlot> {
  TRenderDecoration({
    EdgeInsetsGeometry? padding,
    required TextAlign textAlign,
    required TextDirection direction,
    required TextBaseline textBaseline,
    required bool forceLine,
  })  : _padding = padding,
        _textAlign = textAlign,
        _direction = direction,
        _textBaseline = textBaseline,
        _forceLine = forceLine;

  RenderBox? get input => childForSlot(TDecorationSlot.input);

  RenderBox? get tips => childForSlot(TDecorationSlot.tips);

  RenderBox? get placeholder => childForSlot(TDecorationSlot.placeholder);

  RenderBox? get prefix => childForSlot(TDecorationSlot.prefix);

  RenderBox? get suffix => childForSlot(TDecorationSlot.suffix);

  RenderBox? get container => childForSlot(TDecorationSlot.container);

  // The returned list is ordered for hit testing.
  @override
  Iterable<RenderBox> get children {
    return <RenderBox>[
      if (input != null) input!,
      if (prefix != null) prefix!,
      if (suffix != null) suffix!,
      if (placeholder != null) placeholder!,
      if (tips != null) tips!,
      if (container != null) container!,
    ];
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
  bool get forceLine => _forceLine;
  bool _forceLine;

  set forceLine(bool value) {
    if (_forceLine == value) {
      return;
    }
    _forceLine = value;
    markNeedsLayout();
  }

  @override
  void visitChildrenForSemantics(RenderObjectVisitor visitor) {
    if (container != null) {
      visitor(container!);
    }
    if (prefix != null) {
      visitor(prefix!);
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
    if (tips != null) {
      visitor(tips!);
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

  EdgeInsets get contentPadding => padding as EdgeInsets;

  @override
  double computeMinIntrinsicWidth(double height) {
    return contentPadding.left +
        _minWidth(prefix, height) +
        math.max(_minWidth(input, height), _minWidth(placeholder, height)) +
        _minWidth(suffix, height) +
        contentPadding.right;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return contentPadding.left +
        _maxWidth(prefix, height) +
        math.max(_maxWidth(input, height), _maxWidth(placeholder, height)) +
        _maxWidth(suffix, height) +
        contentPadding.right;
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
    // TODO(hansmuller): this should compute the overall line height for the
    // boxes when they've been baseline-aligned.
    // See https://github.com/flutter/flutter/issues/13715
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    final double tipsHeight = _minHeight(tips, width);

    width = math.max(width - contentPadding.horizontal, 0.0);

    final double prefixHeight = _minHeight(prefix, width);
    final double prefixWidth = _minWidth(prefix, prefixHeight);

    final double suffixHeight = _minHeight(suffix, width);
    final double suffixWidth = _minWidth(suffix, suffixHeight);

    final double availableInputWidth = math.max(width - prefixWidth - suffixWidth, 0.0);
    final double inputHeight = _lineHeight(availableInputWidth, <RenderBox?>[input, placeholder]);
    final double inputMaxHeight = <double>[inputHeight, prefixHeight, suffixHeight].reduce(math.max);

    final double contentHeight = contentPadding.top + inputMaxHeight + contentPadding.bottom;
    final double containerHeight = <double>[contentHeight].reduce(math.max);
    const double minContainerHeight = 20;
    return math.max(containerHeight, minContainerHeight) + tipsHeight;
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
    // Since internally, all layout is performed against the alphabetic baseline,
    // (eg, ascents/descents are all relative to alphabetic, even if the font is
    // an ideographic or hanging font), we should always obtain the reference
    // baseline from the alphabetic baseline. The ideographic baseline is for
    // use post-layout and is derived from the alphabetic baseline combined with
    // the font metrics.
    final double baseline = box.getDistanceToBaseline(TextBaseline.alphabetic)!;

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
    if (forceLine) {
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

    final Map<RenderBox?, double> boxToBaseline = <RenderBox?, double>{};
    final BoxConstraints boxConstraints = constraints.loosen();

    boxToBaseline[prefix] = _layoutLineBox(prefix, boxConstraints);
    boxToBaseline[suffix] = _layoutLineBox(suffix, boxConstraints);
    boxToBaseline[tips] = _layoutLineBox(tips, boxConstraints);

    // final BoxConstraints contentConstraints = constraints.copyWith(
    //   maxWidth: constraints.maxWidth - contentPadding.horizontal,
    // );

    final double inputWidth;
    if (forceLine) {
      inputWidth = math.max(
        0.0,
        constraints.maxWidth - (contentPadding.horizontal + _boxSize(prefix).width + _boxSize(suffix).width),
      );
      boxToBaseline[placeholder] = _layoutLineBox(
        placeholder,
        boxConstraints.copyWith(
          minWidth: 0,
          maxWidth: inputWidth,
          minHeight: math.max(0.0, constraints.minHeight - _boxSize(tips).height),
        ),
      );
      boxToBaseline[input] = _layoutLineBox(
        input,
        boxConstraints.copyWith(
          minWidth: inputWidth,
          maxWidth: inputWidth,
          minHeight: math.max(0.0, constraints.minHeight - _boxSize(tips).height),
        ),
      );
    } else {
      var otherWidth = contentPadding.left + _boxSize(prefix).width + _boxSize(suffix).width + contentPadding.right;
      var minWidth = math.max(0.0, constraints.minWidth - otherWidth);
      var maxWidth = math.max(0.0, constraints.maxWidth - otherWidth);
      boxToBaseline[placeholder] = _layoutLineBox(
        placeholder,
        boxConstraints.copyWith(
          minWidth: 0,
          maxWidth: maxWidth,
          minHeight: math.max(0.0, constraints.minHeight - _boxSize(tips).height),
        ),
      );
      boxToBaseline[input] = _layoutLineBox(
        input,
        boxConstraints.copyWith(
          minWidth: math.max(_boxSize(placeholder).width, minWidth),
          maxWidth: maxWidth,
          minHeight: math.max(0.0, constraints.minHeight - _boxSize(tips).height),
        ),
      );
      inputWidth = _boxSize(input).width;
    }

    final double bottomHeight = tips?.size.height ?? 0;

    // The field can be occupied by a hint or by the input itself
    final double placeholderHeight = placeholder == null ? 0 : placeholder!.size.height;
    final double inputDirectHeight = input == null ? 0 : input!.size.height;
    final double inputHeight = math.max(placeholderHeight, inputDirectHeight);
    final double inputInternalBaseline = math.max(
      boxToBaseline[input]!,
      boxToBaseline[placeholder]!,
    );

    // Calculate the height of the input text container.
    final double prefixHeight = prefix == null ? 0 : prefix!.size.height;
    final double suffixHeight = suffix == null ? 0 : suffix!.size.height;
    final double fixHeight = math.max(prefixHeight, suffixHeight);
    final double contentHeight = math.max(
      fixHeight,
      contentPadding.top + inputHeight + contentPadding.bottom,
    );

    final double maxContainerHeight = boxConstraints.maxHeight - bottomHeight;
    final double containerHeight = math.min(math.max(contentHeight, 0), maxContainerHeight);

    double width = contentPadding.horizontal;
    double height = containerHeight;
    double leftOffset = (prefix?.size.width ?? 0) + contentPadding.left;
    if (prefix != null) {
      width += _boxSize(prefix).width;
      _boxParentData(prefix!).offset = Offset(0, (containerHeight - _boxSize(prefix).height) / 2);
    }
    if (input != null) {
      width += _boxSize(input).width;
      _boxParentData(input!).offset = Offset(leftOffset, contentPadding.top + inputInternalBaseline - boxToBaseline[input]!);
    }
    if (placeholder != null) {
      double offsetLeft;
      switch (textAlign) {
        left:
        case TextAlign.left:
          offsetLeft = leftOffset;
          break;
        right:
        case TextAlign.right:
          offsetLeft = leftOffset + inputWidth - _boxSize(placeholder).width;
          break;
        case TextAlign.center:
          offsetLeft = leftOffset + (inputWidth - _boxSize(placeholder).width) / 2;
          break;
        case TextAlign.justify:
          offsetLeft = leftOffset;
          break;
        case TextAlign.start:
          switch(direction){
            case TextDirection.rtl:
              continue right;
            case TextDirection.ltr:
              continue left;
          }
        case TextAlign.end:
          switch(direction){
            case TextDirection.rtl:
              continue left;
            case TextDirection.ltr:
              continue right;
          }
      }
      _boxParentData(placeholder!).offset = Offset(offsetLeft, contentPadding.top + inputInternalBaseline - boxToBaseline[placeholder]!);
    }
    leftOffset += (input?.size.width ?? 0) + contentPadding.right;
    if (suffix != null) {
      width += _boxSize(suffix).width;
      _boxParentData(suffix!).offset = Offset(
        leftOffset,
        (containerHeight - _boxSize(suffix).height) / 2,
      );
    }
    if (container != null) {
      final BoxConstraints containerConstraints = BoxConstraints.tightFor(
        height: containerHeight,
        width: width,
      );
      container!.layout(containerConstraints, parentUsesSize: true);
    }
    if (tips != null) {
      _boxParentData(tips!).offset = Offset(0, containerHeight);
      height += _boxSize(tips).height;
    }
    size = Size(math.max(width, _boxSize(tips).width), height);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    void doPaint(RenderBox? child) {
      if (child != null) {
        context.paintChild(child, _boxParentData(child).offset + offset);
      }
    }

    doPaint(container);
    doPaint(prefix);
    doPaint(input);
    doPaint(suffix);
    doPaint(placeholder);
    doPaint(tips);
  }


  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, { required Offset position }) {
    for (final RenderBox child in children) {
      // The label must be handled specially since we've transformed it.
      final Offset offset = _boxParentData(child).offset;
      final bool isHit = result.addWithPaintOffset(
        offset: offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - offset);
          return child.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
    }
    return false;
  }
}
