import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

List<Widget> _addAll({
  required Widget child,
  Widget? prefix,
  Widget? suffix,
}) {
  List<Widget> list = [];
  if (prefix != null) {
    list.add(LayoutId(id: 'prefix', child: prefix));
  }
  list.add(LayoutId(id: 'child', child: child));
  if (suffix != null) {
    list.add(LayoutId(id: 'suffix', child: suffix));
  }
  return list;
}

/// 组件装饰器
/// 空间不足时，装饰物优先占有空间，分配剩余空间给子组件。
/// 当约束最小值比组件占有空间小时，组件将紧贴在一起
/// 当约束最小值比组件占有空间大时，组件将按照主轴的对齐方式放置
/// 当不明确组件大小，并需要附加装饰时，会很有用
class TDecorationBox extends MultiChildRenderObjectWidget {
  TDecorationBox({
    Key? key,
    required Widget child,
    this.prefix,
    this.suffix,
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.textBaseline,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
  }) : super(key: key, children: _addAll(child: child, prefix: prefix, suffix: suffix));

  /// 前缀
  final Widget? prefix;

  /// 后缀
  final Widget? suffix;

  /// 方向
  final Axis direction;

  /// 主轴对齐方式
  final MainAxisAlignment mainAxisAlignment;

  /// 交叉轴对齐方式
  final CrossAxisAlignment crossAxisAlignment;

  /// 方向
  final TextDirection? textDirection;

  /// 基线
  final TextBaseline? textBaseline;

  /// 垂直方向
  final VerticalDirection verticalDirection;

  /// 溢出剪切
  final Clip clipBehavior;

  bool get _needTextDirection {
    switch (direction) {
      case Axis.horizontal:
        return true; // because it affects the layout order.
      case Axis.vertical:
        return crossAxisAlignment == CrossAxisAlignment.start || crossAxisAlignment == CrossAxisAlignment.end;
    }
  }

  @protected
  TextDirection? getEffectiveTextDirection(BuildContext context) {
    return textDirection ?? (_needTextDirection ? Directionality.maybeOf(context) : null);
  }

  @override
  RenderTDecorationBox createRenderObject(BuildContext context) {
    return RenderTDecorationBox(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderTDecorationBox renderObject) {
    renderObject
      ..direction = direction
      ..mainAxisAlignment = mainAxisAlignment
      ..crossAxisAlignment = crossAxisAlignment
      ..textDirection = getEffectiveTextDirection(context)
      ..verticalDirection = verticalDirection
      ..textBaseline = textBaseline
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Widget>('prefix', prefix, defaultValue: null));
    properties.add(EnumProperty<Widget>('suffix', suffix, defaultValue: null));
    properties.add(EnumProperty<Axis>('direction', direction));
    properties.add(EnumProperty<MainAxisAlignment>('mainAxisAlignment', mainAxisAlignment));
    properties.add(EnumProperty<CrossAxisAlignment>('crossAxisAlignment', crossAxisAlignment));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(EnumProperty<VerticalDirection>('verticalDirection', verticalDirection, defaultValue: VerticalDirection.down));
    properties.add(EnumProperty<TextBaseline>('textBaseline', textBaseline, defaultValue: null));
  }
}

