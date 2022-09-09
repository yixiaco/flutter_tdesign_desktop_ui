import 'package:flutter/material.dart';
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
    var px = 1 / MediaQuery.of(context).devicePixelRatio;
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

    Color defaultColor;
    Color disabledColor;
    Color activeColor;
    Color hoverColor;
    switch (this.theme) {
      case TLinkTheme.defaultTheme:
        defaultColor = colorScheme.textColorPrimary;
        hoverColor = colorScheme.brandColorHover;
        activeColor = colorScheme.brandColorActive;
        disabledColor = colorScheme.textColorDisabled;
        break;
      case TLinkTheme.primary:
        defaultColor = colorScheme.brandColor;
        hoverColor = colorScheme.brandColorHover;
        activeColor = colorScheme.brandColorActive;
        disabledColor = colorScheme.brandColorDisabled;
        break;
      case TLinkTheme.danger:
        defaultColor = colorScheme.errorColor;
        hoverColor = colorScheme.errorColorHover;
        activeColor = colorScheme.errorColorActive;
        disabledColor = colorScheme.errorColorDisabled;
        break;
      case TLinkTheme.warning:
        defaultColor = colorScheme.warningColor;
        hoverColor = colorScheme.warningColorHover;
        activeColor = colorScheme.warningColorActive;
        disabledColor = colorScheme.warningColorDisabled;
        break;
      case TLinkTheme.success:
        defaultColor = colorScheme.successColor;
        hoverColor = colorScheme.successColorHover;
        activeColor = colorScheme.successColorActive;
        disabledColor = colorScheme.successColorDisabled;
        break;
    }
    MaterialStateProperty<Color> color = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return disabledColor;
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        return activeColor;
      }
      if (states.contains(MaterialState.hovered) && hover == TLinkHover.color) {
        return hoverColor;
      }
      return defaultColor;
    });

    var borderSide = MaterialStateProperty.resolveWith((states) {
      if (underline) {
        return BorderSide(color: color.resolve(states), width: px);
      } else if (hover == TLinkHover.color) {
        return BorderSide.none;
      } else if (states.contains(MaterialState.hovered)) {
        return BorderSide(color: color.resolve(states), width: px);
      }
      return BorderSide.none;
    });

    return TMaterialStateBuilder(
      disabled: disabled,
      onTap: onClick,
      builder: (context, states) {
        var effectiveColor = color.resolve(states);
        return DefaultTextStyle(
          style: textStyle.merge(TextStyle(color: effectiveColor)),
          child: IconTheme(
            data: IconThemeData(size: textStyle.fontSize, color: effectiveColor),
            child: AnimatedContainer(
              duration: TVar.animDurationBase,
              decoration: BoxDecoration(border: Border(bottom: borderSide.resolve(states))),
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
