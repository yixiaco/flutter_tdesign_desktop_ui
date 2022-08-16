import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 文字提示风格
enum TTooltipTheme {
  /// 默认风格
  defaultTheme,

  /// 主色风格
  primary,

  /// 成功风格
  success,

  /// 错误风格
  danger,

  /// 警告风格
  warning,

  /// 亮色风格
  light;
}

/// 文字提示
/// 用于文字提示的气泡框
class TTooltip extends StatefulWidget {
  const TTooltip({
    Key? key,
    this.destroyOnClose = true,
    this.duration,
    this.placement = TPopupPlacement.top,
    this.showArrow = true,
    this.theme = TTooltipTheme.defaultTheme,
    this.message,
    this.trigger = TPopupTrigger.hover,
    this.padding,
    required this.child,
  }) : super(key: key);

  /// 是否在关闭浮层时销毁浮层
  final bool destroyOnClose;

  /// 用于设置提示默认显示多长时间之后消失。
  final Duration? duration;

  /// 浮层出现位置
  final TPopupPlacement placement;

  /// 是否显示浮层箭头
  final bool showArrow;

  /// 文字提示风格
  final TTooltipTheme theme;

  /// 提示消息
  final String? message;

  /// 触发方式
  final TPopupTrigger trigger;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 子组件
  final Widget child;

  @override
  State<TTooltip> createState() => _TTooltipState();
}

class _TTooltipState extends State<TTooltip> {
  @override
  Widget build(BuildContext context) {
    if (widget.message == null) {
      return widget.child;
    }
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    Color? backgroundColor;
    Color? textColor;
    switch (widget.theme) {
      case TTooltipTheme.defaultTheme:
        // tooltip 背景色不随组件库浅色/深色模式切换而改变，因此使用固定色值变量
        backgroundColor = colorScheme.gray12;
        textColor = colorScheme.textColorAnti;
        break;
      case TTooltipTheme.primary:
        backgroundColor = colorScheme.brandColorLight;
        textColor = colorScheme.brandColor;
        break;
      case TTooltipTheme.success:
        backgroundColor = colorScheme.successColorLight;
        textColor = colorScheme.successColor;
        break;
      case TTooltipTheme.danger:
        backgroundColor = colorScheme.errorColorLight;
        textColor = colorScheme.errorColor;
        break;
      case TTooltipTheme.warning:
        backgroundColor = colorScheme.warningColorLight;
        textColor = colorScheme.warningColor;
        break;
      case TTooltipTheme.light:
        backgroundColor = colorScheme.bgColorContainer;
        textColor = colorScheme.textColorPrimary;
        break;
    }

    var padding = widget.padding ?? EdgeInsets.symmetric(horizontal: TVar.spacer, vertical: TVar.spacerS);

    return TPopup(
      backgroundColor: backgroundColor,
      showArrow: widget.showArrow,
      placement: widget.placement,
      destroyOnClose: widget.destroyOnClose,
      trigger: widget.trigger,
      padding: padding,
      content: Text(
        widget.message!,
        style: TextStyle(
          fontSize: theme.fontSize,
          fontFamily: theme.fontFamily,
          color: textColor,
        ),
      ),
      child: widget.child,
    );
  }
}