/// 组件装饰器
/// 空间不足时，装饰物优先占有空间，分配剩余空间给子组件。
/// 当约束最小值比组件占有空间小时，组件将紧贴在一起
/// 当约束最小值比组件占有空间大时，组件将按照主轴的对齐方式放置
///
/// 另请参阅:
/// * [TDecorationBox]
class RenderTDecorationBox extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, MultiChildLayoutParentData>,
        DebugOverflowIndicatorMixin {
  RenderTDecorationBox({
    Axis direction = Axis.horizontal,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection? textDirection,
    TextBaseline? textBaseline,
    VerticalDirection verticalDirection = VerticalDirection.down,
    Clip clipBehavior = Clip.none,
  })  : _direction = direction,
        _mainAxisAlignment = mainAxisAlignment,
        _crossAxisAlignment = crossAxisAlignment,
        _textDirection = textDirection,
        _textBaseline = textBaseline,
        _verticalDirection = verticalDirection,
        _clipBehavior = clipBehavior;

  /// 方向
  Axis get direction => _direction;
  Axis _direction;

  set direction(Axis value) {
    if (_direction != value) {
      _direction = value;
      markNeedsLayout();
    }
  }

  /// 主轴对齐方式
  MainAxisAlignment get mainAxisAlignment => _mainAxisAlignment;
  MainAxisAlignment _mainAxisAlignment;

  set mainAxisAlignment(MainAxisAlignment value) {
    if (_mainAxisAlignment != value) {
      _mainAxisAlignment = value;
      markNeedsLayout();
    }
  }

  /// 交叉轴对齐方式
  CrossAxisAlignment get crossAxisAlignment => _crossAxisAlignment;
  CrossAxisAlignment _crossAxisAlignment;

  set crossAxisAlignment(CrossAxisAlignment value) {
    if (_crossAxisAlignment != value) {
      _crossAxisAlignment = value;
      markNeedsLayout();
    }
  }

  /// 方向
  TextDirection? get textDirection => _textDirection;
  TextDirection? _textDirection;

  set textDirection(TextDirection? value) {
    if (_textDirection != value) {
      _textDirection = value;
      markNeedsLayout();
    }
  }

  /// 基线
  TextBaseline? get textBaseline => _textBaseline;
  TextBaseline? _textBaseline;

  set textBaseline(TextBaseline? value) {
    assert(_crossAxisAlignment != CrossAxisAlignment.baseline || value != null);
    if (_textBaseline != value) {
      _textBaseline = value;
      markNeedsLayout();
    }
  }

  /// 垂直方向
  VerticalDirection get verticalDirection => _verticalDirection;
  VerticalDirection _verticalDirection;

  set verticalDirection(VerticalDirection value) {
    if (_verticalDirection != value) {
      _verticalDirection = value;
      markNeedsLayout();
    }
  }

  /// 溢出剪切方式
  Clip get clipBehavior => _clipBehavior;
  Clip _clipBehavior = Clip.none;

  set clipBehavior(Clip value) {
    if (value != _clipBehavior) {
      _clipBehavior = value;
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  Map<Object, RenderBox>? _idToChild;

  double _getCrossSize(Size size) {
    switch (_direction) {
      case Axis.horizontal:
        return size.height;
      case Axis.vertical:
        return size.width;
    }
  }

  double _getMainSize(Size size) {
    switch (_direction) {
      case Axis.horizontal:
        return size.width;
      case Axis.vertical:
        return size.height;
    }
  }

  /// 溢出
  double overflow = 0;

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! MultiChildLayoutParentData) {
      child.parentData = MultiChildLayoutParentData();
    }
  }

  void _callPerformLayout(RenderBox? firstChild) {
    _idToChild = <Object, RenderBox>{};
    RenderBox? child = firstChild;
    while (child != null) {
      final MultiChildLayoutParentData childParentData = child.parentData! as MultiChildLayoutParentData;
      _idToChild![childParentData.id!] = child;
      child = childParentData.nextSibling;
    }
  }

  bool hasLayoutId(Object id) {
    return _idToChild!.containsKey(id);
  }

  RenderBox? getChild(Object id) {
    return _idToChild![id];
  }

  @override
  double? computeDistanceToActualBaseline(TextBaseline baseline) {
    if (_direction == Axis.horizontal) {
      return defaultComputeDistanceToHighestActualBaseline(baseline);
    }
    return defaultComputeDistanceToFirstActualBaseline(baseline);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (crossAxisAlignment == CrossAxisAlignment.baseline) {
      assert(debugCannotComputeDryLayout(
        reason: 'Dry layout cannot be computed for CrossAxisAlignment.baseline, which requires a full layout.',
      ));
      return Size.zero;
    }

    final LayoutSizes sizes = _computeSizes(
      layoutChild: ChildLayoutHelper.dryLayoutChild,
      constraints: constraints,
    );

    switch (_direction) {
      case Axis.horizontal:
        return constraints.constrain(Size(sizes.mainSize, sizes.crossSize));
      case Axis.vertical:
        return constraints.constrain(Size(sizes.crossSize, sizes.mainSize));
    }
  }

  LayoutSizes _computeSizes({required BoxConstraints constraints, required ChildLayouter layoutChild}) {
    double crossSize = 0.0;
    double allocatedSize = 0.0;

    RenderBox child = getChild('child') as RenderBox;
    var prefix = getChild('prefix');
    var suffix = getChild('suffix');

    final BoxConstraints innerConstraints;
    if (crossAxisAlignment == CrossAxisAlignment.stretch) {
      switch (direction) {
        case Axis.horizontal:
          innerConstraints = BoxConstraints.tightFor(height: constraints.maxHeight);
          break;
        case Axis.vertical:
          innerConstraints = BoxConstraints.tightFor(width: constraints.maxWidth);
          break;
      }
    } else {
      switch (direction) {
        case Axis.horizontal:
          innerConstraints = BoxConstraints(maxHeight: constraints.maxHeight);
          break;
        case Axis.vertical:
          innerConstraints = BoxConstraints(maxWidth: constraints.maxWidth);
          break;
      }
    }

    // 分配前缀空间
    if (prefix != null) {
      final Size childSize = layoutChild(prefix, innerConstraints);
      allocatedSize += _getMainSize(childSize);
      crossSize = math.max(crossSize, _getCrossSize(childSize));
    }
    // 分配后缀空间
    if (suffix != null) {
      final Size childSize = layoutChild(suffix, innerConstraints);
      allocatedSize += _getMainSize(childSize);
      crossSize = math.max(crossSize, _getCrossSize(childSize));
    }
    // 子组件分配剩余空间
    final BoxConstraints childConstraints;
    switch (direction) {
      case Axis.horizontal:
        childConstraints = BoxConstraints(maxWidth: math.max(0, constraints.maxWidth - allocatedSize));
        break;
      case Axis.vertical:
        childConstraints = BoxConstraints(maxHeight: math.max(0, constraints.maxHeight - allocatedSize));
        break;
    }
    // child
    final Size childSize = layoutChild(child, childConstraints);
    allocatedSize += _getMainSize(childSize);
    crossSize = math.max(crossSize, _getCrossSize(childSize));

    return LayoutSizes(
      mainSize: allocatedSize,
      crossSize: crossSize,
    );
  }

  @override
  void performLayout() {
    _callPerformLayout(firstChild);
    var sizes = _computeSizes(
      constraints: constraints,
      layoutChild: ChildLayoutHelper.layoutChild,
    );

    double actualSize = sizes.mainSize;
    double crossSize = sizes.crossSize;
    double maxBaselineDistance = 0.0;
    if (crossAxisAlignment == CrossAxisAlignment.baseline) {
      RenderBox? child = firstChild;
      double maxSizeAboveBaseline = 0;
      double maxSizeBelowBaseline = 0;
      while (child != null) {
        assert(() {
          if (textBaseline == null) {
            throw FlutterError('To use FlexAlignItems.baseline, you must also specify which baseline to use using the "baseline" argument.');
          }
          return true;
        }());
        final double? distance = child.getDistanceToBaseline(textBaseline!, onlyReal: true);
        if (distance != null) {
          maxBaselineDistance = math.max(maxBaselineDistance, distance);
          maxSizeAboveBaseline = math.max(
            distance,
            maxSizeAboveBaseline,
          );
          maxSizeBelowBaseline = math.max(
            child.size.height - distance,
            maxSizeBelowBaseline,
          );
          crossSize = math.max(maxSizeAboveBaseline + maxSizeBelowBaseline, crossSize);
        }
        final MultiChildLayoutParentData childParentData = child.parentData! as MultiChildLayoutParentData;
        child = childParentData.nextSibling;
      }
    }

    final double maxMainSize;
    final double minMainSize;
    // 将项目沿主轴对齐。
    switch (direction) {
      case Axis.horizontal:
        maxMainSize = constraints.maxWidth;
        minMainSize = constraints.minWidth;
        size = constraints.constrain(Size(actualSize, crossSize));
        actualSize = size.width;
        crossSize = size.height;
        break;
      case Axis.vertical:
        maxMainSize = constraints.maxHeight;
        minMainSize = constraints.minHeight;
        size = constraints.constrain(Size(crossSize, actualSize));
        actualSize = size.height;
        crossSize = size.width;
        break;
    }

    final double actualSizeDelta = maxMainSize - actualSize;
    overflow = math.max(0.0, -actualSizeDelta);

    final double remainingSpace = math.max(0.0, minMainSize - sizes.mainSize);
    late final double leadingSpace;
    late final double betweenSpace;
    final bool flipMainAxis = !(_startIsTopLeft(direction, textDirection, verticalDirection) ?? true);
    switch (mainAxisAlignment) {
      case MainAxisAlignment.start:
        leadingSpace = 0.0;
        betweenSpace = 0.0;
        break;
      case MainAxisAlignment.end:
        leadingSpace = remainingSpace;
        betweenSpace = 0.0;
        break;
      case MainAxisAlignment.center:
        leadingSpace = remainingSpace / 2.0;
        betweenSpace = 0.0;
        break;
      case MainAxisAlignment.spaceBetween:
        leadingSpace = 0.0;
        betweenSpace = childCount > 1 ? remainingSpace / (childCount - 1) : 0.0;
        break;
      case MainAxisAlignment.spaceAround:
        betweenSpace = childCount > 0 ? remainingSpace / childCount : 0.0;
        leadingSpace = betweenSpace / 2.0;
        break;
      case MainAxisAlignment.spaceEvenly:
        betweenSpace = childCount > 0 ? remainingSpace / (childCount + 1) : 0.0;
        leadingSpace = betweenSpace;
        break;
    }
    // Position elements
    double childMainPosition = flipMainAxis ? actualSize - leadingSpace : leadingSpace;
    RenderBox? child = firstChild;
    while (child != null) {
      final MultiChildLayoutParentData childParentData = child.parentData! as MultiChildLayoutParentData;
      final double childCrossPosition;
      switch (crossAxisAlignment) {
        case CrossAxisAlignment.start:
        case CrossAxisAlignment.end:
          childCrossPosition =
              _startIsTopLeft(flipAxis(direction), textDirection, verticalDirection) == (crossAxisAlignment == CrossAxisAlignment.start)
                  ? 0.0
                  : crossSize - _getCrossSize(child.size);
          break;
        case CrossAxisAlignment.center:
          childCrossPosition = crossSize / 2.0 - _getCrossSize(child.size) / 2.0;
          break;
        case CrossAxisAlignment.stretch:
          childCrossPosition = 0.0;
          break;
        case CrossAxisAlignment.baseline:
          if (direction == Axis.horizontal) {
            assert(textBaseline != null);
            final double? distance = child.getDistanceToBaseline(textBaseline!, onlyReal: true);
            if (distance != null) {
              childCrossPosition = maxBaselineDistance - distance;
            } else {
              childCrossPosition = 0.0;
            }
          } else {
            childCrossPosition = 0.0;
          }
          break;
      }
      if (flipMainAxis) {
        childMainPosition -= _getMainSize(child.size);
      }
      switch (direction) {
        case Axis.horizontal:
          childParentData.offset = Offset(childMainPosition, childCrossPosition);
          break;
        case Axis.vertical:
          childParentData.offset = Offset(childCrossPosition, childMainPosition);
          break;
      }
      if (flipMainAxis) {
        childMainPosition -= betweenSpace;
      } else {
        childMainPosition += _getMainSize(child.size) + betweenSpace;
      }
      child = childParentData.nextSibling;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (overflow < 0) {
      defaultPaint(context, offset);
      return;
    }

    // There's no point in drawing the children if we're empty.
    if (size.isEmpty) {
      return;
    }

    if (clipBehavior == Clip.none) {
      _clipRectLayer.layer = null;
      defaultPaint(context, offset);
    } else {
      // We have overflow and the clipBehavior isn't none. Clip it.
      _clipRectLayer.layer = context.pushClipRect(
        needsCompositing,
        offset,
        Offset.zero & size,
        defaultPaint,
        clipBehavior: clipBehavior,
        oldLayer: _clipRectLayer.layer,
      );
    }

    assert(() {
      // Only set this if it's null to save work. It gets reset to null if the
      // _direction changes.
      final List<DiagnosticsNode> debugOverflowHints = <DiagnosticsNode>[
        ErrorDescription(
          'The overflowing $runtimeType has an orientation of $direction.',
        ),
        ErrorDescription(
          'The edge of the $runtimeType that is overflowing has been marked '
          'in the rendering with a yellow and black striped pattern. This is '
          'usually caused by the contents being too big for the $runtimeType.',
        ),
        ErrorHint(
          'Consider applying a flex factor (e.g. using an Expanded widget) to '
          'force the children of the $runtimeType to fit within the available '
          'space instead of being sized to their natural size.',
        ),
        ErrorHint(
          'This is considered an error condition because it indicates that there '
          'is content that cannot be seen. If the content is legitimately bigger '
          'than the available space, consider clipping it with a ClipRect widget '
          'before putting it in the flex, or using a scrollable container rather '
          'than a Flex, like a ListView.',
        ),
      ];

      // Simulate a child rect that overflows by the right amount. This child
      // rect is never used for drawing, just for determining the overflow
      // location and amount.
      final Rect overflowChildRect;
      switch (direction) {
        case Axis.horizontal:
          overflowChildRect = Rect.fromLTWH(0.0, 0.0, size.width + overflow, 0.0);
          break;
        case Axis.vertical:
          overflowChildRect = Rect.fromLTWH(0.0, 0.0, 0.0, size.height + overflow);
          break;
      }
      paintOverflowIndicator(context, offset, Offset.zero & size, overflowChildRect, overflowHints: debugOverflowHints);
      return true;
    }());
  }

  final LayerHandle<ClipRectLayer> _clipRectLayer = LayerHandle<ClipRectLayer>();

  @override
  void dispose() {
    _clipRectLayer.layer = null;
    super.dispose();
  }

  @override
  Rect? describeApproximatePaintClip(RenderObject child) => overflow > 0 ? Offset.zero & size : null;

  @override
  String toStringShort() {
    String header = super.toStringShort();
    if (!kReleaseMode) {
      if (overflow > 0) {
        header += ' OVERFLOWING';
      }
    }
    return header;
  }

  static bool? _startIsTopLeft(direction, textDirection, verticalDirection) {
    // If the relevant value of textDirection or verticalDirection is null, this returns null too.
    switch (direction) {
      case Axis.horizontal:
        switch (textDirection) {
          case TextDirection.ltr:
            return true;
          case TextDirection.rtl:
            return false;
          case null:
            return null;
        }
        break;
      case Axis.vertical:
        switch (verticalDirection) {
          case VerticalDirection.down:
            return true;
          case VerticalDirection.up:
            return false;
          case null:
            return null;
        }
    }
    return null;
  }
}

class LayoutSizes {
  const LayoutSizes({
    required this.mainSize,
    required this.crossSize,
  });

  final double mainSize;
  final double crossSize;
}
