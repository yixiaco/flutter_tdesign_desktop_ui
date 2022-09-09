import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 导航菜单抽象主题数据
abstract class TMenuThemeParentData with Diagnosticable {
  const TMenuThemeParentData({
    required this.headMenu,
    this.expandType,
    this.theme,
  });

  /// 是否是顶部菜单
  final bool headMenu;

  /// 二级菜单展开方式，平铺展开和浮层展开。
  final TMenuExpandType? expandType;

  /// 菜单风格
  final TMenuTheme? theme;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TMenuExpandType>('expandType', expandType, defaultValue: null));
    properties.add(DiagnosticsProperty<TMenuTheme>('theme', theme, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('headMenu', headMenu, defaultValue: null));
  }
}

/// 导航菜单主题数据
class TMenuThemeData extends TMenuThemeParentData {
  const TMenuThemeData({
    this.collapsed,
    this.expandMutex,
    TMenuExpandType? expandType,
    TMenuTheme? theme,
    this.width,
    this.foldingWidth,
  }) : super(headMenu: false, expandType: expandType, theme: theme);

  /// 是否收起菜单
  final bool? collapsed;

  /// 同级别互斥展开
  final bool? expandMutex;

  /// 菜单展开时的宽度
  final double? width;

  /// 菜单折叠时的宽度
  final double? foldingWidth;

  TMenuThemeData copyWith({
    bool? collapsed,
    bool? expandMutex,
    TMenuExpandType? expandType,
    TMenuTheme? theme,
    double? width,
    double? foldingWidth,
  }) {
    return TMenuThemeData(
      collapsed: collapsed ?? this.collapsed,
      expandMutex: expandMutex ?? this.expandMutex,
      expandType: expandType ?? this.expandType,
      theme: theme ?? this.theme,
      width: width ?? this.width,
      foldingWidth: foldingWidth ?? this.foldingWidth,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TMenuThemeData &&
          runtimeType == other.runtimeType &&
          collapsed == other.collapsed &&
          expandMutex == other.expandMutex &&
          expandType == other.expandType &&
          theme == other.theme &&
          width == other.width &&
          foldingWidth == other.foldingWidth &&
          headMenu == other.headMenu;

  @override
  int get hashCode =>
      collapsed.hashCode ^ expandMutex.hashCode ^ expandType.hashCode ^ theme.hashCode ^ width.hashCode ^ foldingWidth.hashCode ^ headMenu.hashCode;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('collapsed', collapsed, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('expandMutex', expandMutex, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('width', width, defaultValue: null));
    properties.add(DiagnosticsProperty<double>('foldingWidth', foldingWidth, defaultValue: null));
  }
}

/// 顶部导航菜单主题数据
class THeadMenuThemeData extends TMenuThemeParentData with Diagnosticable {
  const THeadMenuThemeData({
    TMenuExpandType? expandType,
    TMenuTheme? theme,
  }) : super(headMenu: true, expandType: expandType, theme: theme);

  THeadMenuThemeData copyWith({
    TMenuExpandType? expandType,
    TMenuTheme? theme,
  }) {
    return THeadMenuThemeData(
      expandType: expandType ?? this.expandType,
      theme: theme ?? this.theme,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is THeadMenuThemeData &&
          runtimeType == other.runtimeType &&
          expandType == other.expandType &&
          theme == other.theme &&
          headMenu == other.headMenu;

  @override
  int get hashCode => expandType.hashCode ^ theme.hashCode ^ headMenu.hashCode;
}

/// 默认导航菜单主题
class TDefaultMenuTheme<T extends TMenuThemeParentData> extends InheritedTheme {
  final T data;

  const TDefaultMenuTheme({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  /// 来自封闭给定上下文的最近主题实例的数据
  static TMenuThemeParentData? of(BuildContext context) {
    final TDefaultMenuTheme? theme = context.dependOnInheritedWidgetOfExactType<TDefaultMenuTheme>();
    return theme?.data;
  }

  /// 来自封闭给定上下文的最近主题实例的数据
  static TMenuThemeData menuOf(BuildContext context) {
    final TDefaultMenuTheme<TMenuThemeData>? theme = context.dependOnInheritedWidgetOfExactType<TDefaultMenuTheme<TMenuThemeData>>();
    return theme?.data ?? TTheme.of(context).menuThemeData;
  }

  /// 来自封闭给定上下文的最近主题实例的数据
  static THeadMenuThemeData headMenuOf(BuildContext context) {
    final TDefaultMenuTheme<THeadMenuThemeData>? theme = context.dependOnInheritedWidgetOfExactType<TDefaultMenuTheme<THeadMenuThemeData>>();
    return theme?.data ?? TTheme.of(context).headMenuThemeData;
  }

  @override
  bool updateShouldNotify(TDefaultMenuTheme oldWidget) {
    return data != oldWidget.data;
  }

  @override
  Widget wrap(BuildContext context, Widget child) {
    return TDefaultMenuTheme(data: data, child: child);
  }
}
