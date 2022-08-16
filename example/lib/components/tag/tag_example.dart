import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 标签示例
class TagExample extends StatefulWidget {
  const TagExample({Key? key}) : super(key: key);

  @override
  State<TagExample> createState() => _TagExampleState();
}

class _TagExampleState extends State<TagExample> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return TSpace(
      direction: Axis.vertical,
      children: [
        const TSpace(
          children: [
            TTag(
              icon: Icon(TIcons.discountFilled),
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              theme: TTagTheme.link,
              icon: Icon(TIcons.logoWecom),
              child: Text('标签'),
            ),
            TTag(
              closable: true,
              disabled: true,
              child: Text('标签'),
            ),
          ],
        ),
        const TSpace(
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
        const TSpace(
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
        const TSpace(
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
        const TSpace(
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
        const TSpace(
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
        TSpace(
          children: [
            TCheckTag(
              checked: checked,
              child: const Text('标签一'),
              onChange: (value) {
                setState(() {
                  checked = value;
                });
              },
            ),
            TCheckTag(
              disabled: true,
              checked: checked,
              child: const Text('标签一'),
            ),
          ],
        ),
      ],
    );
  }
}
