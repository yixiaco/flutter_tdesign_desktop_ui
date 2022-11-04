import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

extension StateExtension on State {

  /// 安全更新
  void safeUpdate([VoidCallback? callback]) {
    if (SchedulerBinding.instance.schedulerPhase == SchedulerPhase.persistentCallbacks) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        if (mounted) {
          // ignore: invalid_use_of_protected_member
          setState(() {
            callback?.call();
          });
        }
      });
    } else {
      // ignore: invalid_use_of_protected_member
      setState(() {
        callback?.call();
      });
    }
  }
}