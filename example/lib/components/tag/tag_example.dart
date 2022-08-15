import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 标签示例
class TagExample extends StatefulWidget {
  const TagExample({Key? key}) : super(key: key);

  @override
  State<TagExample> createState() => _TagExampleState();
}

class _TagExampleState extends State<TagExample> {
  @override
  Widget build(BuildContext context) {
    return const TSpace(
      direction: Axis.vertical,
      children: [
        TTag(
          child: Text('标签'),
        ),
        TSpace(
          children: [
            TTag(
              theme: TTagTheme.primary,
              child: Text('标签'),
            ),
            TTag(
              theme: TTagTheme.primary,
              variant: TTagVariant.light,
              child: Text('标签'),
            ),
            TTag(
              theme: TTagTheme.primary,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
          ],
        ),
        TSpace(
          children: [
            TTag(
              theme: TTagTheme.success,
              child: Text('标签'),
            ),
            TTag(
              theme: TTagTheme.success,
              variant: TTagVariant.light,
              child: Text('标签'),
            ),
            TTag(
              theme: TTagTheme.success,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
          ],
        ),
        TSpace(
          children: [
            TTag(
              theme: TTagTheme.warning,
              child: Text('标签'),
            ),
            TTag(
              theme: TTagTheme.warning,
              variant: TTagVariant.light,
              child: Text('标签'),
            ),
            TTag(
              theme: TTagTheme.warning,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
          ],
        ),
        TSpace(
          children: [
            TTag(
              theme: TTagTheme.danger,
              child: Text('标签'),
            ),
            TTag(
              theme: TTagTheme.danger,
              variant: TTagVariant.light,
              child: Text('标签'),
            ),
            TTag(
              theme: TTagTheme.danger,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
          ],
        ),
      ],
    );
  }
}
