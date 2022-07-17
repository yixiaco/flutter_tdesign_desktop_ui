import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/src/basic/ink_bevel_angle.dart';

import '../../tdesign_desktop_ui.dart';
import '../theme/button_theme.dart';
import 'borders.dart';

/// 按钮组件风格
enum TButtonThemeStyle {
  /// 默认色
  defaultStyle,

  /// 品牌色
  primary,

  /// 危险色
  danger,

  /// 告警色
  warning,

  /// 成功色
  success;

  T valueOf<T>({required T defaultStyle, required T primary, required T danger, required T warning, required T success}) {
    switch (this) {
      case TButtonThemeStyle.defaultStyle:
        return defaultStyle;
      case TButtonThemeStyle.primary:
        return primary;
      case TButtonThemeStyle.danger:
        return danger;
      case TButtonThemeStyle.warning:
        return warning;
      case TButtonThemeStyle.success:
        return success;
    }
  }

  T isDefaultOf<T>({required T defaultStyle, required T other}) {
    switch (this) {
      case TButtonThemeStyle.defaultStyle:
        return defaultStyle;
      case TButtonThemeStyle.primary:
        return other;
      case TButtonThemeStyle.danger:
        return other;
      case TButtonThemeStyle.warning:
        return other;
      case TButtonThemeStyle.success:
        return other;
    }
  }
}

/// 实现了填充按钮、描边按钮、虚框按钮、文字按钮
class _TButton extends ButtonStyleButton {
  const _TButton({
    Key? key,
    required VoidCallback? onPressed,
    VoidCallback? onLongPress,
    ValueChanged<bool>? onHover,
    ValueChanged<bool>? onFocusChange,
    ButtonStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    Clip clipBehavior = Clip.none,
    required Widget child,
    this.size,
    required this.variant,
    this.themeStyle,
    this.ghost,
  }) : super(
          key: key,
          onPressed: onPressed,
          onLongPress: onLongPress,
          onHover: onHover,
          onFocusChange: onFocusChange,
          style: style,
          focusNode: focusNode,
          autofocus: autofocus,
          clipBehavior: clipBehavior,
          child: child,
        );

  /// 组件尺寸。可选项：small/medium/large
  final TComponentSize? size;

  ///按钮形式，基础、线框、虚线、文字。可选项：base/outline/dashed/text
  final TButtonVariant variant;

  /// 组件风格. 可参考[TColors.blue]、[TColors.red]、[TColors.orange]、[TColors.green]
  /// 分别可代表，主题色、危险色、告警色、成功色
  final TButtonThemeStyle? themeStyle;

  /// 是否为幽灵按钮（镂空按钮）
  final bool? ghost;

  /// 按钮高度
  double btnHeight(TComponentSize size) {
    return size.sizeOf(small: 28, medium: 36, large: 44);
  }

  double btnFontSize(TComponentSize size) {
    return size.sizeOf(small: fontSizeS, medium: fontSizeBase, large: fontSizeL);
  }

  double btnIconSize(TComponentSize size) {
    return size.sizeOf(small: fontSizeBase, medium: fontSizeL, large: fontSizeXL);
  }

  double btnPaddingHorizontal(TComponentSize size) {
    return size.sizeOf(small: spacer, medium: spacer * 2, large: spacer * 3);
  }

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    var ttheme = TTheme.of(context);
    var theme = Theme.of(context);
    var colorScheme = ttheme.colorScheme;
    var buttonTheme = TButtonTheme.of(context);
    TComponentSize defaultSize = size ?? buttonTheme.size ?? ttheme.size;
    var buttonThemeStyle = themeStyle ?? buttonTheme.themeStyle ?? TButtonThemeStyle.defaultStyle;
    var isGhost = ghost ?? buttonTheme.ghost ?? ttheme.brightness == Brightness.dark;

