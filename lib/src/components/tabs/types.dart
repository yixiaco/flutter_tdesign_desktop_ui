import 'package:flutter/widgets.dart';

/// 选项卡位置
enum TTabsPlacement {
  /// 上
  top,

  /// 下
  bottom,

  /// 左
  left,

  /// 右
  right;
}

/// 选项卡风格
enum TTabsTheme {
  /// 默认风格
  normal,

  /// 卡片风格
  card;
}

/// 选项卡面板
class TTabsPanel<T> {

  const TTabsPanel({
    this.destroyOnHide = true,
    required this.label,
    this.disabled = false,
    this.panel,
    this.removable = false,
    required this.value,
    this.onRemove,
  });

  /// 选项卡内容隐藏时是否销毁
  final bool destroyOnHide;

  /// 选项卡名称，可自定义选项卡导航内容。
  final Widget label;

  /// 是否禁用选项卡
  final bool disabled;

  /// 用于自定义选项卡面板内容
  final Widget? panel;

  /// 当前选项卡是否允许移除
  final bool removable;

  /// 选项卡的值，唯一标识
  final T value;

  /// 点击删除按钮时触发
  final void Function(T)? onRemove;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TTabsPanel &&
          runtimeType == other.runtimeType &&
          destroyOnHide == other.destroyOnHide &&
          label == other.label &&
          disabled == other.disabled &&
          panel == other.panel &&
          removable == other.removable &&
          value == other.value &&
          onRemove == other.onRemove;

  @override
  int get hashCode =>
      destroyOnHide.hashCode ^ label.hashCode ^ disabled.hashCode ^ panel.hashCode ^ removable.hashCode ^ value.hashCode ^ onRemove.hashCode;
}