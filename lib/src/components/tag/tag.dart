import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:tdesign_desktop_ui/tdesign_desktop_ui.dart';

/// 标签
/// 标签常用于标记、分类和选择
class TTag extends StatefulWidget {
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
    this.onClick,
    this.onClose,
    this.backgroundColor,
    this.textColor,
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
  final void Function()? onClick;

  /// 如果关闭按钮存在，点击关闭按钮时触发
  final void Function()? onClose;

  /// 背景色
  final Color? backgroundColor;

  /// 文本颜色
  final Color? textColor;

  @override
  State<TTag> createState() => _TTagState();
}

class _TTagState extends State<TTag> {
  bool _isHovered = false;
  bool _isFocused = false;

  _handleHovered(bool isHovered) {
    if (widget.theme == TTagTheme.link && !widget.disabled) {
      setState(() {
        _isHovered = isHovered;
      });
    }
  }

  _handleFocused(bool isFocused) {
    if (widget.theme == TTagTheme.link && !widget.disabled) {
      setState(() {
        _isFocused = isFocused;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = TTheme.of(context);
    var colorScheme = theme.colorScheme;

    var size = widget.size ?? theme.size;

    Color backgroundColor = colorScheme.bgColorComponent;
    Color textColor = colorScheme.textColorPrimary;

    // 样式
    switch (widget.theme) {
      case TTagTheme.defaultTheme:
        // 默认
        if (widget.disabled) {
          backgroundColor = colorScheme.bgColorComponentDisabled;
          textColor = colorScheme.textColorDisabled;
        }
        break;
      case TTagTheme.primary:
        // 主色
        switch (widget.variant) {
          case TTagVariant.dark:
            textColor = colorScheme.textColorAnti;
            backgroundColor = colorScheme.brandColor;
            break;
          case TTagVariant.light:
            textColor = colorScheme.brandColor;
            backgroundColor = colorScheme.brandColorLight;
            break;
          case TTagVariant.outline:
            textColor = colorScheme.brandColor;
            break;
        }
        break;
      case TTagTheme.warning:
        // 告警色
        switch (widget.variant) {
          case TTagVariant.dark:
            textColor = colorScheme.textColorAnti;
            backgroundColor = colorScheme.warningColor;
            break;
          case TTagVariant.light:
            textColor = colorScheme.warningColor;
            backgroundColor = colorScheme.warningColor1;
            break;
          case TTagVariant.outline:
            textColor = colorScheme.warningColor;
            break;
        }
        break;
      case TTagTheme.danger:
        // 错误色
        switch (widget.variant) {
          case TTagVariant.dark:
            textColor = colorScheme.textColorAnti;
            backgroundColor = colorScheme.errorColor;
            break;
          case TTagVariant.light:
            textColor = colorScheme.errorColor;
            backgroundColor = colorScheme.errorColor1;
            break;
          case TTagVariant.outline:
            textColor = colorScheme.errorColor;
            break;
        }
        break;
      case TTagTheme.success:
        // 成功色
        switch (widget.variant) {
          case TTagVariant.dark:
            textColor = colorScheme.textColorAnti;
            backgroundColor = colorScheme.successColor;
            break;
          case TTagVariant.light:
            textColor = colorScheme.successColor;
            backgroundColor = colorScheme.successColor1;
            break;
          case TTagVariant.outline:
            textColor = colorScheme.successColor;
            break;
        }
        break;
      case TTagTheme.link:
        if (widget.disabled) {
          backgroundColor = colorScheme.bgColorComponentDisabled;
          textColor = colorScheme.textColorDisabled;
        } else if (_isFocused) {
          backgroundColor = colorScheme.bgColorComponentActive;
          textColor = colorScheme.brandColorActive;
        } else if (_isHovered) {
          backgroundColor = colorScheme.bgColorComponentHover;
          textColor = colorScheme.brandColor;
        }
        break;
    }

    backgroundColor = widget.backgroundColor ?? backgroundColor;
    textColor = widget.textColor ?? textColor;

    // 高度
    double height = size.lazySizeOf(small: () => 22, medium: () => 24, large: () => 32);

    // 形状
    BoxDecoration decoration;
    switch (widget.shape) {
      case TTagShape.square:
        decoration = BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(TVar.borderRadiusDefault),
        );
        break;
      case TTagShape.round:
        decoration = BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(height / 2),
        );
        break;
      case TTagShape.mark:
        decoration = BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.horizontal(right: Radius.circular(height / 2)),
        );
        break;
    }

    Widget child = widget.child;
    if (widget.maxWidth != null) {
      child = LimitedBox(
        maxWidth: widget.maxWidth!,
        child: child,
      );
    }

    Widget? closeIcon;
    // close icon
    if (widget.closable) {
      closeIcon = _buildCloseIcon(colorScheme, theme);
    }

    Widget? icon;
    // icon
    if (widget.icon != null) {
      icon = Padding(
        padding: const EdgeInsets.only(right: 4),
        child: TAnimatedIcon(
          duration: TVar.animDurationBase,
          curve: TVar.animTimeFnEasing,
          size: theme.fontData.fontSizeBodyLarge,
          color: textColor,
          child: widget.icon!,
        ),
      );
    }

    child = TSpace(
      spacing: 0,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [icon, child, closeIcon],
    );

    child = GestureDetector(
      onTap: widget.disabled ? null : widget.onClick,
      onTapDown: (details) => _handleFocused(true),
      onTapUp: (details) => _handleFocused(false),
      child: AnimatedContainer(
        padding: EdgeInsets.symmetric(horizontal: TVar.spacer),
        height: height,
        duration: TVar.animDurationBase,
        decoration: decoration,
        child: DefaultTextStyle(
          style: TextStyle(
            fontFamily: theme.fontFamily,
            color: textColor,
            textBaseline: TextBaseline.alphabetic,
            height: 1.15,
            fontSize: theme.fontSize,
            overflow: TextOverflow.ellipsis,
          ),
          child: Center(child: child),
        ),
      ),
    );

    if (widget.theme == TTagTheme.link) {
      SystemMouseCursor cursor;
      if (widget.disabled) {
        cursor = SystemMouseCursors.noDrop;
      } else if (widget.theme == TTagTheme.link) {
        cursor = SystemMouseCursors.click;
      } else {
        cursor = SystemMouseCursors.basic;
      }

      return FocusableActionDetector(
        mouseCursor: cursor,
        onShowFocusHighlight: _handleFocused,
        onShowHoverHighlight: _handleHovered,
        enabled: !widget.disabled,
        child: child,
      );
    } else {
      return child;
    }
  }

