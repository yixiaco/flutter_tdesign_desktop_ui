part of '../tabs.dart';

/// 图标
class _TabIconButton extends StatelessWidget {
  const _TabIconButton({
    this.onTap,
    this.size,
    required this.icon,
    this.right = true,
    this.showShadow = false,
  });

  /// 点击事件
  final GestureTapCallback? onTap;

  /// 图标大小
  final TComponentSize? size;

  /// 图标
  final IconData icon;

  /// 是否靠右
  final bool right;

  /// 是否显示阴影
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var style = TTabsStyle.of(context);
    var colorScheme = theme.colorScheme;
    var size = this.size ?? theme.size;
    var iconButtonStyle = style.iconButtonStyle;
    var iconBgColor = MaterialStateProperty.resolveWith((states) {
      if (iconButtonStyle?.backgroundColor != null) {
        return MaterialStateProperty.resolveAs(iconButtonStyle!.backgroundColor, states);
      }
      if (states.contains(MaterialState.hovered)) {
        return colorScheme.bgColorSecondaryContainerHover;
      }
      return colorScheme.bgColorSecondaryContainer;
    });
    var borderSide = BorderSide(color: colorScheme.componentStroke);
    BoxShadow? boxShadow;
    Border border;
    if (right) {
      if (showShadow) {
        boxShadow = const BoxShadow(
          offset: Offset(-10, 0),
          blurRadius: 20,
          spreadRadius: 5,
          color: Color.fromRGBO(0, 0, 0, .05),
        );
      }
      border = Border(left: borderSide, bottom: borderSide);
    } else {
      if (showShadow) {
        boxShadow = const BoxShadow(
          offset: Offset(10, 0),
          blurRadius: 20,
          spreadRadius: 5,
          color: Color.fromRGBO(0, 0, 0, .05),
        );
      }
      border = Border(right: borderSide, bottom: borderSide);
    }
    boxShadow = iconButtonStyle?.boxShadow ?? boxShadow;
    border = iconButtonStyle?.border ?? border;
    var width = iconButtonStyle?.width ?? _kIconWidth;
    var height = iconButtonStyle?.height ?? size.sizeOf(small: 48, medium: 48, large: 64);
    return TMaterialStateButton(
      onTap: onTap,
      builder: (BuildContext context, Set<MaterialState> states) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: iconBgColor.resolve(states),
            border: border,
            boxShadow: [if (showShadow) boxShadow!],
          ),
          child: Icon(
            icon,
            size: iconButtonStyle?.iconSize ?? theme.fontData.fontSizeBodyLarge,
            color: MaterialStateProperty.resolveAs(iconButtonStyle?.iconColor ?? colorScheme.textColorSecondary, states),
          ),
        );
      },
    );
  }
}
