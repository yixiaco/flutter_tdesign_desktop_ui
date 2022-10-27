import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

abstract class AnimationChangeNotifierPainter extends ChangeNotifier implements CustomPainter {
  Animation<double> get t => _t!;
  Animation<double>? _t;

  set t(Animation<double> value) {
    if (value == _t) {
      return;
    }
    _t?.removeListener(notifyListeners);
    value.addListener(notifyListeners);
    _t = value;
    notifyListeners();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  bool? hitTest(Offset position) => null;

  @override
  SemanticsBuilderCallback? get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

  @override
  String toString() => describeIdentity(this);

  @override
  void dispose() {
    super.dispose();
    _t?.removeListener(notifyListeners);
  }
}
