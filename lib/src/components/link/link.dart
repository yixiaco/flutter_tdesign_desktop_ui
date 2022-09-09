import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 链接
/// 文字超链接用于跳转一个新页面，如当前项目跳转，友情链接等
class TLink extends StatelessWidget {
  const TLink({
    Key? key,
    required this.child,
    this.disabled = false,
    this.hover = TLinkHover.underline,
    this.prefixIcon,
    this.size,
    this.suffixIcon,
    this.theme = TLinkTheme.defaultTheme,
    this.underline = false,
    this.onClick,
  }) : super(key: key);

  /// 子组件
  final Widget child;

  /// 是否禁用
  final bool disabled;

  /// 鼠标经过样式
  final TLinkHover hover;

  /// 前缀icon
  final Widget? prefixIcon;

  /// 组件大小
  final TComponentSize? size;

  /// 后缀icon
  final Widget? suffixIcon;

  /// 链接风格
  final TLinkTheme theme;

  /// 是否一直显示下划线
  final bool underline;

  /// 点击事件
  final GestureTapCallback? onClick;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var size = this.size ?? theme.size;
    Widget? prefix;
    Widget? suffix;

    double iconMargin = size.sizeOf(small: TVar.spacerS, medium: TVar.spacer1, large: TVar.spacerL);
    if (prefixIcon != null) {
      prefix = Padding(
        padding: EdgeInsets.only(right: iconMargin),
        child: prefixIcon,
      );
    }
    if (suffixIcon != null) {
      suffix = Padding(
        padding: EdgeInsets.only(left: iconMargin),
        child: suffixIcon,
      );
    }

    var textStyle = size.lazySizeOf(
      small: () => theme.fontData.fontLinkSmall,
      medium: () => theme.fontData.fontLinkMedium,
      large: () => theme.fontData.fontLinkLarge,
    );

    return TMaterialStateBuilder(
      builder: (context, states) {
        return DefaultTextStyle(
          style: textStyle,
          child: IconTheme(
            data: IconThemeData(size: textStyle.fontSize),
            child: AnimatedContainer(
              duration: TVar.animDurationBase,
              decoration: BoxDecoration(border: Border(bottom: BorderSide())),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (prefix != null) prefix,
                  child,
                  if (suffix != null) suffix,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
