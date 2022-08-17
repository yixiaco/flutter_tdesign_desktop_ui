import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

bool? _startIsTopLeft(Axis direction, TextDirection? textDirection, VerticalDirection? verticalDirection) {
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
}

/// 固定交叉轴的Flex组件
/// 组件会先绘制一遍子布局的大小，得到最大组件宽度，然后强制应用到所有其他子组件中
/// 这个类可能是昂贵的，因此应首先考虑使用[Flex]，而不是[FixedCrossFlex]
class FixedCrossFlex extends MultiChildRenderObjectWidget {
  FixedCrossFlex({
    Key? key,
    required this.direction,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    this.clipBehavior = Clip.none,
    List<Widget> children = const <Widget>[],
  }) : super(key: key, children: children);

  /// The direction to use as the main axis.
  ///
  /// If you know the axis in advance, then consider using a [Row] (if it's
  /// horizontal) or [Column] (if it's vertical) instead of a [Flex], since that
  /// will be less verbose. (For [Row] and [Column] this property is fixed to
  /// the appropriate axis.)
  final Axis direction;

  /// How the children should be placed along the main axis.
  ///
  /// For example, [MainAxisAlignment.start], the default, places the children
  /// at the start (i.e., the left for a [Row] or the top for a [Column]) of the
  /// main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// After allocating space to children, there might be some remaining free
  /// space. This value controls whether to maximize or minimize the amount of
  /// free space, subject to the incoming layout constraints.
  ///
  /// If some children have a non-zero flex factors (and none have a fit of
  /// [FlexFit.loose]), they will expand to consume all the available space and
  /// there will be no remaining free space to maximize or minimize, making this
  /// value irrelevant to the final layout.
  final MainAxisSize mainAxisSize;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  ///
  /// If [textDirection] is [TextDirection.rtl], then the direction in which
  /// text flows starts from right to left. Otherwise, if [textDirection] is
  /// [TextDirection.ltr], then the direction in which text flows starts from
  /// left to right.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the order in which
  /// the children are positioned (left-to-right or right-to-left), and the
  /// meaning of the [mainAxisAlignment] property's [MainAxisAlignment.start] and
  /// [MainAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and either the
  /// [mainAxisAlignment] is either [MainAxisAlignment.start] or
  /// [MainAxisAlignment.end], or there's more than one child, then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  ///
  /// If the [direction] is [Axis.vertical], this controls the meaning of the
  /// [crossAxisAlignment] property's [CrossAxisAlignment.start] and
  /// [CrossAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and the [crossAxisAlignment] is
  /// either [CrossAxisAlignment.start] or [CrossAxisAlignment.end], then the
  /// [textDirection] (or the ambient [Directionality]) must not be null.
  final TextDirection? textDirection;

  /// Determines the order to lay children out vertically and how to interpret
  /// `start` and `end` in the vertical direction.
  ///
  /// Defaults to [VerticalDirection.down].
  ///
  /// If the [direction] is [Axis.vertical], this controls which order children
  /// are painted in (down or up), the meaning of the [mainAxisAlignment]
  /// property's [MainAxisAlignment.start] and [MainAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.vertical], and either the [mainAxisAlignment]
  /// is either [MainAxisAlignment.start] or [MainAxisAlignment.end], or there's
  /// more than one child, then the [verticalDirection] must not be null.
  ///
  /// If the [direction] is [Axis.horizontal], this controls the meaning of the
  /// [crossAxisAlignment] property's [CrossAxisAlignment.start] and
  /// [CrossAxisAlignment.end] values.
  ///
  /// If the [direction] is [Axis.horizontal], and the [crossAxisAlignment] is
  /// either [CrossAxisAlignment.start] or [CrossAxisAlignment.end], then the
  /// [verticalDirection] must not be null.
  final VerticalDirection verticalDirection;

  /// If aligning items according to their baseline, which baseline to use.
  ///
  /// This must be set if using baseline alignment. There is no default because there is no
  /// way for the framework to know the correct baseline _a priori_.
  final TextBaseline? textBaseline;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  bool get _needTextDirection {
    switch (direction) {
      case Axis.horizontal:
        return true; // because it affects the layout order.
      case Axis.vertical:
        return true;
    }
  }

