import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 组件大小
final sizeProvider = StateProvider<TComponentSize>((ref) {
  return TComponentSize.medium;
});
