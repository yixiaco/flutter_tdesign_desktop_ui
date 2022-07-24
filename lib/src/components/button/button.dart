import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';


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
    Widget? child,
    this.size,
    required this.variant,
    this.themeStyle,
    this.ghost,
    required this.shape,
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

  /// 预定义的一组按钮形状，可以通过[style.shape]进行覆盖
  /// 有 4 种：长方形、正方形、圆角长方形、圆形。可选项：rectangle/square/round/circle
  final TButtonShape shape;

  /// 按钮高度
  double _btnHeight(TComponentSize size) {
    return size.sizeOf(small: 28, medium: 36, large: 44);
  }

  /// 字体大小
  double _btnFontSize(TComponentSize size) {
    return size.sizeOf(small: fontSizeS, medium: fontSizeBase, large: fontSizeL);
  }

  /// padding大小
  double _btnPaddingHorizontal(TComponentSize size) {
    return size.sizeOf(small: spacer, medium: spacer * 2, large: spacer * 3);
  }

  /// 定义按钮颜色变量
  static Map<String, Color> _variables(TColorScheme scheme) {
    return {
      // 状态色 - 主色
      'btn-color-primary': scheme.brandColor,
      'btn-color-primary-hover': scheme.brandColorHover,
      'btn-color-primary-active': scheme.brandColorActive,
      'btn-color-primary-disabled': scheme.brandColorDisabled,
      // 状态色 - 成功
      'btn-color-success': scheme.successColor,
      'btn-color-success-hover': scheme.successColorHover,
      'btn-color-success-active': scheme.successColorActive,
      'btn-color-success-disabled': scheme.successColorDisabled,
      // 状态色 - 警告
      'btn-color-warning': scheme.warningColor,
      'btn-color-warning-hover': scheme.warningColorHover,
      'btn-color-warning-active': scheme.warningColorActive,
      'btn-color-warning-disabled': scheme.warningColorDisabled,
      // 状态色 - 危险
      'btn-color-danger': scheme.errorColor,
      'btn-color-danger-hover': scheme.errorColorHover,
      'btn-color-danger-active': scheme.errorColorActive,
      'btn-color-danger-disabled': scheme.errorColorDisabled,
      // 状态色 - 白 背景
      // input 输入框需要在浅色主题下有默认白色背景，而在暗色等其他主题下 transparent 适配背景色，因此不使用通用背景 token
      'btn-color-white-bg': scheme.bgColorSpecialComponent,
      'btn-color-white-bg-hover': scheme.bgColorSpecialComponent,
      'btn-color-white-bg-active': scheme.bgColorContainerActive,
      'btn-color-white-bg-disabled': scheme.bgColorComponentDisabled,
      // 状态色 - 白 ghost
      'btn-color-white-ghost': scheme.textColorAnti,
      'btn-color-white-ghost-hover': scheme.brandColorHover,
      'btn-color-white-ghost-active': scheme.brandColorActive,
      'btn-color-white-ghost-disabled': scheme.borderLevel2Color,
      // 状态色 - 灰 背景
      'btn-color-gray-bg': scheme.bgColorComponent,
      'btn-color-gray-bg-hover': scheme.bgColorComponentHover,
      'btn-color-gray-bg-active': scheme.bgColorComponentActive,
      'btn-color-gray-bg-disabled': scheme.bgColorComponentDisabled,
      // 状态色 - 无框背景 - 既文字背景
      'btn-color-text-bg': Colors.transparent,
      'btn-color-text-bg-hover': scheme.bgColorContainerHover,
      'btn-color-text-bg-active': scheme.bgColorContainerActive,
      'btn-color-text-bg-disabled': Colors.transparent,
      // 状态色 - border 灰
      'btn-color-border-gray': scheme.borderLevel2Color,
      'btn-color-border-gray-hover': scheme.brandColorHover,
      'btn-color-border-gray-active': scheme.brandColorActive,
      'btn-color-border-gray-disabled': scheme.borderLevel2Color,
      // 状态色 - 文字 for 描边
      'btn-color-text': scheme.textColorPrimary,
      'btn-color-text-hover': scheme.brandColorHover,
      'btn-color-text-active': scheme.brandColorActive,
      'btn-color-text-disabled': scheme.textColorDisabled,
      // 状态色 - 灰字 for base default | 灰色文字按钮
      'btn-color-text-gray': scheme.textColorPrimary,
      'btn-color-text-gray-hover': scheme.textColorPrimary,
      'btn-color-text-gray-active': scheme.textColorPrimary,
      'btn-color-text-gray-disabled': scheme.textColorDisabled,

      'btn-color-none': Colors.transparent,
      'btn-color-none-hover': Colors.transparent,
      'btn-color-none-active': Colors.transparent,
      'btn-color-none-disabled': Colors.transparent,

      // 文本
      'btn-text-variant-base-color': scheme.textColorAnti
    };
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
    var media = MediaQuery.of(context);
    var variables = _variables(colorScheme);

    // 边框
    late MaterialStateProperty<TBorderSide?> borderSide;
    // 背景色
    late MaterialStateProperty<Color?> backgroundColor;
    // 前景色
    late MaterialStateProperty<Color?> foregroundColor;

    Color? resolve(String theme, Set<MaterialState> states, {bool ghost = false, String? defaultColor}) {
      if (states.contains(MaterialState.hovered)) {
        return variables['btn-color-$theme-hover'];
      }
      if ((states.contains(MaterialState.focused) || states.contains(MaterialState.pressed))) {
        return variables['btn-color-$theme-active'];
      }
      if (states.contains(MaterialState.disabled)) {
        return variables['btn-color-$theme-disabled'];
      }
      return variables[defaultColor] ?? variables['btn-color-$theme'];
    }

    // 动态前景色
    MaterialStateProperty<Color?> foregroundColorResolve(String theme, {bool ghost = false, String? defaultColor}) {
      return MaterialStateProperty.resolveWith((states) => resolve(theme, states, ghost: ghost, defaultColor: defaultColor));
    }

    // 固定前景色
    MaterialStateProperty<Color?> foregroundColorFixedResolve(String color, {bool ghost = false}) {
      return MaterialStateProperty.resolveWith((states) => variables[color]);
    }

    // 动态边框
    MaterialStateProperty<TBorderSide?> borderSideResolve(String theme, {bool ghost = false}) {
      return MaterialStateProperty.resolveWith((states) => TBorderSide(
            width: 1 / media.devicePixelRatio,
            color: resolve(theme, states, ghost: ghost) ?? Colors.transparent,
            dashed: variant == TButtonVariant.dashed,
          ));
    }

    // 动态背景
    MaterialStateProperty<Color?> backgroundColorResolve(String theme, {bool ghost = false}) {
      return MaterialStateProperty.resolveWith((states) => resolve(theme, states, ghost: ghost));
    }

    switch (variant) {
      // 填充按钮
      case TButtonVariant.base:
        foregroundColor = foregroundColorResolve('text-gray');
        backgroundColor = backgroundColorResolve('gray-bg');
        borderSide = borderSideResolve('gray-bg');
        switch (buttonThemeStyle) {
          case TButtonThemeStyle.defaultStyle:
            break;
          case TButtonThemeStyle.primary:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('primary', ghost: true);
              borderSide = borderSideResolve('primary', ghost: true);
            } else {
              foregroundColor = foregroundColorFixedResolve('btn-text-variant-base-color');
              backgroundColor = backgroundColorResolve('primary');
              borderSide = borderSideResolve('primary');
            }
            break;
          case TButtonThemeStyle.danger:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('danger', ghost: true);
              borderSide = borderSideResolve('danger', ghost: true);
            } else {
              foregroundColor = foregroundColorFixedResolve('btn-text-variant-base-color');
              backgroundColor = backgroundColorResolve('danger');
              borderSide = borderSideResolve('danger');
            }
            break;
          case TButtonThemeStyle.warning:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('warning', ghost: true);
              borderSide = borderSideResolve('warning', ghost: true);
            } else {
              foregroundColor = foregroundColorFixedResolve('btn-text-variant-base-color');
              backgroundColor = backgroundColorResolve('warning');
              borderSide = borderSideResolve('warning');
            }
            break;
          case TButtonThemeStyle.success:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('success', ghost: true);
              borderSide = borderSideResolve('success', ghost: true);
            } else {
              foregroundColor = foregroundColorFixedResolve('btn-text-variant-base-color');
              backgroundColor = backgroundColorResolve('success');
              borderSide = borderSideResolve('success');
            }
            break;
        }
        if (isGhost) {
          backgroundColor = MaterialStateProperty.resolveWith((states) => Colors.transparent);
        }
        break;
      // 描边按钮
      case TButtonVariant.outline:
        if (isGhost) {
          backgroundColor = backgroundColorResolve('none', ghost: true);
          foregroundColor = foregroundColorResolve('white-ghost', ghost: true);
          borderSide = borderSideResolve('white-ghost', ghost: true);
        } else {
          foregroundColor = foregroundColorResolve('text');
          backgroundColor = backgroundColorResolve('white-bg');
          borderSide = borderSideResolve('border-gray');
        }
        switch (buttonThemeStyle) {
          case TButtonThemeStyle.defaultStyle:
            break;
          case TButtonThemeStyle.primary:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('primary', ghost: true);
              borderSide = borderSideResolve('primary', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('primary');
              borderSide = borderSideResolve('primary');
            }
            break;
          case TButtonThemeStyle.danger:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('danger', ghost: true);
              borderSide = borderSideResolve('danger', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('danger');
              borderSide = borderSideResolve('danger');
            }
            break;
          case TButtonThemeStyle.warning:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('warning', ghost: true);
              borderSide = borderSideResolve('warning', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('warning');
              borderSide = borderSideResolve('warning');
            }
            break;
          case TButtonThemeStyle.success:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('success', ghost: true);
              borderSide = borderSideResolve('success', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('success');
              borderSide = borderSideResolve('success');
            }
            break;
        }
        break;
      // 虚框按钮
      case TButtonVariant.dashed:
        if (isGhost) {
          backgroundColor = backgroundColorResolve('none', ghost: true);
          foregroundColor = foregroundColorResolve('white-ghost', ghost: true);
          borderSide = borderSideResolve('white-ghost', ghost: true);
        } else {
          foregroundColor = foregroundColorResolve('text');
          backgroundColor = backgroundColorResolve('white-bg');
          borderSide = borderSideResolve('border-gray');
        }
        switch (buttonThemeStyle) {
          case TButtonThemeStyle.defaultStyle:
            break;
          case TButtonThemeStyle.primary:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('primary', ghost: true);
              borderSide = borderSideResolve('primary', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('primary');
              borderSide = borderSideResolve('primary');
            }
            break;
          case TButtonThemeStyle.danger:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('danger', ghost: true);
              borderSide = borderSideResolve('danger', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('danger');
              borderSide = borderSideResolve('danger');
            }
            break;
          case TButtonThemeStyle.warning:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('warning', ghost: true);
              borderSide = borderSideResolve('warning', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('warning');
              borderSide = borderSideResolve('warning');
            }
            break;
          case TButtonThemeStyle.success:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('success', ghost: true);
              borderSide = borderSideResolve('success', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('success');
              borderSide = borderSideResolve('success');
            }
            break;
        }
        break;
      // 文字按钮
      case TButtonVariant.text:
        foregroundColor = foregroundColorResolve('text-gray');
        backgroundColor = backgroundColorResolve('text-bg');
        borderSide = borderSideResolve('none');
        if (isGhost) {
          backgroundColor = backgroundColorResolve('none', ghost: true);
          foregroundColor = foregroundColorResolve('white-ghost');
          borderSide = borderSideResolve('text-bg');
        }
        switch (buttonThemeStyle) {
          case TButtonThemeStyle.defaultStyle:
            break;
          case TButtonThemeStyle.primary:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('primary', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('primary');
            }
            break;
          case TButtonThemeStyle.danger:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('danger', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('danger');
            }
            break;
          case TButtonThemeStyle.warning:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('warning', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('warning');
            }
            break;
          case TButtonThemeStyle.success:
            if (isGhost) {
              foregroundColor = foregroundColorResolve('success', ghost: true);
            } else {
              foregroundColor = foregroundColorResolve('success');
            }
            break;
        }
        break;
    }

    // 覆盖色
    final MaterialStateProperty<Color?> overlayColor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.hovered)) {
        return Colors.transparent;
      }
      if (states.contains(MaterialState.focused) || states.contains(MaterialState.pressed)) {
        if (isGhost) {
          return colorScheme.gray10;
        }
        if (variant.contain(base: true)) {
          return buttonThemeStyle.valueOf(
            defaultStyle: variables['btn-color-gray-bg-active'],
            primary: variables['btn-color-primary-active'],
            danger: variables['btn-color-danger-active'],
            warning: variables['btn-color-warning-active'],
            success: variables['btn-color-success-active'],
          );
        } else {
          if (!states.contains(MaterialState.disabled)) {
            return variables['btn-color-white-bg-active'];
          }
        }
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

    var btnHeight = _btnHeight(defaultSize);
    var halfHeight = btnHeight / 2;
    return ButtonStyle(
      textStyle: ButtonStyleButton.allOrNull<TextStyle>(TextStyle(
        fontFamily: ttheme.fontFamily,
        fontSize: _btnFontSize(defaultSize),
      )),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      overlayColor: overlayColor,
      shadowColor: ButtonStyleButton.allOrNull<Color>(Colors.transparent),
      surfaceTintColor: ButtonStyleButton.allOrNull<Color>(Colors.transparent),
      elevation: ButtonStyleButton.allOrNull<double>(0),
      // 内容如果是一个icon，则不要给padding
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(child is Icon ? EdgeInsets.zero : _scaledPadding(context, defaultSize)),
      minimumSize: ButtonStyleButton.allOrNull<Size>(Size.square(btnHeight)),
      fixedSize: ButtonStyleButton.allOrNull<Size>(shape.valueOf(
        rectangle: Size.fromHeight(halfHeight),
        square: Size.square(halfHeight),
        round: Size.fromHeight(halfHeight),
        circle: Size.square(halfHeight),
      )),
      maximumSize: ButtonStyleButton.allOrNull<Size>(Size.fromHeight(btnHeight)),
      side: borderSide,
      shape: ButtonStyleButton.allOrNull<TRoundedRectangleBorder>(TRoundedRectangleBorder(
        borderRadius: BorderRadius.circular(shape.valueOf(
          rectangle: borderRadius,
          square: borderRadius,
          round: halfHeight,
          circle: halfHeight,
        )),
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
    var horizontal = _btnPaddingHorizontal(size);
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

/// 按钮
class TButton extends StatelessWidget {
  const TButton({
    Key? key,
    this.onPressed,
    this.variant = TButtonVariant.base,
    this.disabled = false,
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
    this.shape = TButtonShape.rectangle,
    this.icon,
    this.loading = false,
    this.child,
  }) : super(key: key);

  ///按钮内容
  final Widget? child;

  ///	点击时触发
  final VoidCallback? onPressed;

  ///按钮形式，基础、线框、虚线、文字。可选项：base/outline/dashed/text
  final TButtonVariant variant;

  /// 是否禁用
  final bool disabled;

  /// 长按
  final VoidCallback? onLongPress;

  /// 鼠标经过
  final ValueChanged<bool>? onHover;

  /// 聚焦变更
  final ValueChanged<bool>? onFocusChange;

  /// 按钮样式
  final ButtonStyle? style;

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  /// 剪辑
  final Clip clipBehavior;

  /// 组件风格.
  final TButtonThemeStyle? themeStyle;

  /// 是否为幽灵按钮（镂空按钮）
  final bool? ghost;

  /// 组件尺寸。可选项：small/medium/large
  final TComponentSize? size;

  /// 预定义的一组按钮形状，可以通过[style.shape]进行覆盖
  /// 有 4 种：长方形、正方形、圆角长方形、圆形。可选项：rectangle/square/round/circle
  final TButtonShape shape;

  /// icon
  final IconData? icon;

  /// 是否显示为加载状态
  final bool loading;

  /// icon大小
  double _btnIconSize(TComponentSize size) {
    return size.sizeOf(small: fontSizeBase, medium: fontSizeL, large: fontSizeXL);
  }

  @override
  Widget build(BuildContext context) {
    var ttheme = TTheme.of(context);
    var buttonTheme = TButtonTheme.of(context);
    TComponentSize defaultSize = size ?? buttonTheme.size ?? ttheme.size;

    Widget? iconWidget;
    Widget? result;
    var disabled0 = disabled;
    var btnIconSize = _btnIconSize(defaultSize);
    if (loading) {
      disabled0 = true;
      // TODO: 实现自定义加载指示器
      iconWidget = ConstrainedBox(
        constraints: BoxConstraints.expand(width: btnIconSize / 1.5, height: btnIconSize / 1.5),
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation<Color>(ttheme.colorScheme.gray7),
        ),
      );
    } else if (icon != null) {
      iconWidget = Icon(icon, size: btnIconSize);
    }
    if (iconWidget != null && child != null) {
      result = Row(
        children: [iconWidget, const SizedBox(width: spacer), child!],
      );
    } else {
      result = iconWidget ?? child;
    }
    var pressed = disabled0 ? null : onPressed ?? () {};

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
      shape: shape,
      child: result,
    );
  }
}
