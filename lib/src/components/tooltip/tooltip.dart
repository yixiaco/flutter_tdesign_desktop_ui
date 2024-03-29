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
class TTooltip extends StatelessWidget {
  const TTooltip({
    super.key,
    this.disabled = false,
    this.destroyOnClose = true,
    this.duration,
    this.placement = TPopupPlacement.top,
    this.showArrow = true,
    this.theme = TTooltipTheme.defaultTheme,
    this.message,
    this.richMessage,
    this.trigger = TPopupTrigger.hover,
    this.padding,
    required this.child,
  });

  /// 是否禁用组件
  final bool disabled;

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

  /// 富文本消息，比[message]优先级高
  final InlineSpan? richMessage;

  /// 触发方式
  final TPopupTrigger trigger;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 子组件
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (message == null && richMessage == null) {
      return child;
    }
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    Color? backgroundColor;
    Color? textColor;
    switch (this.theme) {
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

    var padding = this.padding ?? EdgeInsets.symmetric(horizontal: TVar.spacer, vertical: TVar.spacerS);

    var textStyle = TextStyle(
      fontSize: theme.fontSize,
      fontFamily: theme.fontFamily,
      color: textColor,
    );
    Widget content;
    if (richMessage != null) {
      content = Text.rich(richMessage!);
    } else {
      content = Text(message!);
    }
    content = DefaultTextStyle(
      style: textStyle,
      child: IconTheme(
        data: IconThemeData(size: theme.fontSize, color: textColor),
        child: content,
      ),
    );
    return TPopup(
      disabled: disabled,
      style: TPopupStyle(
        backgroundColor: backgroundColor,
        padding: padding,
      ),
      showArrow: showArrow,
      placement: placement,
      destroyOnClose: destroyOnClose,
      trigger: trigger,
      content: content,
      child: child,
    );
  }
}
