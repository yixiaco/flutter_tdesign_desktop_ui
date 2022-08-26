part of 'tabs.dart';

/// 标签 normal模式下的下划线 painter
class _LabelPainter extends AnimationChangeNotifierPainter {
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

  double get strokeWidth => _strokeWidth!;
  double? _strokeWidth;

  set strokeWidth(double value) {
    if (value == _strokeWidth) {
      return;
    }
    _strokeWidth = value;
    notifyListeners();
  }

  TTabsPlacement get placement => _placement!;
  TTabsPlacement? _placement;

  set placement(TTabsPlacement value) {
    if (value == _placement) {
      return;
    }
    _placement = value;
    notifyListeners();
  }

  List<GlobalKey> get tabKeys => _tabKeys!;
  List<GlobalKey>? _tabKeys;

  set tabKeys(List<GlobalKey> value) {
    if (value == _tabKeys) {
      return;
    }
    _tabKeys = value;
    notifyListeners();
  }

  GlobalKey get painterKey => _painterKey!;
  GlobalKey? _painterKey;

  set painterKey(GlobalKey value) {
    if (value == _painterKey) {
      return;
    }
    _painterKey = value;
    notifyListeners();
  }

  Offset _keyOffset(GlobalKey key) {
    var box = key.currentContext!.findRenderObject() as RenderBox;
    var currentBox = painterKey.currentContext!.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero) - currentBox.localToGlobal(Offset.zero);
  }

  Offset get offset {
    if (index >= 0) {
      return _keyOffset(tabKeys[index]);
    }
    return _keyOffset(tabKeys[index]);
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = color;
    if (index == -1) {
      if (_currentRect != null) {
        var rect = Rect.lerp(_originOffset() & Size.zero, _currentRect, t.value);
        canvas.drawRRect(RRect.fromRectAndRadius(rect!, Radius.circular(TVar.borderRadiusDefault)), paint);
        if (t.value == 0) {
          _currentRect = null;
        }
      }
      return;
    }
    var tabKey = tabKeys[index];
    var optionWidth = tabKey.currentContext!.size!.width;
    var optionHeight = tabKey.currentContext!.size!.height;
    var rect = Rect.fromLTWH(offset.dx, offset.dy, optionWidth, optionHeight);
    _currentRect = _currentPlacementRect(rect);

    var oldRect = _oldRect ?? _originOffset() & Size.zero;
    var rectLerp = Rect.lerp(oldRect, _currentRect, t.value);
    canvas.drawRect(rectLerp!, paint);
  }

  Offset _originOffset() {
    switch (placement) {
      case TTabsPlacement.top:
        return _currentRect!.bottomLeft;
      case TTabsPlacement.bottom:
        return _currentRect!.topLeft;
      case TTabsPlacement.left:
        return _currentRect!.topRight;
      case TTabsPlacement.right:
        return _currentRect!.topLeft;
    }
  }

  Rect _currentPlacementRect(Rect rect) {
    switch (placement) {
      case TTabsPlacement.top:
        return Rect.fromLTWH(rect.left, rect.bottom - strokeWidth, rect.width, strokeWidth);
      case TTabsPlacement.bottom:
        return Rect.fromLTWH(rect.left, rect.top, rect.width, strokeWidth);
      case TTabsPlacement.left:
        return Rect.fromLTWH(rect.right - strokeWidth, rect.top, strokeWidth, rect.height);
      case TTabsPlacement.right:
        return Rect.fromLTWH(0, rect.top, strokeWidth, rect.height);
    }
  }

  @override
  bool shouldRepaint(covariant _LabelPainter oldDelegate) {
    return this != oldDelegate;
  }
}

/// 标签轨道
class _TabLabelTrackPainter extends CustomPainter {
  const _TabLabelTrackPainter({
    required this.trackColor,
    required this.strokeWidth,
    required this.placement,
    required this.tabKeys,
    required this.painterKey,
  });
  /// 轨道颜色
  final Color trackColor;
  /// 轨道宽度
  final double strokeWidth;
  /// 方向
  final TTabsPlacement placement;
  /// 标签key
  final List<GlobalKey> tabKeys;
  /// 画布key
  final GlobalKey painterKey;

  Offset _keyOffset(GlobalKey key) {
    var box = key.currentContext!.findRenderObject() as RenderBox;
    var currentBox = painterKey.currentContext!.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero) - currentBox.localToGlobal(Offset.zero);
  }

  Rect _trackPlacementRect(Size size) {
    var lastLabKey = tabKeys[tabKeys.length - 1];
    var startOffset = _keyOffset(tabKeys[0]);
    var offset = _keyOffset(lastLabKey);
    var width = lastLabKey.currentContext!.size!.width;
    var height = lastLabKey.currentContext!.size!.height;
    var maxWidth = offset.dx + width;
    var maxHeight = offset.dy + height;
    switch (placement) {
      case TTabsPlacement.top:
        return Rect.fromLTWH(startOffset.dx, maxHeight - strokeWidth, size.width, strokeWidth);
      case TTabsPlacement.bottom:
        return Rect.fromLTWH(startOffset.dx, startOffset.dy, size.width, strokeWidth);
      case TTabsPlacement.left:
        return Rect.fromLTWH(maxWidth - strokeWidth, startOffset.dy, strokeWidth, maxHeight);
      case TTabsPlacement.right:
        return Rect.fromLTWH(0, 0, strokeWidth, maxHeight);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = trackColor;
    canvas.drawRect(_trackPlacementRect(size), paint);
  }

  @override
  bool shouldRepaint(covariant _TabLabelTrackPainter oldDelegate) {
    return true;
  }

}