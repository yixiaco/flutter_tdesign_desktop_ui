part of '../popup.dart';

/// 用于计算要在全局坐标系中指定的目标上方或下方显示的浮层布局的代理。
class _PopupPositionDelegate extends SingleChildLayoutDelegate {
  /// 创建用于计算浮层布局的委托。
  ///
  /// 参数不能为null。
  _PopupPositionDelegate({
    required this.offset,
    required this.placement,
    required this.margin,
    required this.target,
    this.callback,
  });

  /// 与组件之间的偏移量
  final double offset;

  /// 浮层的方向
  final TPopupPlacement placement;

  /// 与窗口边界之间的距离
  final double margin;

  final PopupPositionCallback? callback;

  /// 上一次获取到的偏移
  _PopupOffset target;

  /// 上一次的位置
  Offset? _offset;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) => constraints.loosen();

  /// 儿童应放置的位置。
  /// “size”参数是父对象的大小，如果该大小不满足传递给[getSize]的约束，则可能与[getSize]返回的值不同。
  /// “childSize”参数是子对象的大小，它将满足[getConstraintsForChild]返回的约束。
  /// 默认情况下，将子对象定位在父对象的左上角。
  @override
  Offset getPositionForChild(Size size, Size childSize) {
    var isReverse = false;
    // 浮层在组件中的偏移
    double x, y;
    if (placement.isVertical()) {
      // VERTICAL DIRECTION
      var to = target.placement(placement);
      // 适合在下方显示
      final bool fitsBelow = to.dy + offset + childSize.height <= size.height - margin;
      // 适合在上方显示
      final bool fitsAbove = to.dy - offset - childSize.height >= margin;
      // 是否合适在下方显示
      final bool isBelow = placement.isBottom() ? fitsBelow || !fitsAbove : !(fitsAbove || !fitsBelow);
      if (isBelow) {
        isReverse = !placement.isBottom();
        y = math.min(target.bottom.dy + offset, size.height - margin);
      } else {
        isReverse = !placement.isTop();
        y = math.max(target.top.dy - offset - childSize.height, margin);
      }
      if (size.width < childSize.width) {
        // 子组件比窗口大
        var center = (size.width - childSize.width) / 2.0;
        x = placement.valueOf(
          topLeft: () => 0,
          bottomLeft: () => 0,
          top: () => center,
          bottom: () => center,
          topRight: () => 0,
          bottomRight: () => 0,
        )!;
      } else {
        if (placement.isTrue(topLeft: true, bottomLeft: true)) {
          final double normalizedTargetX = to.dx.clamp(margin, (size.width - margin - childSize.width).clamp(margin, size.width));
          x = normalizedTargetX;
        } else if (placement.isTrue(topRight: true, bottomRight: true)) {
          var normalizedTargetRight = to.dx.clamp(margin, size.width - margin);
          x = normalizedTargetRight - childSize.width;
        } else {
          final double normalizedTargetX = to.dx.clamp(margin, size.width - margin);
          final double edge = margin + childSize.width / 2.0;
          if (normalizedTargetX < edge) {
            x = margin;
          } else if (normalizedTargetX > size.width - edge) {
            x = size.width - margin - childSize.width;
          } else {
            x = normalizedTargetX - childSize.width / 2.0;
          }
        }
      }
    } else {
      // HORIZONTAL DIRECTION
      var to = target.placement(placement);
      // 适合在右方显示
      final bool fitsRight = to.dx + offset + childSize.width <= size.width - margin;
      // 适合在左方显示
      final bool fitsLeft = to.dx - offset - childSize.width >= margin;
      // 是否合适在右方显示
      final bool isRight = placement.isRight() ? fitsRight || !fitsLeft : !(fitsLeft || !fitsRight);
      if (isRight) {
        isReverse = !placement.isRight();
        x = math.min(target.right.dx + offset, size.width - margin);
      } else {
        isReverse = !placement.isLeft();
        x = math.min(target.left.dx - offset - childSize.width, size.width - childSize.width - margin);
      }

      if (size.height < childSize.height) {
        // 子组件比窗口大
        var center = (size.height - childSize.height) / 2.0;
        y = placement.valueOf(
          leftTop: () => 0,
          rightTop: () => 0,
          top: () => center,
          bottom: () => center,
          leftBottom: () => 0,
          rightBottom: () => 0,
        )!;
      } else {
        if (placement.isTrue(leftTop: true, rightTop: true)) {
          final double normalizedTargetY = to.dy.clamp(margin, (size.height - margin - childSize.height).clamp(margin, size.height));
          y = normalizedTargetY;
        } else if (placement.isTrue(leftBottom: true, rightBottom: true)) {
          var normalizedTargetY = to.dy.clamp(margin, size.height - margin);
          y = normalizedTargetY - childSize.height;
        } else {
          final double normalizedTargetY = to.dy.clamp(margin, size.height - margin);
          final double edge = margin + childSize.height / 2.0;
          if (normalizedTargetY < edge) {
            y = margin;
          } else if (normalizedTargetY > size.height - edge) {
            y = size.height - margin - childSize.height;
          } else {
            y = normalizedTargetY - childSize.height / 2.0;
          }
        }
      }
    }
    _offset = Offset(x, y);
    callback?.call(isReverse);
    return _offset!;
  }

  @override
  bool shouldRelayout(_PopupPositionDelegate oldDelegate) {
    return target != oldDelegate.target || offset != oldDelegate.offset || placement != oldDelegate.placement || margin != oldDelegate.margin;
  }
}
