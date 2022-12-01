import 'package:flutter/material.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 定义按钮颜色变量
Map<String, Color> _variables(TColorScheme scheme) {
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
    'btn-text-variant-base-color': scheme.textColorAnti,
  };
}

/// 实现了填充按钮、描边按钮、虚框按钮、文字按钮
class _TButton extends StatelessWidget {
  const _TButton({
    this.size,
    required this.variant,
    required this.themeStyle,
    this.ghost,
    required this.shape,
    this.side,
    this.radius,
    required this.softWrap,
    this.child,
    this.onPressed,
    required this.disabled,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.style,
    this.focusNode,
    required this.autofocus,
    required this.clipBehavior,
  });

  ///按钮内容
  final Widget? child;

  ///	点击时触发
  final VoidCallback? onPressed;

  /// 是否禁用
  final bool disabled;

  /// 长按
  final VoidCallback? onLongPress;

  /// 鼠标经过
  final ValueChanged<bool>? onHover;

  /// 聚焦变更
  final ValueChanged<bool>? onFocusChange;

  /// 按钮样式
  final TButtonStyle? style;

  /// 焦点
  final FocusNode? focusNode;

  /// 自动聚焦
  final bool autofocus;

  /// 剪辑
  final Clip clipBehavior;

  /// 组件尺寸。可选项：small/medium/large
  final TComponentSize? size;

  ///按钮形式，基础、线框、虚线、文字。可选项：base/outline/dashed/text
  final TButtonVariant variant;

  /// 组件风格. 可参考[TColors.blue]、[TColors.red]、[TColors.orange]、[TColors.green]
  /// 分别可代表，主题色、危险色、告警色、成功色
  final TButtonThemeStyle themeStyle;

  /// 是否为幽灵按钮（镂空按钮）
  final bool? ghost;

  /// 预定义的一组按钮形状，可以通过[style.shape]进行覆盖
  /// 有 4 种：长方形、正方形、圆角长方形、圆形。可选项：rectangle/square/round/circle
  final TButtonShape shape;

  /// 边框
  final TBorderSide? side;

  /// 圆角
  final BorderRadiusGeometry? radius;

  /// 是否收紧包装
  final bool softWrap;

  /// padding大小
  double _btnPaddingHorizontal(TComponentSize size) {
    return size.sizeOf(small: TVar.spacer, medium: TVar.spacer * 2, large: TVar.spacer * 3);
  }

  @override
  Widget build(BuildContext context) {
    var buttonStyle = defaultStyleOf(context).merge(themeStyleOf(context)).merge(style);
    return Semantics(
      container: true,
      button: true,
      enabled: !disabled,
      child: TRipple(
        fixedRippleColor: buttonStyle.fixedRippleColor,
        enableFeedback: buttonStyle.enableFeedback,
        onHover: onHover,
        onLongPress: onLongPress,
        onFocusChange: onFocusChange,
        disabled: disabled,
        cursor: buttonStyle.mouseCursor,
        onTap: onPressed,
        autofocus: autofocus,
        focusNode: focusNode,
        builder: (context, states) {
          var foregroundColor = buttonStyle.foregroundColor?.resolve(states);
          var padding = buttonStyle.padding?.resolve(states);
          var textStyle = buttonStyle.textStyle?.resolve(states);
          var shape = buttonStyle.shape?.resolve(states);
          var side = buttonStyle.side?.resolve(states);
          shape = shape?.copyWith(side: side);

          return IconTheme(
            data: IconThemeData(color: foregroundColor),
            child: DefaultTextStyle(
              style: TextStyle(color: foregroundColor).merge(textStyle),
              child: AnimatedContainer(
                padding: padding,
                decoration: shape != null ? ShapeDecoration(shape: shape) : null,
                duration: const Duration(milliseconds: 200),
                child: Stack(
                  alignment: buttonStyle.alignment ?? Alignment.center,
                  children: [
                    if (child != null) child!,
                  ],
                ),
              ),
            ),
          );
        },
        afterBuilder: (context, states, child) {
          var fixedSize = buttonStyle.fixedSize?.resolve(states);
          var minimumSize = buttonStyle.minimumSize?.resolve(states);
          var maximumSize = buttonStyle.maximumSize?.resolve(states);
          var shape = buttonStyle.shape?.resolve(states);
          var side = buttonStyle.side?.resolve(states);
          var backgroundColor = buttonStyle.backgroundColor?.resolve(states);

          BoxConstraints effectiveConstraints = BoxConstraints(
            minWidth: minimumSize?.width ?? 0,
            minHeight: minimumSize?.height ?? 0,
            maxWidth: maximumSize?.width ?? double.infinity,
            maxHeight: maximumSize?.height ?? double.infinity,
          );
          if (fixedSize != null) {
            final Size size = effectiveConstraints.constrain(fixedSize);
            if (size.width.isFinite) {
              effectiveConstraints = effectiveConstraints.copyWith(
                minWidth: size.width,
                maxWidth: size.width,
              );
            }
            if (size.height.isFinite) {
              effectiveConstraints = effectiveConstraints.copyWith(
                minHeight: size.height,
                maxHeight: size.height,
              );
            }
          }
          shape = shape?.copyWith(side: side);
          child = Container(
            color: backgroundColor ?? Colors.transparent,
            child: child,
          );
          if (shape != null) {
            return ConstrainedBox(
              constraints: effectiveConstraints,
              child: ClipPath(
                clipper: ShapeBorderClipper(shape: shape),
                child: child,
              ),
            );
          }
          return child;
        },
      ),
    );
  }

