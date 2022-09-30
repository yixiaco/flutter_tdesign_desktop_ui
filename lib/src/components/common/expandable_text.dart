import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 判断文本是否展开
class TExpandableText extends StatelessWidget {
  const TExpandableText({
    Key? key,
    required this.text,
    required this.builder,
    this.style,
    this.maxLines,
  }) : super(key: key);

  /// 判断的子组件
  final String text;

  /// 最大行数
  final int? maxLines;

  /// 样式
  final TextStyle? style;

  /// 构建器
  final Widget Function(BuildContext context, Widget child, bool isExpandable) builder;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        TextPainter textPainter;
        if (maxLines != null && maxLines! > 0) {
          textPainter = TextPainter(text: TextSpan(text: text, style: style), textDirection: theme.textDirection, maxLines: maxLines);
        } else {
          textPainter = TextPainter(text: TextSpan(text: text, style: style), textDirection: theme.textDirection);
        }
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: constraints.maxWidth);
        return builder(context, Text.rich(TextSpan(text: text, style: style)), textPainter.didExceedMaxLines);
      },
    );
  }
}