    // 文本
    final MaterialStateProperty<TextStyle?> textStyle = MaterialStateProperty.resolveWith((states) {
      var odt = buttonThemeStyle.valueOf(
        defaultStyle: colorScheme.textColorPrimary,
        primary: colorScheme.brandColor,
        danger: colorScheme.errorColor,
        warning: colorScheme.warningColor,
        success: colorScheme.successColor,
      );
      if (states.contains(MaterialState.disabled)) {
        odt = buttonThemeStyle.valueOf(
          defaultStyle: colorScheme.textColorDisabled,
          primary: colorScheme.brandColorDisabled,
          danger: colorScheme.errorColorDisabled,
          warning: colorScheme.warningColorDisabled,
          success: colorScheme.successColorDisabled,
        );
      }
      if (states.contains(MaterialState.hovered) && variant.contain(outline: true, dashed: true)) {
        odt = buttonThemeStyle.valueOf(
          defaultStyle: colorScheme.brandColorHover,
          primary: colorScheme.brandColorHover,
          danger: colorScheme.errorColorHover,
          warning: colorScheme.warningColorHover,
          success: colorScheme.successColorHover,
        );
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed) && variant == TButtonVariant.outline) {
        odt = buttonThemeStyle.valueOf(
          defaultStyle: colorScheme.brandColorActive,
          primary: colorScheme.brandColorActive,
          danger: colorScheme.errorColorActive,
          warning: colorScheme.warningColorActive,
          success: colorScheme.successColorActive,
        );
      }
      return TextStyle(
        fontFamily: ttheme.fontFamily,
        fontSize: btnFontSize(defaultSize),
        color: variant.variantOf<Color?>(
          base: buttonThemeStyle.isDefaultOf(
            defaultStyle: odt,
            other: colorScheme.textColorAnti,
          ),
          outline: odt,
          dashed: odt,
          text: odt,
        ),
      );
    });

    // 边框
    final MaterialStateProperty<TBorderSide?> borderSide = MaterialStateProperty.resolveWith((states) {
      var themeStyleColor = buttonThemeStyle.valueOf(
        defaultStyle: colorScheme.borderLevel2Color,
        primary: colorScheme.brandColor,
        danger: colorScheme.errorColor,
        warning: colorScheme.warningColor,
        success: colorScheme.successColor,
      );
      if (states.contains(MaterialState.disabled)) {
        themeStyleColor = buttonThemeStyle.valueOf(
          defaultStyle: colorScheme.textColorDisabled,
          primary: colorScheme.brandColorDisabled,
          danger: colorScheme.errorColorDisabled,
          warning: colorScheme.warningColorDisabled,
          success: colorScheme.successColorDisabled,
        );
      }
      if (states.contains(MaterialState.hovered)) {
        themeStyleColor = buttonThemeStyle.valueOf(
          defaultStyle: colorScheme.brandColorHover,
          primary: colorScheme.brandColorHover,
          danger: colorScheme.errorColorHover,
          warning: colorScheme.warningColorHover,
          success: colorScheme.successColorHover,
        );
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        themeStyleColor = buttonThemeStyle.valueOf(
          defaultStyle: colorScheme.brandColorActive,
          primary: colorScheme.brandColorActive,
          danger: colorScheme.errorColorActive,
          warning: colorScheme.warningColorActive,
          success: colorScheme.successColorActive,
        );
      }
      return TBorderSide(
        width: 1,
        color: variant.variantOf(
          base: Colors.transparent,
          outline: themeStyleColor,
          dashed: themeStyleColor,
          text: Colors.transparent,
        ),
        dashed: variant == TButtonVariant.dashed,
      );
    });

    // 前景色
    final MaterialStateProperty<Color?> foregroundColor = MaterialStateProperty.resolveWith((states) {
      return null;
    });

    // 背景色
    final MaterialStateProperty<Color?> backgroundColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        colorBy(Color base) => variant.variantOf<Color?>(
              base: base,
              outline: colorScheme.bgColorComponentDisabled,
              dashed: colorScheme.bgColorComponentDisabled,
              text: Colors.transparent,
            );
        return buttonThemeStyle.valueOf(
          defaultStyle: colorBy(colorScheme.bgColorComponentDisabled),
          primary: colorBy(colorScheme.brandColorDisabled),
          danger: colorBy(colorScheme.errorColorDisabled),
          warning: colorBy(colorScheme.warningColorDisabled),
          success: colorBy(colorScheme.successColorDisabled),
        );
      }
      if (states.contains(MaterialState.hovered)) {
        colorBy(Color base) => variant.variantOf<Color?>(
              base: base,
              outline: colorScheme.bgColorSpecialComponent,
              dashed: colorScheme.bgColorSpecialComponent,
              text: colorScheme.bgColorContainerHover,
            );
        return buttonThemeStyle.valueOf(
          defaultStyle: colorBy(colorScheme.bgColorComponentHover),
          primary: colorBy(colorScheme.brandColorHover),
          danger: colorBy(colorScheme.errorColorHover),
          warning: colorBy(colorScheme.warningColorHover),
          success: colorBy(colorScheme.successColorHover),
        );
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        colorBy(Color base) => variant.variantOf<Color?>(
              base: base,
              outline: colorScheme.bgColorContainerActive,
              dashed: colorScheme.bgColorContainerActive,
              text: colorScheme.bgColorContainerActive,
            );
        return buttonThemeStyle.valueOf(
          defaultStyle: colorBy(colorScheme.bgColorComponentActive),
          primary: colorBy(colorScheme.brandColorActive),
          danger: colorBy(colorScheme.errorColorActive),
          warning: colorBy(colorScheme.warningColorActive),
          success: colorBy(colorScheme.successColorActive),
        );
      }
      colorBy(Color base) => variant.variantOf<Color?>(
            base: base,
            outline: colorScheme.bgColorSpecialComponent,
            dashed: colorScheme.bgColorSpecialComponent,
            text: Colors.transparent,
          );
      return buttonThemeStyle.valueOf(
        defaultStyle: colorBy(colorScheme.bgColorComponent),
        primary: colorBy(colorScheme.brandColor),
        danger: colorBy(colorScheme.errorColor),
        warning: colorBy(colorScheme.warningColor),
        success: colorBy(colorScheme.successColor),
      );
    });

    // 覆盖色
    final MaterialStateProperty<Color?> overlayColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) {
        return Colors.transparent;
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        var color = backgroundColor.resolve(states);
        return color;
      }
      return null;
    });

    // 鼠标样式
    final MaterialStateProperty<MouseCursor> mouseCursor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    return ButtonStyle(
      textStyle: textStyle,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(Colors.transparent),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(Colors.transparent),
      elevation: ButtonStyleButton.allOrNull<double>(0),
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(_scaledPadding(context, defaultSize)),
      minimumSize: ButtonStyleButton.allOrNull<Size>(Size(btnHeight(defaultSize), btnHeight(defaultSize))),
      fixedSize: ButtonStyleButton.allOrNull<Size>(null),
      maximumSize: ButtonStyleButton.allOrNull<Size>(Size.infinite),
      side: borderSide,
      shape: ButtonStyleButton.allOrNull<TRoundedRectangleBorder>(TRoundedRectangleBorder(
        side: TBorderSide(
          width: 1,
          color: colorScheme.borderLevel2Color,
          dashed: variant == TButtonVariant.dashed,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(borderRadius)),
      )),
      mouseCursor: mouseCursor,
      visualDensity: theme.visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkBevelAngle.splashFactory,
    );
  }

  EdgeInsetsGeometry _scaledPadding(BuildContext context, TComponentSize size) {
    var horizontal = btnPaddingHorizontal(size);
    return ButtonStyleButton.scaledPadding(
      EdgeInsets.symmetric(horizontal: horizontal),
      EdgeInsets.symmetric(horizontal: horizontal),
      EdgeInsets.symmetric(horizontal: horizontal / 2),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) {
    return TButtonTheme.of(context).baseStyle;
  }
}