  /// The value to pass to [RenderFlex.textDirection].
  ///
  /// This value is derived from the [textDirection] property and the ambient
  /// [Directionality]. The value is null if there is no need to specify the
  /// text direction. In practice there's always a need to specify the direction
  /// except for vertical flexes (e.g. [Column]s) whose [crossAxisAlignment] is
  /// not dependent on the text direction (not `start` or `end`). In particular,
  /// a [Row] always needs a text direction because the text direction controls
  /// its layout order. (For [Column]s, the layout order is controlled by
  /// [verticalDirection], which is always specified as it does not depend on an
  /// inherited widget and defaults to [VerticalDirection.down].)
  ///
  /// This method exists so that subclasses of [Flex] that create their own
  /// render objects that are derived from [RenderFlex] can do so and still use
  /// the logic for providing a text direction only when it is necessary.
  @protected
  TextDirection? getEffectiveTextDirection(BuildContext context) {
    return textDirection ?? (_needTextDirection ? Directionality.maybeOf(context) : null);
  }

  @override
  RenderFixedCrossFlex createRenderObject(BuildContext context) {
    return RenderFixedCrossFlex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      textDirection: getEffectiveTextDirection(context),
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderFixedCrossFlex renderObject) {
    renderObject
      ..direction = direction
      ..mainAxisAlignment = mainAxisAlignment
      ..mainAxisSize = mainAxisSize
      ..textDirection = getEffectiveTextDirection(context)
      ..verticalDirection = verticalDirection
      ..textBaseline = textBaseline
      ..clipBehavior = clipBehavior;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<Axis>('direction', direction));
    properties.add(EnumProperty<MainAxisAlignment>('mainAxisAlignment', mainAxisAlignment));
    properties.add(EnumProperty<MainAxisSize>('mainAxisSize', mainAxisSize, defaultValue: MainAxisSize.max));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection, defaultValue: null));
    properties.add(EnumProperty<VerticalDirection>('verticalDirection', verticalDirection, defaultValue: VerticalDirection.down));
    properties.add(EnumProperty<TextBaseline>('textBaseline', textBaseline, defaultValue: null));
  }
}

class RenderFixedCrossFlex extends RenderFlex {
  RenderFixedCrossFlex({
    super.children,
    super.direction = Axis.horizontal,
    super.mainAxisSize = MainAxisSize.max,
    super.mainAxisAlignment = MainAxisAlignment.start,
    super.crossAxisAlignment = CrossAxisAlignment.center,
    super.textDirection,
    super.verticalDirection = VerticalDirection.down,
    super.textBaseline,
    super.clipBehavior = Clip.none,
  });

  // Set during layout if overflow occurred on the main axis.
  double _overflow = 0;
  // Check whether any meaningful overflow is present. Values below an epsilon
  // are treated as not overflowing.
  bool get _hasOverflow => _overflow > precisionErrorTolerance;

  bool get _debugHasNecessaryDirections {
    if (firstChild != null && lastChild != firstChild) {
      // i.e. there's more than one child
      switch (direction) {
        case Axis.horizontal:
          assert(textDirection != null, 'Horizontal $runtimeType with multiple children has a null textDirection, so the layout order is undefined.');
          break;
        case Axis.vertical:
          break;
      }
    }
    if (mainAxisAlignment == MainAxisAlignment.start ||
        mainAxisAlignment == MainAxisAlignment.end) {
      switch (direction) {
        case Axis.horizontal:
          assert(textDirection != null, 'Horizontal $runtimeType with $mainAxisAlignment has a null textDirection, so the alignment cannot be resolved.');
          break;
        case Axis.vertical:
          break;
      }
    }
    if (crossAxisAlignment == CrossAxisAlignment.start ||
        crossAxisAlignment == CrossAxisAlignment.end) {
      switch (direction) {
        case Axis.horizontal:
          break;
        case Axis.vertical:
          assert(textDirection != null, 'Vertical $runtimeType with $crossAxisAlignment has a null textDirection, so the alignment cannot be resolved.');
          break;
      }
    }
    return true;
  }

