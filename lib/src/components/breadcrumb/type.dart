import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 面包屑项
class TBreadcrumbItemProps {
  /// 子组件
  final Widget child;

  /// 是否禁用当前项点击
  final bool disabled;

  /// 最大宽度
  final double? maxWidth;

  /// 外部链接地址
  final String? href;

  /// 路由跳转是否采用覆盖的方式
  final bool replace;

  /// 路由对象。如果项目存在 Router，则默认使用 Router
  final NavigatorState? router;

  /// 链接或路由跳转方式
  final TLinkTarget target;

  /// 路由跳转目标
  final String? to;

  /// 点击事件
  final GestureTapCallback? onClick;

  const TBreadcrumbItemProps({
    required this.child,
    this.disabled = false,
    this.maxWidth,
    this.href,
    this.replace = false,
    this.router,
    this.target = TLinkTarget.self,
    this.to,
    this.onClick,
  });
}

/// 面包屑组件风格
enum TBreadcrumbTheme {
  light;
}

