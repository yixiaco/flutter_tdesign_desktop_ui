part of '../popup.dart';

/// 管理多层级
class _PopupLevelNotifier extends ChangeNotifier {
  _PopupLevelNotifier(this.children);

  /// 所有显示的子浮层
  final Set<GlobalKey<_PopupOverlayState>> children;

  void addOverlay(GlobalKey<_PopupOverlayState> key) {
    if (children.add(key)) {
      notifyListeners();
    }
  }

  void removeOverlay(GlobalKey<_PopupOverlayState> key) {
    if (children.remove(key)) {
      notifyListeners();
    }
  }
}

/// 管理多层级
class _PopupLevel extends InheritedTheme {
  final _PopupOverlayState overlayState;
  final _PopupLevelNotifier popupLevel;

  const _PopupLevel({
    required this.overlayState,
    required this.popupLevel,
    required super.child,
  });

  /// 来自封闭给定上下文的最近主题实例的数据
  static _PopupLevel? of(BuildContext context) {
    final _PopupLevel? popupLevel = context.dependOnInheritedWidgetOfExactType<_PopupLevel>();
    return popupLevel;
  }

  @override
  bool updateShouldNotify(_PopupLevel oldWidget) {
    return popupLevel != oldWidget.popupLevel || overlayState != oldWidget.overlayState;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return _PopupLevel(
      overlayState: overlayState,
      popupLevel: popupLevel,
      child: child,
    );
  }
}
