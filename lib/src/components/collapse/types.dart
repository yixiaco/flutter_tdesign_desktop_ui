import 'package:flutter/widgets.dart';

/// 展开图标的位置，左侧或右侧。
enum TCollapseExpandIconPlacement {
  /// 左侧
  left,

  /// 右侧
  right;
}

/// 折叠面板属性
class TCollapsePanel<T> {
  const TCollapsePanel({
    this.content,
    this.destroyOnCollapse = false,
    this.disabled,
    this.expandIcon,
    this.header,
    this.headerRightContent,
    this.value,
  });

  /// 折叠面板内容
  final Widget? content;

  /// 当前面板处理折叠状态时，是否销毁面板内容
  final bool destroyOnCollapse;

  /// 禁止当前面板展开，优先级大于 Collapse 的同名属性
  final bool? disabled;

  /// 当前折叠面板展开图标，优先级大于 Collapse 的同名属性
  final Widget? expandIcon;

  /// 面板头内容。
  final Widget? header;

  ///	面板头的右侧区域，一般用于呈现面板操作。
  final Widget? headerRightContent;

  /// 当前面板唯一标识，如果值为空则取当前面下标兜底作为唯一标识
  final T? value;
}