  TButtonStyle defaultStyleOf(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var buttonTheme = TButtonTheme.of(context);
    TComponentSize defaultSize = size ?? buttonTheme.size ?? theme.size;
    var buttonThemeStyle = themeStyle;
    var isGhost = ghost ?? buttonTheme.ghost ?? false;
    var media = MediaQuery.of(context);
    var variables = _variables(colorScheme);
    var devicePixelRatio = media.devicePixelRatio;

    // 边框
    late MaterialStateProperty<TBorderSide?> borderSide;
    // 背景色
    late MaterialStateProperty<Color?> backgroundColor;
    // 前景色
    late MaterialStateProperty<Color?> foregroundColor;

    Color? resolve(String theme, Set<MaterialState> states, {bool ghost = false, String? defaultColor}) {
      if (states.contains(MaterialState.disabled)) {
        return variables['btn-color-$theme-disabled'];
      }
      if (states.contains(MaterialState.hovered)) {
        return variables['btn-color-$theme-hover'];
      }
      if ((states.contains(MaterialState.focused) || states.contains(MaterialState.pressed))) {
        return variables['btn-color-$theme-active'];
      }
      return variables[defaultColor] ?? variables['btn-color-$theme'];
    }

    // 动态前景色
    MaterialStateProperty<Color?> foregroundColorResolve(String theme, {bool ghost = false, String? defaultColor}) {
      return MaterialStateProperty.resolveWith(
          (states) => resolve(theme, states, ghost: ghost, defaultColor: defaultColor));
    }

    // 固定前景色
    MaterialStateProperty<Color?> foregroundColorFixedResolve(String color, {bool ghost = false}) {
      return MaterialStateProperty.resolveWith((states) => variables[color]);
    }

    // 动态边框
    MaterialStateProperty<TBorderSide?> borderSideResolve(String theme, {bool ghost = false}) {
      return MaterialStateProperty.resolveWith((states) {
        return TBorderSide(
          width: 1 / devicePixelRatio,
          color: resolve(theme, states, ghost: ghost) ?? Colors.transparent,
          dashed: variant == TButtonVariant.dashed,
        );
      });
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

    // 波纹颜色
    Color? fixedRippleColor;
    if (isGhost) {
      fixedRippleColor = colorScheme.gray10;
    } else {
      if (variant.contain(base: true)) {
        fixedRippleColor = buttonThemeStyle.valueOf(
          defaultStyle: variables['btn-color-gray-bg-active'],
          primary: variables['btn-color-primary-active'],
          danger: variables['btn-color-danger-active'],
          warning: variables['btn-color-warning-active'],
          success: variables['btn-color-success-active'],
        );
      } else {
        fixedRippleColor = variables['btn-color-white-bg-active'];
      }
    }

    // 鼠标样式
    final MaterialStateProperty<MouseCursor> mouseCursor = MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.disabled)) {
        return SystemMouseCursors.noDrop;
      }
      return SystemMouseCursors.click;
    });

    double btnHeight = defaultSize.sizeOf(small: 24, medium: 32, large: 40);
    var halfHeight = btnHeight / 2;
    var padding = softWrap ? EdgeInsets.zero : _scaledPadding(context, defaultSize);
    return TButtonStyle(
      textStyle: ButtonStyleButton.allOrNull<TextStyle>(theme.fontData.fontBody(defaultSize)),
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      fixedRippleColor: fixedRippleColor,
      // 内容如果是一个icon，则不要给padding
      padding: ButtonStyleButton.allOrNull<EdgeInsetsGeometry>(padding),
      fixedSize: ButtonStyleButton.allOrNull<Size>(shape.valueOf(
        rectangle: Size.fromHeight(btnHeight),
        square: Size.square(btnHeight),
        round: Size.fromHeight(btnHeight),
        circle: Size.square(btnHeight),
      )),
      side: MaterialStateProperty.resolveWith(
          (states) => MaterialStateProperty.resolveAs(side, states) ?? borderSide.resolve(states)),
      shape: ButtonStyleButton.allOrNull<TRoundedRectangleBorder>(TRoundedRectangleBorder(
        borderRadius: radius ??
            BorderRadius.circular(shape.valueOf(
              rectangle: TVar.borderRadiusDefault,
              square: TVar.borderRadiusDefault,
              round: halfHeight,
              circle: halfHeight,
            )),
      )),
      mouseCursor: mouseCursor,
      enableFeedback: true,
      alignment: Alignment.center,
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

  TButtonStyle? themeStyleOf(BuildContext context) {
    return TButtonTheme.of(context).style;
  }
}

