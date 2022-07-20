import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 栅格间隔
class TGutter {
  /// < 768
  final double? xs;
  /// < 992
  final double? sm;
  /// < 1200
  final double? md;
  /// < 1400
  final double? lg;
  /// < 1880
  final double? xl;
  /// >= 1800
  final double? xxl;

  /// 设置其中一个栅格间隔大小
  const TGutter.only({this.xs, this.sm, this.md, this.lg, this.xl, this.xxl});

  /// 全部设置为统一的栅格间隔大小
  const TGutter.all(double gutter)
      : xs = gutter,
        sm = gutter,
        md = gutter,
        lg = gutter,
        xl = gutter,
        xxl = gutter;

  /// 根据窗口宽度得到栅格大小
  double gutter(BuildContext context) {
    var layoutSize = TLayoutSize.of(context);
    switch (layoutSize) {
      case TLayoutSize.xxl:
        if (xxl == null) continue xl;
        return xxl!;
      xl:
      case TLayoutSize.xl:
        if (xl == null) continue lg;
        return xl!;
      lg:
      case TLayoutSize.lg:
        if (lg == null) continue md;
        return lg!;
      md:
      case TLayoutSize.md:
        if (md == null) continue sm;
        return md!;
      sm:
      case TLayoutSize.sm:
        if (sm == null) continue xs;
        return sm!;
      xs:
      case TLayoutSize.xs:
        return xs ?? 0;
    }
  }
}

/// 水平栅格
class TRow extends StatelessWidget {
  const TRow({
    Key? key,
    this.mainAxisAlignment = WrapAlignment.start,
    this.crossAlignment = WrapCrossAlignment.center,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline, // NO DEFAULT: we don't know what the text's baseline should be
    this.gutter = const TGutter.all(0),
    this.clipBehavior = Clip.none,
    this.runAlignment = WrapAlignment.start,
    this.runGutter = const TGutter.all(0),
    this.children = const <TCol>[],
  }) : super(key: key);

  ///子项应如何放置在主轴上
  final WrapAlignment mainAxisAlignment;

  /// 子项应如何在横轴上相对彼此对齐
  final WrapCrossAlignment crossAlignment;

  /// 文本方向
  final TextDirection? textDirection;

  /// 垂直方向
  final VerticalDirection verticalDirection;

  /// 文本基线。用于对齐文本的水平线
  final TextBaseline? textBaseline;

  /// 栅格间隔，示例：{ xs: 8, sm: 16, md: 24}。当数据类型为 Number 和 Object 时，用于指定横向间隔。
  final TGutter gutter;

  /// 垂直方向栅格间隔，当数据类型为 Number 和 Object 时，用于指定横向间隔。
  final TGutter runGutter;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  final Clip clipBehavior;

  /// How the runs themselves should be placed in the cross axis.
  ///
  /// For example, if [runAlignment] is [WrapAlignment.center], the runs are
  /// grouped together in the center of the overall [Wrap] in the cross axis.
  ///
  /// Defaults to [WrapAlignment.start].
  ///
  /// See also:
  ///
  ///  * [alignment], which controls how the children within each run are placed
  ///    relative to each other in the main axis.
  ///  * [crossAxisAlignment], which controls how the children within each run
  ///    are placed relative to each other in the cross axis.
  final WrapAlignment runAlignment;

  /// 子项
  final List<TCol> children;

  @override
  Widget build(BuildContext context) {
    var g = gutter.gutter(context);
    return LayoutBuilder(builder: (context, constraints) {
      var maxWidth = constraints.maxWidth + g;
      var list = <Widget>[];
      children.sort((a, b) => a.order - b.order);
      for (int i = 0; i < children.length; i++) {
        var child = children[i];
        var span = child.span.getSpan(context);
        var offset = child.offset.getSpan(context);
        Widget child2 = SizedBox(
            width: span / 12 * maxWidth,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: g / 2),
              child: child,
            ),
          );

        if(offset > 0) {
          child2 = Padding(
            padding: EdgeInsets.only(left: offset > 0 ? offset / 12 * maxWidth : 0),
            child: child2,
          );
        }
        list.add(child2);
      }

      return OverflowBox(
        alignment: FractionalOffset.topCenter,
        maxWidth: maxWidth,
        minWidth: maxWidth,
        child: Wrap(
          alignment: mainAxisAlignment,
          crossAxisAlignment: crossAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          direction: Axis.horizontal,
          clipBehavior: clipBehavior,
          runAlignment: runAlignment,
          runSpacing: runGutter.gutter(context),
          children: list,
        ),
      );
    });
  }
}

/// 栅格列间隔格数
class TColSpan {
  /// < 768
  final int? xs;
  /// < 992
  final int? sm;
  /// < 1200
  final int? md;
  /// < 1400
  final int? lg;
  /// < 1880
  final int? xl;
  /// >= 1800
  final int? xxl;

  /// 设置其中一个栅格间隔格数
  const TColSpan.only({this.xs, this.sm, this.md, this.lg, this.xl, this.xxl})
      : assert(xs == null || xs <= 12, 'xs的最大值为12'),
        assert(sm == null || sm <= 12, 'sm的最大值为12'),
        assert(md == null || md <= 12, 'md的最大值为12'),
        assert(lg == null || lg <= 12, 'lg的最大值为12'),
        assert(xl == null || xl <= 12, 'xl的最大值为12'),
        assert(xxl == null || xxl <= 12, 'xxl的最大值为12');

  /// 全部设置为统一的栅格间隔格数
  const TColSpan.span(int span)
      : assert(span <= 12, 'span的最大值为12'),
        xs = span,
        sm = span,
        md = span,
        lg = span,
        xl = span,
        xxl = span;

  /// 根据窗口宽度得到栅格间隔格数
  int getSpan(BuildContext context) {
    var layoutSize = TLayoutSize.of(context);
    switch (layoutSize) {
      case TLayoutSize.xxl:
        if (xxl == null) continue xl;
        return xxl!;
      xl:
      case TLayoutSize.xl:
        if (xl == null) continue lg;
        return xl!;
      lg:
      case TLayoutSize.lg:
        if (lg == null) continue md;
        return lg!;
      md:
      case TLayoutSize.md:
        if (md == null) continue sm;
        return md!;
      sm:
      case TLayoutSize.sm:
        if (sm == null) continue xs;
        return sm!;
      xs:
      case TLayoutSize.xs:
        return xs ?? 0;
    }
  }
}

/// 栅格列
class TCol extends StatelessWidget {
  const TCol({
    Key? key,
    required this.child,
    required this.span,
    this.offset = const TColSpan.span(0),
    this.order = 0,
  }) : super(key: key);

  /// 子布局
  final Widget child;

  /// 栅格格数
  final TColSpan span;

  /// 栅格左侧的间隔格数
  final TColSpan offset;

  /// 顺序
  final int order;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
