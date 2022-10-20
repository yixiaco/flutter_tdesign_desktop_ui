import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

enum TDecorationSlot {
  prefix,
  suffix,
  input,
  placeholder;
}

class TDecoratorParentData extends ContainerBoxParentData<RenderBox> {
  TDecorationSlot? slot;

  @override
  String toString() => '${super.toString()}; slot=$slot';
}

class TDecoratorData extends ParentDataWidget<TDecoratorParentData> {
  const TDecoratorData({
    super.key,
    required this.slot,
    required super.child,
  });

  final TDecorationSlot slot;

  @override
  void applyParentData(RenderObject renderObject) {
    assert(renderObject.parentData is TDecoratorParentData);
    final TDecoratorParentData parentData = renderObject.parentData! as TDecoratorParentData;
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
  Type get debugTypicalAncestorWidgetClass => TDecorator;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TDecorationSlot>('slot', slot));
  }
}

const String _kInputName = 'input';
const String _kSuffixName = 'suffix';
const String _kPlaceholderName = 'placeholder';
const String _kPrefixStartName = 'prefix';

class TDecorator extends MultiChildRenderObjectWidget {
  TDecorator({
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
          TDecoratorData(slot: TDecorationSlot.input, child: input),
          if (placeholder != null) TDecoratorData(slot: TDecorationSlot.placeholder, child: placeholder),
          if (suffix != null) TDecoratorData(slot: TDecorationSlot.suffix, child: suffix),
          if (prefix != null && prefix.isNotEmpty)
            ...List.generate(
                prefix.length, (index) => TDecoratorData(slot: TDecorationSlot.prefix, child: prefix[index])),
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

  // @override
  // Iterable<String> get slots => {
  //       _kSuffixName,
  //       _kInputName,
  //       _kPlaceholderName,
  //       if (prefix != null) ...List.generate(prefix!.length, (index) => '$_kPrefixStartName$index')
  //     };
  //
  // @override
  // Widget? childForSlot(String slot) {
  //   switch (slot) {
  //     case _kInputName:
  //       return input;
  //     case _kSuffixName:
  //       return suffix;
  //     case _kPlaceholderName:
  //       return placeholder;
  //   }
  //   if (slot.startsWith(_kPrefixStartName)) {
  //     var index = int.parse(RegExp('$_kPrefixStartName(\\d+)').firstMatch(slot)!.group(1)!);
  //     return prefix![index];
  //   }
  //   return null;
  // }

  @override
  TRenderDecoration createRenderObject(BuildContext context) {
    return TRenderDecoration(
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
  void updateRenderObject(BuildContext context, TRenderDecoration renderObject) {
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

class TRenderDecoration extends RenderBox with ContainerRenderObjectMixin<RenderBox, TDecoratorParentData>,
    RenderBoxContainerDefaultsMixin<RenderBox, TDecoratorParentData>,
    DebugOverflowIndicatorMixin {

  TRenderDecoration({
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
      var parentData = child.parentData as TDecoratorParentData;
      if(parentData.slot == slot) {
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
      var parentData = child.parentData as TDecoratorParentData;
      if(parentData.slot == TDecorationSlot.prefix) {
        boxes.add(child);
      }
      child = parentData.nextSibling;
    }
    return boxes;
  }

  RenderBox? get suffix => _findRenderBox(TDecorationSlot.suffix);

  // The returned list is ordered for hit testing.
  // @override
  // Iterable<RenderBox> get children {
  //   return <RenderBox>[
  //     if (input != null) input!,
  //     ...prefixes,
  //     if (suffix != null) suffix!,
  //     if (placeholder != null) placeholder!,
  //   ];
  // }

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
    if(child.parentData is! TDecoratorParentData) {
      child.parentData = TDecoratorParentData();
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
    double prefixHeight = 0; //_minHeight(prefix, width);
    double prefixWidth = 0; //_minWidth(prefix, prefixHeight);
    final double suffixHeight = _minHeight(suffix, width);
    final double suffixWidth = _minWidth(suffix, suffixHeight);
    if (breakLine) {
      double cpw = 0;
      double? cph;
      double availableWidth = width - suffixWidth;
      for (var prefix in prefixes) {
        var ph = _minHeight(prefix, availableWidth);
        var pw = _minWidth(prefix, ph);
        cph ??= ph;
        if (cpw + pw > availableWidth) {
          prefixHeight += cph + ph;
          prefixWidth = math.max(prefixWidth, cpw);
          cpw = pw;
        } else {
          cpw += pw;
          prefixWidth = math.max(prefixWidth, cpw);
        }
      }
      double inputHeight;
      if (availableWidth - cpw - contentPadding.horizontal < 0) {
        inputHeight = _lineHeight(availableWidth, <RenderBox?>[input, placeholder]);
      } else {
        inputHeight = _lineHeight(availableWidth - cpw - contentPadding.horizontal, <RenderBox?>[input, placeholder]);
      }

      final double contentHeight = contentPadding.top + inputHeight + contentPadding.bottom;
      final double containerHeight = <double>[contentHeight].reduce(math.max);
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

    final Map<RenderBox?, double> boxToBaseline = <RenderBox?, double>{};
    final BoxConstraints boxConstraints = constraints.loosen();

    for (var prefix in prefixes) {
      boxToBaseline[prefix] = _layoutLineBox(prefix, boxConstraints);
    }
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
    void computedInputLayout() {
      if (autoWidth) {
        // 自动宽度
        var minInputWidth = math.max(0.0, constraints.minWidth - otherWidth);
        var maxInputWidth = math.max(0.0, constraints.maxWidth - otherWidth);
        // 换行并且自动宽度
        boxToBaseline[placeholder] = _layoutLineBox(
          placeholder,
          boxConstraints.copyWith(
            minWidth: 0,
            maxWidth: maxInputWidth,
            minHeight: math.max(0.0, constraints.minHeight),
          ),
        );
        boxToBaseline[input] = _layoutLineBox(
          input,
          boxConstraints.copyWith(
            minWidth: math.max(_boxSize(placeholder).width, minInputWidth),
            maxWidth: maxInputWidth,
            minHeight: math.max(0.0, constraints.minHeight),
          ),
        );
        inputWidth = _boxSize(input).width;
      } else {
        isMaxWidth = true;
        // 全宽
        inputWidth = math.max(
          0.0,
          constraints.maxWidth - (contentPadding.horizontal + otherWidth),
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
            minWidth: inputWidth,
            maxWidth: inputWidth,
          ),
        );
      }
    }

    // 计算prefix高度、宽度
    if (breakLine) {
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
      if (otherWidth > availableWidth) {
        // 换行
        otherWidth = contentPadding.horizontal + suffixWidth;
        computedInputLayout();
        cpw = inputWidth;
        maxWidth = math.max(cpw, maxWidth);
      } else {
        computedInputLayout();
        cpw += inputWidth;
        maxWidth = math.max(cpw, maxWidth);
      }
      maxWidth += suffixWidth;

      // The field can be occupied by a hint or by the input itself
      final double placeholderHeight = placeholder == null ? 0 : placeholder!.size.height;
      final double inputDirectHeight = input == null ? 0 : input!.size.height;
      final double inputHeight = math.max(placeholderHeight, inputDirectHeight);

      levelHeight[level] = math.max(contentPadding.vertical + inputHeight, levelHeight[level]);
      // 将多行prefix高度累加
      maxHeight = levelHeight.reduce((value, element) => value + element);

      // Calculate the height of the input text container.
      final double suffixHeight = suffix == null ? 0 : suffix!.size.height;
      final double contentHeight = math.max(maxHeight, suffixHeight);

      final double maxContainerHeight = boxConstraints.maxHeight;
      maxHeight = math.min(contentHeight, maxContainerHeight);
    } else {
      for (var prefix in prefixes) {
        var pw = _boxSize(prefix).width;
        var ph = _boxSize(prefix).height;
        maxHeight = math.max(ph, maxHeight);
        maxWidth += pw;
      }
      maxWidth += suffixWidth;
      otherWidth = contentPadding.horizontal + maxWidth;
      computedInputLayout();
      // The field can be occupied by a hint or by the input itself
      final double placeholderHeight = placeholder == null ? 0 : placeholder!.size.height;
      final double inputDirectHeight = input == null ? 0 : input!.size.height;
      final double inputHeight = math.max(placeholderHeight, inputDirectHeight);
      maxWidth += inputWidth;

      levelHeight[level] = math.max(contentPadding.vertical + inputHeight, levelHeight[level]);
      // 将多行prefix高度累加
      maxHeight = levelHeight.reduce((value, element) => value + element);

      // Calculate the height of the input text container.
      final double suffixHeight = suffix == null ? 0 : suffix!.size.height;
      final double contentHeight = math.max(maxHeight, suffixHeight);

      final double maxContainerHeight = boxConstraints.maxHeight;
      maxHeight = math.min(contentHeight, maxContainerHeight);
    }

    final double inputInternalBaseline = math.max(
      boxToBaseline[input]!,
      boxToBaseline[placeholder]!,
    );

    if (breakLine) {
      double cpw0 = 0;
      int level = 0;
      double offsetLeft;
      double offsetTop = 0;
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
        _boxParentData(prefix).offset = Offset(offsetLeft, offsetTop);
      }
      if (input != null) {
        _boxParentData(input!).offset =
            Offset(cpw0, offsetTop + contentPadding.top + inputInternalBaseline - boxToBaseline[input]!);
      }
    }

    /// 旧代码
    //
    //
    //
    //
    // double width = contentPadding.horizontal;
    // double height = containerHeight;
    // double leftOffset = (prefix?.size.width ?? 0) + contentPadding.left;
    // if (prefix != null) {
    //   width += _boxSize(prefix).width;
    //   _boxParentData(prefix!).offset = Offset(0, (containerHeight - _boxSize(prefix).height) / 2);
    // }
    // if (input != null) {
    //   width += _boxSize(input).width;
    //   _boxParentData(input!).offset =
    //       Offset(leftOffset, contentPadding.top + inputInternalBaseline - boxToBaseline[input]!);
    // }
    // if (placeholder != null) {
    //   double offsetLeft;
    //   switch (textAlign) {
    //     left:
    //     case TextAlign.left:
    //       offsetLeft = leftOffset;
    //       break;
    //     right:
    //     case TextAlign.right:
    //       offsetLeft = leftOffset + inputWidth - _boxSize(placeholder).width;
    //       break;
    //     case TextAlign.center:
    //       offsetLeft = leftOffset + (inputWidth - _boxSize(placeholder).width) / 2;
    //       break;
    //     case TextAlign.justify:
    //       offsetLeft = leftOffset;
    //       break;
    //     case TextAlign.start:
    //       switch (direction) {
    //         case TextDirection.rtl:
    //           continue right;
    //         case TextDirection.ltr:
    //           continue left;
    //       }
    //     case TextAlign.end:
    //       switch (direction) {
    //         case TextDirection.rtl:
    //           continue left;
    //         case TextDirection.ltr:
    //           continue right;
    //       }
    //   }
    //   _boxParentData(placeholder!).offset =
    //       Offset(offsetLeft, contentPadding.top + inputInternalBaseline - boxToBaseline[placeholder]!);
    // }
    // leftOffset += (input?.size.width ?? 0) + contentPadding.right;
    if (suffix != null) {
      _boxParentData(suffix!).offset = Offset(
        maxWidth - _boxSize(suffix).width,
        (maxHeight - _boxSize(suffix).height) / 2,
      );
    }
    size = Size(maxWidth, constraints.constrainHeight(maxHeight));
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