///按钮变体枚举
enum TButtonVariant {
  /// 填充按钮
  base,

  /// 描边按钮
  outline,

  /// 虚框按钮
  dashed,

  /// 文字按钮
  text;

  /// 判断是否包含类型
  bool contain({
    bool base = false,
    bool outline = false,
    bool dashed = false,
    bool text = false,
  }) {
    switch (this) {
      case TButtonVariant.base:
        return base;
      case TButtonVariant.outline:
        return outline;
      case TButtonVariant.dashed:
        return dashed;
      case TButtonVariant.text:
        return text;
    }
  }

  /// 根据按钮形式，返回对应的值
  T variantOf<T>({required T base, required T outline, required T dashed, required T text}) {
    switch (this) {
      case TButtonVariant.base:
        return base;
      case TButtonVariant.outline:
        return outline;
      case TButtonVariant.dashed:
        return dashed;
      case TButtonVariant.text:
        return text;
    }
  }
}

/// 按钮
class TButton extends StatelessWidget {
  const TButton({
    Key? key,
    required this.onPressed,
    this.variant = TButtonVariant.base,
    this.enabled = true,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.themeStyle,
    this.ghost,
    this.size,
    required this.child,
  }) : super(key: key);

  ///按钮内容
  final Widget child;

  ///	点击时触发
  final VoidCallback? onPressed;

  ///按钮形式，基础、线框、虚线、文字。可选项：base/outline/dashed/text
  final TButtonVariant variant;

  final bool enabled;

  final VoidCallback? onLongPress;

  final ValueChanged<bool>? onHover;

  final ValueChanged<bool>? onFocusChange;

  final ButtonStyle? style;

  final FocusNode? focusNode;

  final bool autofocus;

  final Clip clipBehavior;

  /// 组件风格.
  final TButtonThemeStyle? themeStyle;

  /// 是否为幽灵按钮（镂空按钮）
  final bool? ghost;

  /// 组件尺寸。可选项：small/medium/large
  final TComponentSize? size;

  @override
  Widget build(BuildContext context) {
    var pressed = enabled ? onPressed ?? () {} : null;
    return _TButton(
      onPressed: pressed,
      onLongPress: onLongPress,
      onHover: onHover,
      onFocusChange: onFocusChange,
      style: style,
      focusNode: focusNode,
      autofocus: autofocus,
      clipBehavior: clipBehavior,
      variant: variant,
      themeStyle: themeStyle,
      size: size,
      ghost: ghost,
      child: child,
    );
  }
}
