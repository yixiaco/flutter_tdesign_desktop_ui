import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/src/components/common/dynamic_overflow.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';
import 'package:url_launcher/link.dart';

/// 面包屑
/// 显示当前页面在系统层级结构的位置，并能返回之前任意层级的页面。
class TBreadcrumb extends StatelessWidget {
  const TBreadcrumb({
    super.key,
    this.maxItemWidth,
    required this.options,
    this.separator,
    this.theme = TBreadcrumbTheme.light,
  });

  /// 单项最大宽度，超出后会以省略号形式呈现
  final double? maxItemWidth;

  /// 面包屑项
  final List<TBreadcrumbItemProps> options;

  /// 自定义分隔符
  final Widget? separator;

  /// 组件风格
  final TBreadcrumbTheme theme;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    // 文本、icon颜色
    var textColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return colorScheme.textColorDisabled;
      }
      if (states.contains(MaterialState.hovered) || states.contains(MaterialState.focused)) {
        return colorScheme.brandColor;
      }
      if (states.contains(MaterialState.selected)) {
        return colorScheme.textColorPrimary;
      }
      return colorScheme.textColorPlaceholder;
    });

    List<Widget> children = List.generate(options.length, (index) {
      var option = options[index];
      if (option.href != null) {
        Uri? uri;
        if ((uri = Uri.tryParse(option.href!)) != null) {
          return Link(
            uri: uri,
            target: option.target.linkTarget,
            builder: (context, followLink) {
              return _buildItem(context, option, index, textColor, theme, followLink: followLink);
            },
          );
        }
      }
      return _buildItem(context, option, index, textColor, theme);
    });

    return DefaultTextStyle(
      style: theme.fontData.fontBodyMedium,
      child: IconTheme(
        data: IconThemeData(
          color: colorScheme.textColorPlaceholder,
          size: theme.fontData.fontBodyMedium.fontSize,
        ),
        child: TSpace(
          spacing: TVar.spacer * .5,
          crossAxisAlignment: CrossAxisAlignment.center,
          separator: separator ?? const Icon(TIcons.chevronRight),
          breakLine: true,
          children: children,
        ),
      ),
    );
  }

  /// 构建item
  Widget _buildItem(
    BuildContext context,
    TBreadcrumbItemProps option,
    int index,
    MaterialStateProperty<Color> textColor,
    TThemeData theme, {
    VoidCallback? followLink,
  }) {
    Widget child = TMaterialStateButton(
      disabled: option.disabled,
      selected: index == options.length - 1,
      onTap: () {
        _handleClick(followLink, option, context);
      },
      builder: (context, states) {
        /// 消息浮层提示
        Widget child = DynamicOverflow(
          overflowWidget: TTooltip(
            disabled: option.disabled,
            richMessage: TextSpan(
              children: [
                WidgetSpan(
                  child: DefaultTextStyle.merge(
                    style: theme.fontData.fontBodyMedium,
                    child: IconTheme.merge(
                      data: IconThemeData(size: theme.fontData.fontSizeL),
                      child: option.child,
                    ),
                  ),
                ),
              ],
            ),
            child: option.child,
          ),
          children: [option.child],
        );
        return DefaultTextStyle(
          style: TextStyle(
            color: textColor.resolve(states),
            overflow: TextOverflow.ellipsis,
          ),
          child: IconTheme(
            data: IconThemeData(
              size: theme.fontData.fontSizeL,
              color: textColor.resolve(states),
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: option.maxWidth ?? maxItemWidth ?? 120,
              ),
              child: child,
            ),
          ),
        );
      },
    );
    return child;
  }

  /// 处理点击事件
  void _handleClick(VoidCallback? followLink, TBreadcrumbItemProps option, BuildContext context) {
    followLink?.call();
    option.onClick?.call();
    if (option.to != null) {
      var navigator = option.router ?? Navigator.of(context);
      if (option.replace) {
        navigator.pushReplacementNamed(option.to!);
      } else {
        navigator.pushNamed(option.to!);
      }
    }
  }
}
