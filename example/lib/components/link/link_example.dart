import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 跳转链接示例
class TLinkExample extends StatelessWidget {
  const TLinkExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TSpace(
      direction: Axis.vertical,
      children: [
        TSpace(
          children: [
            TLink(
              prefixIcon: Icon(TIcons.link),
              child: Text('跳转链接'),
            ),
            TLink(
              prefixIcon: Icon(TIcons.link),
              underline: true,
              hover: TLinkHover.color,
              child: Text('跳转链接'),
            ),
            TLink(
              prefixIcon: Icon(TIcons.link),
              hover: TLinkHover.color,
              child: Text('跳转链接'),
            ),
            TLink(
              prefixIcon: Icon(TIcons.link),
              disabled: true,
              underline: true,
              child: Text('跳转链接'),
            ),
          ],
        ),
        TSpace(
          children: [
            TLink(
              theme: TLinkTheme.primary,
              prefixIcon: Icon(TIcons.link),
              suffixIcon: Icon(TIcons.jump),
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.primary,
              prefixIcon: Icon(TIcons.link),
              underline: true,
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.primary,
              prefixIcon: Icon(TIcons.link),
              hover: TLinkHover.color,
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.primary,
              prefixIcon: Icon(TIcons.link),
              disabled: true,
              child: Text('跳转链接'),
            ),
          ],
        ),
        TSpace(
          children: [
            TLink(
              theme: TLinkTheme.warning,
              prefixIcon: Icon(TIcons.link),
              suffixIcon: Icon(TIcons.jump),
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.warning,
              prefixIcon: Icon(TIcons.link),
              underline: true,
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.warning,
              prefixIcon: Icon(TIcons.link),
              hover: TLinkHover.color,
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.warning,
              prefixIcon: Icon(TIcons.link),
              disabled: true,
              child: Text('跳转链接'),
            ),
          ],
        ),
        TSpace(
          children: [
            TLink(
              theme: TLinkTheme.danger,
              prefixIcon: Icon(TIcons.link),
              suffixIcon: Icon(TIcons.jump),
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.danger,
              prefixIcon: Icon(TIcons.link),
              underline: true,
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.danger,
              prefixIcon: Icon(TIcons.link),
              hover: TLinkHover.color,
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.danger,
              prefixIcon: Icon(TIcons.link),
              disabled: true,
              child: Text('跳转链接'),
            ),
          ],
        ),
        TSpace(
          children: [
            TLink(
              theme: TLinkTheme.success,
              prefixIcon: Icon(TIcons.link),
              suffixIcon: Icon(TIcons.jump),
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.success,
              prefixIcon: Icon(TIcons.link),
              underline: true,
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.success,
              prefixIcon: Icon(TIcons.link),
              hover: TLinkHover.color,
              child: Text('跳转链接'),
            ),
            TLink(
              theme: TLinkTheme.success,
              prefixIcon: Icon(TIcons.link),
              disabled: true,
              child: Text('跳转链接'),
            ),
          ],
        ),
      ],
    );
  }
}
