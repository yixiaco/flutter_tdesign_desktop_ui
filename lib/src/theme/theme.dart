import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'theme_data.dart';

/// 颜色主题
class TTheme extends InheritedTheme {
  const TTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// 颜色主题数据
  final TThemeData data;

  /// 默认主题
  static final TThemeData _kFallbackTheme = TThemeData.light();

  /// 来自封闭给定上下文的最近主题实例的数据
  static TThemeData of(BuildContext context) {
    final TTheme? theme = context.dependOnInheritedWidgetOfExactType<TTheme>();
    return theme?.data ?? _kFallbackTheme;
  }

  @override
  bool updateShouldNotify(TTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TTheme(data: data, child: child);
  }
}
