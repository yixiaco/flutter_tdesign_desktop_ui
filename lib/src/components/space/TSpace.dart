import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 间距
class TSpace extends StatelessWidget {
  /// 间距组件
  const TSpace({
    Key? key,
    this.children = const <Widget?>[],
    this.direction = Axis.horizontal,
    this.align = WrapAlignment.start,
    this.spacing,
    this.runAlign = WrapAlignment.start,
    this.runSpacing,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.clipBehavior = Clip.none,
    this.separator,
    this.size,
  }) : super(key: key);

  /// 间距方向
  final Axis direction;

  /// 主轴对齐方式
  final WrapAlignment align;

  /// 主轴
  final WrapAlignment runAlign;

  /// 子组件
  final List<Widget?> children;

  /// 分隔符
  final Widget? separator;

  /// 主轴方向间距
  final double? spacing;

  /// 交叉轴方向间距
  final double? runSpacing;

  /// 交叉轴对齐方式
  final WrapCrossAlignment crossAxisAlignment;

  /// 文本方向
  final TextDirection? textDirection;

  /// 确定垂直布局子项的顺序是向上或者向下
  final VerticalDirection verticalDirection;

  /// 将根据此选项剪切（或不剪切）内容
  final Clip clipBehavior;

  /// 间距大小，如果设置了[spacing]和[runSpacing]则不会使该属性生效
  final TComponentSize? size;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var componentSize = size ?? theme.size;
    var spacer = componentSize.lazySizeOf(
      small: () => ThemeDataConstant.spacer,
      medium: () => ThemeDataConstant.spacer2,
      large: () => ThemeDataConstant.spacer3,
    );

    // 过滤不为空的小部件
    List<Widget> list = children.where((element) => element != null).map((e) => e!).toList();

    // 分隔符小部件
    if (separator != null) {
      list = list.expand((element) => [element, separator]).map((e) => e!).toList();
      list.removeLast();
    }

    return Wrap(
      alignment: align,
      direction: direction,
      crossAxisAlignment: crossAxisAlignment,
      clipBehavior: clipBehavior,
      runAlignment: runAlign,
      runSpacing: runSpacing ?? spacer,
      spacing: spacing ?? spacer,
      textDirection: textDirection ?? theme.textDirection,
      verticalDirection: verticalDirection,
      children: list,
    );
  }
}
