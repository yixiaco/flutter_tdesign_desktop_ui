part of '../popup.dart';

/// 浮层偏移对象
class _PopupOffset {
  /// 上
  Offset top;

  /// 左
  Offset left;

  /// 右
  Offset right;

  /// 下
  Offset bottom;

  /// 上左
  Offset topLeft;

  /// 上右
  Offset topRight;

  /// 下左
  Offset bottomLeft;

  /// 下右
  Offset bottomRight;

  /// 左上
  Offset leftTop;

  /// 左下
  Offset leftBottom;

  /// 右上
  Offset rightTop;

  /// 右下
  Offset rightBottom;

  _PopupOffset({
    required this.top,
    required this.left,
    required this.right,
    required this.bottom,
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRight,
    required this.leftTop,
    required this.leftBottom,
    required this.rightTop,
    required this.rightBottom,
  });

  factory _PopupOffset.of(Size size, Offset offset) {
    // 父坐标系中的位置
    final Offset top = size.topCenter(offset);
    final Offset left = size.centerLeft(offset);
    final Offset right = size.centerRight(offset);
    final Offset bottom = size.bottomCenter(offset);
    final Offset topLeft = size.topLeft(offset);
    final Offset topRight = size.topRight(offset);
    final Offset bottomLeft = size.bottomLeft(offset);
    final Offset bottomRight = size.bottomRight(offset);
    return _PopupOffset(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
      leftTop: topLeft,
      leftBottom: bottomLeft,
      rightTop: topRight,
      rightBottom: bottomRight,
    );
  }

  /// 根据浮层出现位置，返回相应的[Offset]
  Offset placement(TPopupPlacement placement) {
    switch (placement) {
      case TPopupPlacement.top:
        return top;
      case TPopupPlacement.left:
        return left;
      case TPopupPlacement.right:
        return right;
      case TPopupPlacement.bottom:
        return bottom;
      case TPopupPlacement.topLeft:
        return topLeft;
      case TPopupPlacement.topRight:
        return topRight;
      case TPopupPlacement.bottomLeft:
        return bottomLeft;
      case TPopupPlacement.bottomRight:
        return bottomRight;
      case TPopupPlacement.leftTop:
        return leftTop;
      case TPopupPlacement.leftBottom:
        return leftBottom;
      case TPopupPlacement.rightTop:
        return rightTop;
      case TPopupPlacement.rightBottom:
        return rightBottom;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _PopupOffset &&
          runtimeType == other.runtimeType &&
          top == other.top &&
          left == other.left &&
          right == other.right &&
          bottom == other.bottom &&
          topLeft == other.topLeft &&
          topRight == other.topRight &&
          bottomLeft == other.bottomLeft &&
          bottomRight == other.bottomRight &&
          leftTop == other.leftTop &&
          leftBottom == other.leftBottom &&
          rightTop == other.rightTop &&
          rightBottom == other.rightBottom;

  @override
  int get hashCode =>
      top.hashCode ^
      left.hashCode ^
      right.hashCode ^
      bottom.hashCode ^
      topLeft.hashCode ^
      topRight.hashCode ^
      bottomLeft.hashCode ^
      bottomRight.hashCode ^
      leftTop.hashCode ^
      leftBottom.hashCode ^
      rightTop.hashCode ^
      rightBottom.hashCode;
}
