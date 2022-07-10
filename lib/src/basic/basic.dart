import 'package:flutter/widgets.dart';

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