/// 按钮
class TButton extends StatelessWidget {
  const TButton({
    super.key,
    this.onPressed,
    this.variant,
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
    this.side,
    this.radius,
    this.softWrap = false,
    this.type = TButtonType.button,
  });

  ///按钮内容
  final Widget? child;

  ///	点击时触发
  final VoidCallback? onPressed;

  ///按钮形式，基础、线框、虚线、文字。可选项：base/outline/dashed/text
  final TButtonVariant? variant;

  /// 是否禁用
  final bool disabled;

  /// 长按
  final VoidCallback? onLongPress;

  /// 鼠标经过
  final ValueChanged<bool>? onHover;

  /// 聚焦变更
  final ValueChanged<bool>? onFocusChange;

  /// 按钮样式
  final TButtonStyle? style;

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

  /// 边框
  final TBorderSide? side;

  /// 圆角
  final BorderRadiusGeometry? radius;

  /// 是否收紧包装
  final bool softWrap;

  /// 按钮类型
  final TButtonType type;

  /// icon大小
  double _btnIconSize(TThemeData theme, TComponentSize size) {
    return size.sizeOf(
      small: theme.fontData.fontSizeBase,
      medium: theme.fontData.fontSizeL,
      large: theme.fontData.fontSizeXL,
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;
    var buttonTheme = TButtonTheme.of(context);
    TComponentSize defaultSize = size ?? buttonTheme.size ?? theme.size;
    var themeStyle = this.themeStyle ?? buttonTheme.themeStyle ?? TButtonThemeStyle.defaultStyle;
    var variant = this.variant ?? buttonTheme.variant ?? TButtonVariant.base;

    Widget? iconWidget;
    List<Widget?> result = [];
    var disabled = this.disabled;
    var btnIconSize = _btnIconSize(theme, defaultSize);
    var softWrap = this.softWrap;
    if (loading) {
      disabled = true;
      Color? loadingColor;
      if (themeStyle == TButtonThemeStyle.defaultStyle) {
        loadingColor = colorScheme.textColorPrimary;
      } else if (variant == TButtonVariant.base) {
        loadingColor = colorScheme.textColorAnti;
      } else if (themeStyle == TButtonThemeStyle.primary) {
        loadingColor = colorScheme.brandColor;
      } else if (themeStyle == TButtonThemeStyle.warning) {
        loadingColor = colorScheme.warningColor;
      } else if (themeStyle == TButtonThemeStyle.danger) {
        loadingColor = colorScheme.errorColor;
      } else if (themeStyle == TButtonThemeStyle.success) {
        loadingColor = colorScheme.successColor;
      }
      iconWidget = TLoading(
        boxSize: Size.square(btnIconSize / 1.3),
        thickness: 2,
        color: loadingColor,
        size: TComponentSize.small,
      );
    } else if (icon != null) {
      softWrap = true;
      iconWidget = Icon(icon, size: btnIconSize);
    }
    result.add(iconWidget);
    result.add(child);

    return _TButton(
      disabled: disabled,
      onPressed: _onProxyPressed(context),
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
      side: side,
      radius: radius,
      softWrap: softWrap,
      child: TSpace(
        spacing: TVar.spacer,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: result,
      ),
    );
  }

  /// 返回代理事件
  VoidCallback? _onProxyPressed(BuildContext context) {
    switch (type) {
      case TButtonType.submit:
        var form = TForm.of(context);
        return () {
          form?.submit();
          onPressed?.call();
        };
      case TButtonType.reset:
        var form = TForm.of(context);
        return () {
          form?.reset();
          onPressed?.call();
        };
      case TButtonType.button:
        return onPressed;
    }
  }
}
