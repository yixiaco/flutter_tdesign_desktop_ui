import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 弹出层主题数据
class TCheckboxThemeData with Diagnosticable {
  const TCheckboxThemeData({
    this.disabled,
    this.indeterminate,
    this.label,
    this.readonly,
  });

  /// 是否禁用
  final bool? disabled;

  /// 是否半选
  final bool? indeterminate;

  /// 主文案
  final Widget? label;

  /// 是否只读
  final bool? readonly;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TCheckboxThemeData &&
          runtimeType == other.runtimeType &&
          disabled == other.disabled &&
          indeterminate == other.indeterminate &&
          label == other.label &&
          readonly == other.readonly;

  @override
  int get hashCode => disabled.hashCode ^ indeterminate.hashCode ^ label.hashCode ^ readonly.hashCode;
}

/// 弹出层主题
class TCheckboxTheme extends InheritedTheme {
  final TCheckboxThemeData data;

  const TCheckboxTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

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
