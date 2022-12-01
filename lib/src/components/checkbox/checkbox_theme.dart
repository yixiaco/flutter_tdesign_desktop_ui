import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层主题数据
class TCheckboxThemeData with Diagnosticable {
  const TCheckboxThemeData({
    this.label,
  });

  /// 主文案
  final Widget? label;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TCheckboxThemeData &&
          runtimeType == other.runtimeType &&
          label == other.label;

  @override
  int get hashCode => label.hashCode;
}

/// 弹出层主题
class TCheckboxTheme extends InheritedTheme {
  final TCheckboxThemeData data;

  const TCheckboxTheme({
    super.key,
    required this.data,
    required super.child,
  });

  /// 来自封闭给定上下文的最近主题实例的数据
  static TCheckboxThemeData of(BuildContext context) {
    final TCheckboxTheme? theme = context.dependOnInheritedWidgetOfExactType<TCheckboxTheme>();
    return theme?.data ?? TTheme.of(context).checkboxThemeData;
  }

  @override
  bool updateShouldNotify(TCheckboxTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TCheckboxTheme(data: data, child: child);
  }
}