  FlutterError? _debugCheckConstraints({required BoxConstraints constraints, required bool reportParentConstraints}) {
    FlutterError? result;
    assert(() {
      final double maxMainSize = direction == Axis.horizontal ? constraints.maxWidth : constraints.maxHeight;
      final bool canFlex = maxMainSize < double.infinity;
      RenderBox? child = firstChild;
      while (child != null) {
        final int flex = _getFlex(child);
        if (flex > 0) {
          final String identity = direction == Axis.horizontal ? 'row' : 'column';
          final String axis = direction == Axis.horizontal ? 'horizontal' : 'vertical';
          final String dimension = direction == Axis.horizontal ? 'width' : 'height';
          DiagnosticsNode error, message;
          final List<DiagnosticsNode> addendum = <DiagnosticsNode>[];
          if (!canFlex && (mainAxisSize == MainAxisSize.max || _getFit(child) == FlexFit.tight)) {
            error = ErrorSummary('RenderFlex children have non-zero flex but incoming $dimension constraints are unbounded.');
            message = ErrorDescription(
              'When a $identity is in a parent that does not provide a finite $dimension constraint, for example '
                  'if it is in a $axis scrollable, it will try to shrink-wrap its children along the $axis '
                  'axis. Setting a flex on a child (e.g. using Expanded) indicates that the child is to '
                  'expand to fill the remaining space in the $axis direction.',
            );
            if (reportParentConstraints) { // Constraints of parents are unavailable in dry layout.
              RenderBox? node = this;
              switch (direction) {
                case Axis.horizontal:
                  while (!node!.constraints.hasBoundedWidth && node.parent is RenderBox) {
                    node = node.parent! as RenderBox;
                  }
                  if (!node.constraints.hasBoundedWidth) {
                    node = null;
                  }
                  break;
                case Axis.vertical:
                  while (!node!.constraints.hasBoundedHeight && node.parent is RenderBox) {
                    node = node.parent! as RenderBox;
                  }
                  if (!node.constraints.hasBoundedHeight) {
                    node = null;
                  }
                  break;
              }
              if (node != null) {
                addendum.add(node.describeForError('The nearest ancestor providing an unbounded width constraint is'));
              }
            }
            addendum.add(ErrorHint('See also: https://flutter.dev/layout/'));
          } else {
            return true;
          }
          result = FlutterError.fromParts(<DiagnosticsNode>[
            error,
            message,
            ErrorDescription(
              'These two directives are mutually exclusive. If a parent is to shrink-wrap its child, the child '
                  'cannot simultaneously expand to fit its parent.',
            ),
            ErrorHint(
              'Consider setting mainAxisSize to MainAxisSize.min and using FlexFit.loose fits for the flexible '
                  'children (using Flexible rather than Expanded). This will allow the flexible children '
                  'to size themselves to less than the infinite remaining space they would otherwise be '
                  'forced to take, and then will cause the RenderFlex to shrink-wrap the children '
                  'rather than expanding to fit the maximum constraints provided by the parent.',
            ),
            ErrorDescription(
              'If this message did not help you determine the problem, consider using debugDumpRenderTree():\n'
                  '  https://flutter.dev/debugging/#rendering-layer\n'
                  '  http://api.flutter.dev/flutter/rendering/debugDumpRenderTree.html',
            ),
            describeForError('The affected RenderFlex is', style: DiagnosticsTreeStyle.errorProperty),
            DiagnosticsProperty<dynamic>('The creator information is set to', debugCreator, style: DiagnosticsTreeStyle.errorProperty),
            ...addendum,
            ErrorDescription(
              "If none of the above helps enough to fix this problem, please don't hesitate to file a bug:\n"
                  '  https://github.com/flutter/flutter/issues/new?template=2_bug.md',
            ),
          ]);
          return true;
        }
        child = childAfter(child);
      }
      return true;
    }());
    return result;
  }