  /// 构建关闭图标
  Widget _buildCloseIcon(TColorScheme colorScheme, TThemeData theme) {
    Color closeColor = colorScheme.textColorPlaceholder;
    Color closeHoverColor = colorScheme.textColorPrimary;

    if (widget.theme != TTagTheme.defaultTheme && widget.theme != TTagTheme.link) {
      if (widget.variant == TTagVariant.dark) {
        closeColor = colorScheme.fontWhite1;
        closeHoverColor = colorScheme.fontWhite2;
      } else if (widget.variant == TTagVariant.light || widget.variant == TTagVariant.outline) {
        switch (widget.theme) {
          case TTagTheme.defaultTheme:
            break;
          case TTagTheme.primary:
            closeColor = colorScheme.brandColor;
            closeHoverColor = colorScheme.brandColorHover;
            break;
          case TTagTheme.warning:
            closeColor = colorScheme.warningColor;
            closeHoverColor = colorScheme.warningColorHover;
            break;
          case TTagTheme.danger:
            closeColor = colorScheme.errorColor;
            closeHoverColor = colorScheme.errorColorHover;
            break;
          case TTagTheme.success:
            closeColor = colorScheme.successColor;
            closeHoverColor = colorScheme.successColorHover;
            break;
          case TTagTheme.link:
            break;
        }
      }
    }
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: _TagCloseIcon(
        size: theme.fontData.fontSizeBodyLarge,
        color: closeColor,
        hoverColor: closeHoverColor,
        disabled: widget.disabled,
        click: widget.onClose,
      ),
    );
  }
}

/// 标签close icon
class _TagCloseIcon extends StatefulWidget {
  const _TagCloseIcon({
    Key? key,
    required this.size,
    required this.color,
    required this.hoverColor,
    this.disabled = false,
    this.click,
  }) : super(key: key);

  /// icon大小
  final double size;

  /// icon颜色
  final Color color;

  /// 禁用状态
  final bool disabled;

  /// icon悬浮颜色
  final Color hoverColor;

  /// 点击
  final void Function()? click;

  @override
  State<_TagCloseIcon> createState() => _TagCloseIconState();
}

class _TagCloseIconState extends State<_TagCloseIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _handleHovered(true),
      onExit: (event) => _handleHovered(false),
      cursor: widget.disabled ? SystemMouseCursors.noDrop : SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.disabled ? null : widget.click,
        child: TAnimatedIcon(
          duration: TVar.animDurationBase,
          curve: TVar.animTimeFnEasing,
          size: widget.size,
          color: _isHovered ? widget.hoverColor : widget.color,
          child: const Icon(TIcons.close),
        ),
      ),
    );
  }

  /// 处理悬浮状态变更
  void _handleHovered(bool isHovered) {
    if (widget.disabled) {
      return;
    }
    setState(() {
      _isHovered = isHovered;
    });
  }
}
