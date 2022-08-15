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
        TSpace(
          children: [
            TTag(
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              child: Text('标签'),
            ),
            TTag(
              disabled: true,
              child: Text('标签'),
            ),
          ],
        ),
        TSpace(
          children: [
            TTag(
              closable: true,
              theme: TTagTheme.primary,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              theme: TTagTheme.primary,
              variant: TTagVariant.light,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              theme: TTagTheme.primary,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              disabled: true,
              theme: TTagTheme.primary,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
          ],
        ),
        TSpace(
          children: [
            TTag(
              closable: true,
              theme: TTagTheme.success,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              theme: TTagTheme.success,
              variant: TTagVariant.light,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              theme: TTagTheme.success,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              disabled: true,
              theme: TTagTheme.success,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
          ],
        ),
        TSpace(
          children: [
            TTag(
              closable: true,
              theme: TTagTheme.warning,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              theme: TTagTheme.warning,
              variant: TTagVariant.light,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              theme: TTagTheme.warning,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              disabled: true,
              theme: TTagTheme.warning,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
          ],
        ),
        TSpace(
          children: [
            TTag(
              closable: true,
              theme: TTagTheme.danger,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              theme: TTagTheme.danger,
              variant: TTagVariant.light,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              theme: TTagTheme.danger,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              disabled: true,
              theme: TTagTheme.danger,
              variant: TTagVariant.outline,
              child: Text('标签'),
            ),
          ],
        ),
        TSpace(
          children: [
            TTag(
              theme: TTagTheme.primary,
              shape: TTagShape.square,
              child: Text('标签一'),
            ),
            TTag(
              theme: TTagTheme.primary,
              shape: TTagShape.round,
              child: Text('标签一'),
            ),
            TTag(
              theme: TTagTheme.primary,
              shape: TTagShape.mark,
              child: Text('标签一'),
            )
          ],
        ),
      ],
    );
  }
}
