import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 标签类型
enum TTagShape {
  /// 方形
  square,

  /// 圆角方形
  round,

  /// 标记型
  mark;
}

/// 组件风格
enum TTagTheme {
  /// 默认
  defaultTheme,

  /// 主色
  primary,

  /// 告警色
  warning,

  /// 错误色
  danger,

  /// 成功色
  success;
}

/// 标签风格变体
enum TTagVariant {
  /// [TTagTheme]非默认时，主色背景，白色前景
  dark,

  /// [TTagTheme]非默认时，半透明主色背景，主色前景
  light,

  /// [TTagTheme]非默认时，暗底色背景，主色前景
  outline;
}

/// 标签
class TTag extends StatelessWidget {
  const TTag({
    Key? key,
    this.closable = false,
    required this.child,
    this.disabled = false,
    this.icon,
    this.maxWidth,
    this.shape = TTagShape.square,
    this.size,
    this.theme = TTagTheme.defaultTheme,
    this.variant = TTagVariant.dark,
    this.click,
    this.onClose,
  }) : super(key: key);

  /// 标签是否可关闭
  final bool closable;

  /// 子组件
  final Widget child;

  /// 禁用状态
  final bool disabled;

  /// 标签中的图标，可自定义图标呈现
  final Widget? icon;

  /// 标签最大宽度，宽度超出后会出现省略号
  final double? maxWidth;

  /// 标签类型
  final TTagShape shape;

  /// 标签尺寸
  final TComponentSize? size;

  /// 组件风格
  final TTagTheme theme;

  /// 标签风格变体
  final TTagVariant variant;

  /// 点击时触发
  final void Function()? click;

  /// 如果关闭按钮存在，点击关闭按钮时触发
  final void Function()? onClose;

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var size = this.size ?? theme.size;

    Color? backgroundColor = colorScheme.bgColorComponent;
    Color? foregroundColor = colorScheme.textColorPrimary;

    switch (this.theme) {
      case TTagTheme.defaultTheme:
        // 默认
        break;
      case TTagTheme.primary:
        // 主色
        switch (variant) {
          case TTagVariant.dark:
            foregroundColor = colorScheme.textColorAnti;
            backgroundColor = colorScheme.brandColor;
            break;
          case TTagVariant.light:
            foregroundColor = colorScheme.brandColor;
            backgroundColor = colorScheme.brandColorLight;
            break;
          case TTagVariant.outline:
            foregroundColor = colorScheme.brandColor;
            break;
        }
        break;
      case TTagTheme.warning:
        // 告警色
        switch (variant) {
          case TTagVariant.dark:
            foregroundColor = colorScheme.textColorAnti;
            backgroundColor = colorScheme.warningColor;
            break;
          case TTagVariant.light:
            foregroundColor = colorScheme.warningColor;
            backgroundColor = colorScheme.warningColor1;
            break;
          case TTagVariant.outline:
            foregroundColor = colorScheme.warningColor;
            break;
        }
        break;
      case TTagTheme.danger:
        // 错误色
        switch (variant) {
          case TTagVariant.dark:
            foregroundColor = colorScheme.textColorAnti;
            backgroundColor = colorScheme.errorColor;
            break;
          case TTagVariant.light:
            foregroundColor = colorScheme.errorColor;
            backgroundColor = colorScheme.errorColor1;
            break;
          case TTagVariant.outline:
            foregroundColor = colorScheme.errorColor;
            break;
        }
        break;
      case TTagTheme.success:
        // 成功色
        switch (variant) {
          case TTagVariant.dark:
            foregroundColor = colorScheme.textColorAnti;
            backgroundColor = colorScheme.successColor;
            break;
          case TTagVariant.light:
            foregroundColor = colorScheme.successColor;
            backgroundColor = colorScheme.successColor1;
            break;
          case TTagVariant.outline:
            foregroundColor = colorScheme.successColor;
            break;
        }
        break;
    }

    return UnconstrainedBox(
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: TVar.spacer),
        height: size.lazySizeOf(small: () => 22, medium: () => 24, large: () => 32),
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(TVar.borderRadius),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            fontFamily: theme.fontFamily,
            color: foregroundColor,
            textBaseline: TextBaseline.alphabetic,
            height: 1.15,
            fontSize: theme.fontSize,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
