import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';

abstract class AnimationChangeNotifierPainter extends ChangeNotifier implements CustomPainter {
  Animation<double> get animation => _animation!;
  Animation<double>? _animation;

  set animation(Animation<double> value) {
    if (value == _animation) {
      return;
    }
    _animation?.removeListener(notifyListeners);
    value.addListener(notifyListeners);
    _animation = value;
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
  @mustCallSuper
  void dispose() {
    super.dispose();
    _animation?.removeListener(notifyListeners);
  }
}
