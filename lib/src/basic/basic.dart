import 'package:flutter/widgets.dart';

/// 组件大小
enum TComponentSize {
  /// 小
  small,
  /// 中等
  medium,
  /// 大
  large;

  /// 根据给定的组件大小，返回对应的值
  T sizeOf<T>({required T small, required T medium, required T large}) {
    switch (this) {
      case TComponentSize.small:
        return small;
      case TComponentSize.medium:
        return medium;
      case TComponentSize.large:
        return large;
    }
  }
}

/// 布局大小
enum TLayoutSize {
  /// 0px	0px-768px 手机
  xs(0, 0, 768),

  /// 768px	768px-992px 平板
  sm(768, 768, 992),

  /// 992px-1200px 超小尺寸电脑
  md(992, 992, 1200),

  /// 1200px-1400px 小尺寸电脑
  lg(1200, 1200, 1400),
  // 1400px-1880px 中尺寸电脑
  xl(1400, 1400, 1880),
  // 1880px-N 大尺寸电脑
  xxl(1880, 1880, double.infinity);

  final double breakpoint;

  final double minBreakpoint;

  final double maxBreakpoint;

  const TLayoutSize(this.breakpoint, this.minBreakpoint, this.maxBreakpoint);

  static TLayoutSize of(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return values.firstWhere((element) {
      return element.minBreakpoint <= width && width < element.maxBreakpoint;
    }, orElse: () => TLayoutSize.lg);
  }
}
