import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 是否显示语义
final semanticsProvider = StateProvider<bool>((ref) {
  return false;
});