  int _getFlex(RenderBox child) {
    final FlexParentData childParentData = child.parentData! as FlexParentData;
    return childParentData.flex ?? 0;
  }

  FlexFit _getFit(RenderBox child) {
    final FlexParentData childParentData = child.parentData! as FlexParentData;
    return childParentData.fit ?? FlexFit.tight;
  }

  double _getCrossSize(Size size) {
    switch (direction) {
      case Axis.horizontal:
        return size.height;
      case Axis.vertical:
        return size.width;
    }
  }

  double _getMainSize(Size size) {
    switch (direction) {
      case Axis.horizontal:
        return size.width;
      case Axis.vertical:
        return size.height;
    }
  }

  LayoutSizes _computeSizes({required BoxConstraints constraints, required ChildLayouter layoutChild}) {
    assert(_debugHasNecessaryDirections);

    // Determine used flex factor, size inflexible items, calculate free space.
    int totalFlex = 0;
    final double maxMainSize = direction == Axis.horizontal ? constraints.maxWidth : constraints.maxHeight;
    final bool canFlex = maxMainSize < double.infinity;

    double crossSize = 0.0;
    double allocatedSize = 0.0; // Sum of the sizes of the non-flexible children.
    RenderBox? child = firstChild;
    RenderBox? lastFlexChild;
    while (child != null) {
      final FlexParentData childParentData = child.parentData! as FlexParentData;
      final int flex = _getFlex(child);
      if (flex > 0) {
        totalFlex += flex;
        lastFlexChild = child;
      } else {
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
        final Size childSize = layoutChild(child, innerConstraints);
        allocatedSize += _getMainSize(childSize);
        crossSize = math.max(crossSize, _getCrossSize(childSize));
      }
      assert(child.parentData == childParentData);
      child = childParentData.nextSibling;
    }

    // Distribute free space to flexible children.
    final double freeSpace = math.max(0.0, (canFlex ? maxMainSize : 0.0) - allocatedSize);
    double allocatedFlexSpace = 0.0;
    if (totalFlex > 0) {
      final double spacePerFlex = canFlex ? (freeSpace / totalFlex) : double.nan;
      child = firstChild;
      while (child != null) {
        final int flex = _getFlex(child);
        if (flex > 0) {
          final double maxChildExtent = canFlex ? (child == lastFlexChild ? (freeSpace - allocatedFlexSpace) : spacePerFlex * flex) : double.infinity;
          late final double minChildExtent;
          switch (_getFit(child)) {
            case FlexFit.tight:
              assert(maxChildExtent < double.infinity);
              minChildExtent = maxChildExtent;
              break;
            case FlexFit.loose:
              minChildExtent = 0.0;
              break;
          }
          final BoxConstraints innerConstraints;
          if (crossAxisAlignment == CrossAxisAlignment.stretch) {
            switch (direction) {
              case Axis.horizontal:
                innerConstraints = BoxConstraints(
                  minWidth: minChildExtent,
                  maxWidth: maxChildExtent,
                  minHeight: constraints.maxHeight,
                  maxHeight: constraints.maxHeight,
                );
                break;
              case Axis.vertical:
                innerConstraints = BoxConstraints(
                  minWidth: constraints.maxWidth,
                  maxWidth: constraints.maxWidth,
                  minHeight: minChildExtent,
                  maxHeight: maxChildExtent,
                );
                break;
            }
          } else {
            switch (direction) {
              case Axis.horizontal:
                innerConstraints = BoxConstraints(
                  minWidth: minChildExtent,
                  maxWidth: maxChildExtent,
                  maxHeight: constraints.maxHeight,
                );
                break;
              case Axis.vertical:
                innerConstraints = BoxConstraints(
                  maxWidth: constraints.maxWidth,
                  minHeight: minChildExtent,
                  maxHeight: maxChildExtent,
                );
                break;
            }
          }
          final Size childSize = layoutChild(child, innerConstraints);
          final double childMainSize = _getMainSize(childSize);
          assert(childMainSize <= maxChildExtent);
          allocatedSize += childMainSize;
          allocatedFlexSpace += maxChildExtent;
          crossSize = math.max(crossSize, _getCrossSize(childSize));
        }
        final FlexParentData childParentData = child.parentData! as FlexParentData;
        child = childParentData.nextSibling;
      }
    }

    final double idealSize = canFlex && mainAxisSize == MainAxisSize.max ? maxMainSize : allocatedSize;
    return LayoutSizes(
      mainSize: idealSize,
      crossSize: crossSize,
      allocatedSize: allocatedSize,
    );
  }

