import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 间距组件,控制组件之间的间距
/// [breakLine]为true时，内部使用[Wrap]实现
/// [breakLine]为false时，内部使用[Flex]实现
class TSpace extends StatelessWidget {
  /// 间距组件
  const TSpace({
    super.key,
    this.children = const <Widget?>[],
    this.direction = Axis.horizontal,
    this.align = MainAxisAlignment.start,
    this.spacing,
    this.runAlign = WrapAlignment.start,
    this.runSpacing,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.separator,
    this.size,
    this.breakLine = false,
    this.textBaseline,
    this.mainAxisSize = MainAxisSize.min,
  });

  /// 间距方向
  final Axis direction;

  /// 主轴对齐方式
  final MainAxisAlignment align;

  /// run的对齐方式。run可以理解为新的行或者列，如果在水平方向布局的话，run可以理解为新的一行
  /// [breakLine]为true时生效
  final WrapAlignment runAlign;

  /// 子组件
  final List<Widget?> children;

  /// 分隔符
  final Widget? separator;

  /// 主轴方向间距
  final double? spacing;

  /// 交叉轴方向间距.
  /// [breakLine]为true时生效
  final double? runSpacing;

  /// 交叉轴对齐方式.
  /// 如果[breakLine]为true时,则[stretch]、[baseline]属性不能生效
  final CrossAxisAlignment crossAxisAlignment;

  /// 文本方向
  final TextDirection? textDirection;

  /// 确定垂直布局子项的顺序是向上或者向下
  final VerticalDirection verticalDirection;

  /// 将根据此选项剪切（或不剪切）内容.
  final Clip clipBehavior;

  /// 间距大小.
  /// 如果设置了[spacing]和[runSpacing]则不会使该属性生效
  final TComponentSize? size;

  /// 是否自动换行
  final bool breakLine;

  /// 如果根据它们的基线对齐项目，则使用哪个基线。
  /// 如果使用基线对齐，则必须设置此项。没有默认值，因为框架无法先验地知道正确的基线
  /// [breakLine]为true时无效，因为没有一个有效的[CrossAxisAlignment.baseline]
  final TextBaseline? textBaseline;

  /// [breakLine]为false时生效
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var componentSize = size ?? theme.size;
    var spacer = componentSize.lazySizeOf(
      small: () => TVar.spacer,
      medium: () => TVar.spacer2,
      large: () => TVar.spacer3,
    );

    // 过滤不为空的小部件
    List<Widget> list = children.where((element) => element != null).map((e) => e!).toList();

    // 分隔符小部件
    if (separator != null) {
      list = list.expand((element) => [element, separator]).map((e) => e!).toList();
      list.removeLast();
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        var space = spacing ?? spacer;
        if (breakLine) {
          // wrap会给子组件宽度无限宽，这里重新设置最大宽度
          var children = list
              .map((e) => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                      maxHeight: constraints.maxHeight,
                    ),
                    child: e,
                  ))
              .toList();
          return ConstrainedBox(
            constraints: constraints,
            child: Wrap(
              alignment: wrapAlignment,
              direction: direction,
              crossAxisAlignment: wrapCrossAxisAlignment,
              clipBehavior: clipBehavior,
              runAlignment: runAlign,
              runSpacing: runSpacing ?? spacer,
              spacing: space,
              textDirection: textDirection ?? theme.textDirection,
              verticalDirection: verticalDirection,
              children: children,
            ),
          );
        } else {
          return Flex(
            direction: direction,
            mainAxisAlignment: align,
            mainAxisSize: mainAxisSize,
            crossAxisAlignment: crossAxisAlignment,
            textDirection: textDirection,
            verticalDirection: verticalDirection,
            clipBehavior: clipBehavior,
            textBaseline: textBaseline,
            spacing: space,
            children: list,
          );
        }
      },
    );
  }

  WrapCrossAlignment get wrapCrossAxisAlignment {
    switch (crossAxisAlignment) {
      case CrossAxisAlignment.start:
        return WrapCrossAlignment.start;
      case CrossAxisAlignment.end:
        return WrapCrossAlignment.end;
      case CrossAxisAlignment.center:
        return WrapCrossAlignment.center;
      case CrossAxisAlignment.stretch:
      case CrossAxisAlignment.baseline:
        return WrapCrossAlignment.start;
    }
  }

  WrapAlignment get wrapAlignment {
    switch (align) {
      case MainAxisAlignment.start:
        return WrapAlignment.start;
      case MainAxisAlignment.end:
        return WrapAlignment.end;
      case MainAxisAlignment.center:
        return WrapAlignment.center;
      case MainAxisAlignment.spaceBetween:
        return WrapAlignment.spaceBetween;
      case MainAxisAlignment.spaceAround:
        return WrapAlignment.spaceAround;
      case MainAxisAlignment.spaceEvenly:
        return WrapAlignment.spaceEvenly;
    }
  }
}
