import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 国际化
final localeProvider = StateProvider<Locale>((ref) {
  return const Locale('zh', 'CN');
});