  @override
  void performLayout() {
    assert(_debugHasNecessaryDirections);
    final BoxConstraints constraints = this.constraints;
    assert(() {
      final FlutterError? constraintsError = _debugCheckConstraints(
        constraints: constraints,
        reportParentConstraints: true,
      );
      if (constraintsError != null) {
        throw constraintsError;
      }
      return true;
    }());

    final LayoutSizes sizes = _computeSizes(
      layoutChild: ChildLayoutHelper.layoutChild,
      constraints: constraints,
    );
    resetChildConstraints(sizes, constraints);

    final double allocatedSize = sizes.allocatedSize;
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
        final FlexParentData childParentData = child.parentData! as FlexParentData;
        child = childParentData.nextSibling;
      }
    }

    // Align items along the main axis.
    switch (direction) {
      case Axis.horizontal:
        size = constraints.constrain(Size(actualSize, crossSize));
        actualSize = size.width;
        crossSize = size.height;
        break;
      case Axis.vertical:
        size = constraints.constrain(Size(crossSize, actualSize));
        actualSize = size.height;
        crossSize = size.width;
        break;
    }
    final double actualSizeDelta = actualSize - allocatedSize;
    _overflow = math.max(0.0, -actualSizeDelta);
    final double remainingSpace = math.max(0.0, actualSizeDelta);
    late final double leadingSpace;
    late final double betweenSpace;
    // flipMainAxis is used to decide whether to lay out left-to-right/top-to-bottom (false), or
    // right-to-left/bottom-to-top (true). The _startIsTopLeft will return null if there's only
    // one child and the relevant direction is null, in which case we arbitrarily decide not to
    // flip, but that doesn't have any detectable effect.
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
      final FlexParentData childParentData = child.parentData! as FlexParentData;
      final double childCrossPosition;
      switch (crossAxisAlignment) {
        case CrossAxisAlignment.start:
        case CrossAxisAlignment.end:
          childCrossPosition = _startIsTopLeft(flipAxis(direction), textDirection, verticalDirection)
              == (crossAxisAlignment == CrossAxisAlignment.start)
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

  /// 重置子组件布局大小
  void resetChildConstraints(LayoutSizes sizes, BoxConstraints constraints) {
    double maxWidth = sizes.crossSize;
    var list = getChildrenAsList();
    for (var child in list) {
      if (child.size.width < maxWidth) {
        ChildLayoutHelper.layoutChild(child, constraints.copyWith(minWidth: maxWidth, maxWidth: maxWidth));
      }
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (!_hasOverflow) {
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
          overflowChildRect = Rect.fromLTWH(0.0, 0.0, size.width + _overflow, 0.0);
          break;
        case Axis.vertical:
          overflowChildRect = Rect.fromLTWH(0.0, 0.0, 0.0, size.height + _overflow);
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
  Rect? describeApproximatePaintClip(RenderObject child) => _hasOverflow ? Offset.zero & size : null;

  @override
  String toStringShort() {
    String header = super.toStringShort();
    if (!kReleaseMode) {
      if (_hasOverflow) {
        header += ' OVERFLOWING';
      }
    }
    return header;
  }
}

class LayoutSizes {
  const LayoutSizes({
    required this.mainSize,
    required this.crossSize,
    required this.allocatedSize,
  });

  final double mainSize;
  final double crossSize;
  final double allocatedSize;
}
